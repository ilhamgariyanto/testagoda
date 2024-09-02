<?php

namespace App\Http\Controllers;

use App\Models\Cities;
use App\Models\Hotels;
use App\Models\TouristSpot;
// use Illuminate\Container\Attributes\DB;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class HotelController extends Controller
{

    public function search(Request $request)
    {
        $query = $request->input('query');
        $cityId = $request->input('cityId');
        $minPrice = $request->input('minPrice');
        $maxPrice = $request->input('maxPrice');
        $rating = $request->input('rating');
        $radius = $request->input('radius', 2); // Ambil radius dari request, default 2 km

        try {
            $hotelsQuery = Hotels::query();

            if ($cityId) {
                $hotelsQuery->where(
                    'city_id',
                    $cityId
                );
            }

            if (!is_null($minPrice) && is_numeric($minPrice)) {
                $hotelsQuery->where('price', '>=', $minPrice);
            }

            if (!is_null($maxPrice) && is_numeric($maxPrice)) {
                $hotelsQuery->where('price', '<=', $maxPrice);
            }

            if (!is_null($rating) && is_numeric($rating)) {
                $hotelsQuery->where('rating', '=', $rating);
            }

            $hotels = $hotelsQuery->get();

            $touristSpot = null;

            if ($query) {
                // Cari kota
                $citiesQuery = Cities::query();
                $citiesQuery->where('name', 'ILIKE', "%$query%");
                $cities = $citiesQuery->get();

                // Cari tempat wisata
                $touristSpotsQuery = TouristSpot::query();
                $touristSpotsQuery->where('name', 'ILIKE', "%$query%");
                $touristSpot = $touristSpotsQuery->first();

                // Filter hotel terdekat jika ada tempat wisata
                if ($touristSpot) {
                    $touristSpotLatitude = $touristSpot->latitude;
                    $touristSpotLongitude = $touristSpot->longitude;

                    $hotels = $hotels->filter(function ($hotel) use ($touristSpotLatitude, $touristSpotLongitude, $radius) {
                        $distance = $this->calculateDistance(
                            $hotel->latitude,
                            $hotel->longitude,
                            $touristSpotLatitude,
                            $touristSpotLongitude
                        );
                        return $distance <= $radius; // Filter berdasarkan radius
                    });
                }

                return response()->json([
                    'status' => 'success',
                    'data' => [
                        'cities' => $cities->toArray(),
                        'hotels' => $hotels->toArray(),
                        'touristSpot' => $touristSpot ? $touristSpot->toArray() : null
                    ],
                    'message' => 'Search results retrieved successfully.'
                ], 200);
            }

            $cities = $cityId ? Cities::where('id', $cityId)->get() : collect();

            return response()->json([
                'status' => 'success',
                'data' => [
                    'cities' => $cities->toArray(),
                    'hotels' => $hotels->toArray(),
                    'touristSpot' => $touristSpot ? $touristSpot->toArray() : null
                ],
                'message' => 'Search results retrieved successfully.'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'An error occurred while fetching results: ' . $e->getMessage()
            ], 500);
        }
    }

    private function calculateDistance($latitudeFrom, $longitudeFrom, $latitudeTo, $longitudeTo)
    {
        $earthRadius = 6371; // Radius Bumi dalam kilometer

        $latFrom = deg2rad($latitudeFrom);
        $lonFrom = deg2rad($longitudeFrom);
        $latTo = deg2rad($latitudeTo);
        $lonTo = deg2rad($longitudeTo);

        $latDelta = $latTo - $latFrom;
        $lonDelta = $lonTo - $lonFrom;

        $angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) +
            cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));
        return $angle * $earthRadius;
    }


    public function show($id)
    {
        try {

            $hotel = Hotels::with('details')->findOrFail($id);

            $cityId = $hotel->city_id;

            $hotelsInCity = Hotels::where('city_id', $cityId)
                ->where('id', '!=', $id)
                ->get();

            $radius = 2;
            $latitude = $hotel->latitude;
            $longitude = $hotel->longitude;

            $touristSpots = TouristSpot::select('*')
                ->selectRaw('
                    6371 * acos(
                        cos(radians(?)) * cos(radians(latitude)) *
                        cos(radians(longitude) - radians(?)) +
                        sin(radians(?)) * sin(radians(latitude))
                    ) AS distance', [$latitude, $longitude, $latitude])
                ->whereRaw('
                    6371 * acos(
                        cos(radians(?)) * cos(radians(latitude)) *
                        cos(radians(longitude) - radians(?)) +
                        sin(radians(?)) * sin(radians(latitude))
                    ) < ?', [$latitude, $longitude, $latitude, $radius])
                ->orderBy('distance')
                ->get();

            return view('hotel-detail', [
                'hotel' => $hotel,
                'hotelsInCity' => $hotelsInCity,
                'touristSpots' => $touristSpots
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'An error occurred while fetching hotel details: ' . $e->getMessage()
            ], 500);
        }
    }
}

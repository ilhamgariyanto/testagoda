<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TouristSpot;

class TouristSpotController extends Controller
{
    /**
     * Display a listing of all tourist spots.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $touristSpots = TouristSpot::all();
        return view('tourist-spots.index', ['touristSpots' => $touristSpots]);
    }

    /**
     * Display the specified tourist spot.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $touristSpot = TouristSpot::findOrFail($id);
        return view('tourist-spots.show', ['touristSpot' => $touristSpot]);
    }

    /**
     * Display tourist spots near a given location.
     *
     * @param  float  $latitude
     * @param  float  $longitude
     * @param  float  $radius
     * @return \Illuminate\Http\Response
     */
    public function nearby($latitude, $longitude, $radius = 2)
    {
        $touristSpots = TouristSpot::select('*')
            ->selectRaw('(6371 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) AS distance', [$latitude, $longitude, $latitude])
            ->having('distance', '<', $radius)
            ->orderBy('distance')
            ->get();

        return response()->json($touristSpots);
    }
}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 40px;
        }
        .rating-star {
            cursor: pointer;
            color: #ddd;
            font-size: 24px;
            margin-right: 5px;
        }
        .rating-star.selected {
            color: gold;
        }
        #map {
            height: 500px;
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .result-item {
            cursor: pointer;
            padding: 15px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            transition: background-color 0.3s ease;
        }
        .result-item:hover {
            background-color: #f1f1f1;
        }
        .star-rating i {
            color: #ffdd57;
        }
        #search-button {
            box-shadow: 0px 2px 5px rgba(0, 123, 255, 0.5);
        }
        a {
            color: inherit;
            text-decoration: none;
        }
        a:hover {
            color: #007bff;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="col">
        </div>
        <div class="col-md-6">
            <input type="text" id="search-input" class="form-control mb-2" placeholder="Search for cities">
            <button id="search-button" class="btn btn-primary mb-5">Search</button>
        </div>
        <div class="row">
            <div class="col-md-3">
                <p>Your Budget</p>
                <div class="mb-1">
                    <label for="min-price">Min Price</label>
                    <input type="number" id="min-price" class="form-control" placeholder="Min Price">
                </div>
                <div class="mb-1">
                    <label for="max-price">Max Price</label>
                    <input type="number" id="max-price" class="form-control" placeholder="Max Price">
                </div>
                <p>Rating</p>
                <div id="rating-filter" class="form-control">
                    <span data-value="1" class="rating-star"><i class="fa fa-star"></i></span>
                    <span data-value="2" class="rating-star"><i class="fa fa-star"></i></span>
                    <span data-value="3" class="rating-star"><i class="fa fa-star"></i></span>
                    <span data-value="4" class="rating-star"><i class="fa fa-star"></i></span>
                    <span data-value="5" class="rating-star"><i class="fa fa-star"></i></span>
                </div>
            </div>
            <div class="col-md-4">
                <div id="search-results">
                    <h3>Hotels</h3>
                    <div id="hotel-results"></div>
                </div>
            </div>
            <div class="col-md-5">
                <div id="map"></div>
            </div>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        var map = L.map('map').setView([0, 0], 2);
        var markers = [];

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        let selectedCityId = null;
        let selectedTouristSpot = null;
        let minPrice = null;
        let maxPrice = null;
        let selectedRating = null;
        let radius = 2;

        $('#search-input').autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: '/search',
                    method: 'GET',
                    data: { query: request.term },
                    success: function(data) {
                        var results = [];
                        if (data.status === 'success') {
                            var cities = data.data.cities || [];
                            cities.forEach(function(city) {
                                results.push({
                                    label: city.name + ' (City)',
                                    value: city.name,
                                    type: 'city',
                                    id: city.id,
                                    lat: city.latitude || 0,
                                    lng: city.longitude || 0
                                });
                            });

                            var touristSpots = data.data.touristSpot ? [data.data.touristSpot] : [];
                            touristSpots.forEach(function(spot) {
                                results.push({
                                    label: spot.name + ' (Tourist Spot)',
                                    value: spot.name,
                                    type: 'touristSpot',
                                    id: spot.id,
                                    lat: spot.latitude,
                                    lng: spot.longitude
                                });
                            });
                        }
                        response(results);
                    },
                    error: function(error) {
                        console.error('Error fetching search results', error);
                    }
                });
            },
            select: function(event, ui) {
                selectedCityId = null;
                selectedTouristSpot = null;

                markers.forEach(function(marker) {
                    map.removeLayer(marker);
                });
                markers = [];

                $('#hotel-results').empty();

                if (ui.item.type === 'city') {
                    selectedCityId = ui.item.id;
                    map.setView([ui.item.lat, ui.item.lng], 12);
                    fetchHotelsByCity();
                } else if (ui.item.type === 'touristSpot') {
                    selectedTouristSpot = ui.item;
                    map.setView([ui.item.lat, ui.item.lng], 14);
                    fetchHotelsByTouristSpot();
                }

                if (ui.item.lat && ui.item.lng) {
                    L.marker([ui.item.lat, ui.item.lng])
                        .addTo(map)
                        .bindPopup('<b>' + ui.item.label + '</b>')
                        .openPopup();
                }
            }
        });


        $('#min-price, #max-price').on('input', function() {
            minPrice = $('#min-price').val() || null;
            maxPrice = $('#max-price').val() || null;
            if (selectedCityId) {
                fetchHotelsByCity();
            } else if (selectedTouristSpot) {
                fetchHotelsByTouristSpot();
            }
        });

        $('#rating-filter .rating-star').on('click', function() {
            selectedRating = $(this).data('value');
            $('#rating-filter .rating-star').removeClass('selected');
            $(this).addClass('selected');
            if (selectedCityId) {
                fetchHotelsByCity();
            } else if (selectedTouristSpot) {
                fetchHotelsByTouristSpot();
            }
        });

        function fetchHotelsByCity() {
            $.ajax({
                url: '/search',
                method: 'GET',
                data: {
                    cityId: selectedCityId,
                    minPrice: minPrice,
                    maxPrice: maxPrice,
                    rating: selectedRating
                },
                success: function(response) {
                    $('#hotel-results').empty();
                    if (response.status === 'success') {
                        var hotels = response.data.hotels || [];
                        displayHotels(hotels);


                        markers.forEach(function(marker) {
                            map.removeLayer(marker);
                        });
                        markers = [];

                        hotels.forEach(function(hotel) {
                            var marker = L.marker([hotel.latitude, hotel.longitude])
                                .addTo(map)
                                .bindPopup('<b>' + hotel.name + '</b>')
                                .openPopup();
                            markers.push(marker);
                        });
                    } else {
                        $('#hotel-results').append('<div>No hotels found.</div>');
                    }
                },
                error: function(error) {
                    console.error('Error fetching hotels', error);
                }
            });
        }

        function fetchHotelsByTouristSpot() {
            $.ajax({
                url: '/search',
                method: 'GET',
                data: {
                    query: selectedTouristSpot.value,
                    minPrice: minPrice,
                    maxPrice: maxPrice,
                    rating: selectedRating,
                    radius: radius
                },
                success: function(response) {
                    $('#hotel-results').empty();
                    if (response.status === 'success') {
                        var hotels = response.data.hotels || {};
                        displayHotels(hotels);

                        markers.forEach(function(marker) {
                            map.removeLayer(marker);
                        });
                        markers = [];

                        Object.keys(hotels).forEach(function(hotelId) {
                            var hotel = hotels[hotelId];
                            var marker = L.marker([hotel.latitude, hotel.longitude])
                                .addTo(map)
                                .bindPopup('<b>' + hotel.name + '</b>')
                                .openPopup();
                            markers.push(marker);
                        });
                    } else {
                        $('#hotel-results').append('<div>No hotels found near the selected tourist spot.</div>');
                    }
                },
                error: function(error) {
                    console.error('Error fetching hotels by tourist spot', error);
                }
            });
        }

        function displayHotels(hotels) {
            var hotelList = $('#hotel-results');
            hotelList.empty();

            Object.keys(hotels).forEach(function(hotelId) {
                var hotel = hotels[hotelId];

                var hotelHtml = '<div class="hotel-item">';
                hotelHtml += '<h4><a href="/hotels/' + hotel.id + '">' + hotel.name + '</a></h4>';
                hotelHtml += '<p>Address: ' + hotel.address + '</p>';
                hotelHtml += '<p>Price: ' + hotel.price + '</p>';
                hotelHtml += '<p>Rating: ' + generateRatingStars(hotel.rating) + '</p>';
                hotelHtml += '</div>';

                hotelList.append(hotelHtml);
            });
        }

        function generateRatingStars(rating) {
            var stars = '';
            for (var i = 0; i < rating; i++) {
                stars += '⭐';
            }
            return stars;
        }
    });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

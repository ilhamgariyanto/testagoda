<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $hotel->name }} - Hotel Details</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            margin: 20px;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            color: #0056b3;
        }
        .hotel-item {
            padding: 15px;
            margin-bottom: 15px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            background-color: #ffffff;
            transition: background-color 0.3s ease;
        }
        .hotel-item:hover {
            background-color: #f1f1f1;
        }
        .card {
            border-radius: 0.75rem;
        }
        #map {
            height: 500px;
            margin-top: 20px;
            border-radius: 0.75rem;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div id="hotels-in-city">
                    @if($hotelsInCity->isEmpty())
                        <p>No other hotels found in this city.</p>
                    @else
                        @foreach($hotelsInCity as $otherHotel)
                            <div class="hotel-item">
                                <h4><a href="/hotels/{{ $otherHotel->id }}">{{ $otherHotel->name }}</a></h4>
                                <p><strong>Address:</strong> {{ $otherHotel->address }}</p>
                                <p><strong>Price:</strong> ${{ $otherHotel->price }}</p>
                                <p><strong>Rating:</strong> {{ $otherHotel->rating }} / 5</p>
                            </div>
                        @endforeach
                    @endif
                </div>
            </div>
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3>{{ $hotel->name }}</h3>
                    </div>
                    <div class="card-body">
                        <p><strong>Address:</strong> {{ $hotel->address }}</p>
                        <p><strong>Price:</strong> Rp. {{ $hotel->price }}</p>
                        <p><strong>Rating:</strong> {{ $hotel->rating }} / 5</p>
                        @if($hotel->details)
                            <div>
                                <div class="card">
                                    <div class="card-header bg-secondary text-white">
                                        <h3>Description</h3>
                                    </div>
                                    <div class="card-body">
                                        <p>{{ $hotel->details->description }}</p>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="card mt-2">
                                    <div class="card-header bg-secondary text-white">
                                        <h3>Facilities</h3>
                                    </div>
                                    <div class="card-body">
                                        <ul>
                                            @foreach(explode(',', $hotel->details->facilitases) as $facility)
                                                <li>{{ $facility }}</li>
                                            @endforeach
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        @else
                            <p>No details available.</p>
                        @endif
                        <div id="map"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        $(document).ready(function() {
            var map = L.map('map').setView([{{ $hotel->latitude }}, {{ $hotel->longitude }}], 15);

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);

            L.marker([{{ $hotel->latitude }}, {{ $hotel->longitude }}])
                .addTo(map)
                .bindPopup('<b>{{ $hotel->name }}</b><br>{{ $hotel->address }}<br>Price: Rp. {{ $hotel->price }}')
                .openPopup();

            L.circle([{{ $hotel->latitude }}, {{ $hotel->longitude }}], {
                color: 'blue',
                fillColor: '#blue',
                fillOpacity: 0.1,
                radius: 2000
            }).addTo(map);

            var redIcon = L.divIcon({
                className: 'custom-icon',
                html: '<svg width="25" height="41" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 25 41"><path d="M12.5 0L25 20.5H0L12.5 0z" fill="red"/><path d="M12.5 25l12.5 15.5H0L12.5 25z" fill="red"/><circle cx="12.5" cy="20.5" r="12" fill="red"/></svg>',
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34]
            });

            @foreach($touristSpots as $spot)
                L.marker([{{ $spot->latitude }}, {{ $spot->longitude }}], { icon: redIcon })
                    .addTo(map)
                    .bindPopup('<b>{{ $spot->name }}</b><br>{{ $spot->description }}')
            @endforeach
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

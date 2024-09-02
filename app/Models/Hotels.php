<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Hotels extends Model
{
    use HasFactory;

    protected $table = 'hotels';

    protected $fillable = [
        'city_id',
        'name',
        'address',
        'latitude',
        'longitude',
        'stars',
        'phone',
        'email',
        'website',
    ];

    public function city()
    {
        return $this->belongsTo(Cities::class, 'city_id');
    }

    public function details()
    {
        return $this->hasOne(HotelDetails::class, 'hotel_id');
    }

    public function prices()
    {
        return $this->hasMany(HotelPrices::class, 'hotel_id');
    }

    public function bookings()
    {
        return $this->hasMany(HotelBookings::class, 'hotel_id');
    }
}

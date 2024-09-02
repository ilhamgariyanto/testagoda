<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HotelBookings extends Model
{
    use HasFactory;

    protected $table = 'hotel_bookings';

    protected $fillable = [
        'hotel_id',
        'user_id',
        'price_id',
        'room_count',
        'check_in_date',
        'check_out_date',
        'total_price',
        'booking_status',
    ];

    public function hotel()
    {
        return $this->belongsTo(Hotels::class, 'hotel_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function price()
    {
        return $this->belongsTo(HotelPrices::class, 'price_id');
    }

    public function payments()
    {
        return $this->hasMany(Payments::class, 'booking_id');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HotelPrices extends Model
{
    use HasFactory;

    protected $table = 'hotel_prices';

    protected $fillable = [
        'hotel_id',
        'room_type',
        'price_per_night',
        'description',
        'start_date',
        'end_date',
    ];

    public function hotel()
    {
        return $this->belongsTo(Hotels::class, 'hotel_id');
    }
}

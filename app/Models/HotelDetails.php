<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HotelDetails extends Model
{
    use HasFactory;

    protected $table = 'hotel_details';

    protected $fillable = [
        'hotel_id',
        'description',
        'facilities',
        'additional_info',
    ];

    public function hotel()
    {
        return $this->belongsTo(Hotels::class, 'hotel_id');
    }
}

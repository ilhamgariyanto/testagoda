<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TouristSpot extends Model
{
    // Menentukan nama tabel jika berbeda dari konvensi Laravel
    protected $table = 'tourist_spots';

    // Menentukan kolom yang dapat diisi secara massal
    protected $fillable = [
        'name',
        'description',
        'latitude',
        'longitude'
    ];

    // Jika diperlukan, tambahkan relasi dengan model lain di sini
}

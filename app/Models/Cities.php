<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cities extends Model
{

    use HasFactory;

    protected $table = 'cities';

    protected $fillable = [
        'category_id',
        'name',
        'state',
        'country',
        'latitude',
        'longitude',
    ];

    public function category()
    {
        return $this->belongsTo(CityCategories::class, 'category_id');
    }

    public function hotels()
    {
        return $this->hasMany(Hotels::class, 'city_id');
    }
}

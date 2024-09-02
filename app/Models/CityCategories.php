<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CityCategories extends Model
{
    use HasFactory;

    protected $table = 'city_categories';

    protected $fillable = [
        'name',
    ];

    public function cities()
    {
        return $this->hasMany(Cities::class, 'category_id');
    }
}

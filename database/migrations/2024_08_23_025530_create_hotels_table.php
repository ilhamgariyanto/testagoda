<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('hotels', function (Blueprint $table) {
            $table->id('id');
            $table->foreignId('city_id')->nullable()->constrained('cities')->onDelete('set null');
            $table->string('name', 100);
            $table->text('address');
            $table->decimal('latitude', 9, 6)->nullable();
            $table->decimal('longitude', 9, 6)->nullable();
            $table->decimal('price', 10, 2); // Harga hotel
            $table->text('description')->nullable(); // Deskripsi hotel
            $table->integer('rating')->default(0); // Rating hotel, misalnya dari 1 hingga 5
            $table->string('phone', 20)->nullable();
            $table->string('email', 100)->nullable();
            $table->string('website', 100)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('hotels');
    }
};

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
        Schema::create('hotel_prices', function (Blueprint $table) {
            $table->id('id');
            $table->foreignId('hotel_id')->constrained('hotels')->onDelete('cascade');
            $table->string('room_type', 50);
            $table->decimal('price_per_night', 10, 2);
            $table->text('description')->nullable();
            $table->date('start_date');
            $table->date('end_date');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('hotel_prices');
    }
};

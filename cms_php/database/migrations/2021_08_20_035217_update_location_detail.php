<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateLocationDetail extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('locations', function (Blueprint $table) {
            $table->string('image')->nullable()->change();
            $table->string('description')->default('description');
            $table->timeTz('from')->default('07:00:00');
            $table->timeTz('to')->default('09:00:00');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('locations', function (Blueprint $table) {
            $table->string('image')->nullable(false)->change();
            $table->dropColumn(['description', 'from', 'to']);
        });
    }
}

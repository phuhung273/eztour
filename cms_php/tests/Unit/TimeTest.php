<?php

namespace Tests\Unit;

use App\Helpers\TimeHelper;
use PHPUnit\Framework\TestCase;

class TimeTest extends TestCase
{
    /**
     * A basic unit test example.
     *
     * @return void
     */
    public function test_conflict_time_range()
    {
        $this->assertTrue(TimeHelper::isNotConflictWithHisRange('6:00 am', '9:00 am', '12:00:00', '15:00:00'));
        $this->assertTrue(TimeHelper::isNotConflictWithHisRange('6:00 am', '9:00 am', '09:00:00', '15:00:00'));
        $this->assertTrue(TimeHelper::isNotConflictWithHisRange('9:00 am', '12:00 pm', '06:00:00', '09:00:00'));
        $this->assertFalse(TimeHelper::isNotConflictWithHisRange('6:00 am', '9:00 am', '06:00:00', '15:00:00'));
        $this->assertFalse(TimeHelper::isNotConflictWithHisRange('9:00 am', '12:00 pm', '06:00:00', '15:00:00'));
        $this->assertFalse(TimeHelper::isNotConflictWithHisRange('9:00 am', '12:00 pm', '06:00:00', '12:00:00'));
    }
}

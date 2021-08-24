<?php

namespace App\View\Components;

use Illuminate\View\Component;

class MenuItem extends Component
{
    public $routeName;
    public $label;

    /**
     * Create a new component instance.
     *
     * @param $routeName
     * @param $label
     */
    public function __construct($routeName, $label)
    {
        $this->routeName = $routeName;
        $this->label = $label;
    }

    /**
     * Get the view / contents that represents the component.
     *
     * @return \Illuminate\View\View
     */
    public function render()
    {
        return view('layouts.menu-item');
    }
}
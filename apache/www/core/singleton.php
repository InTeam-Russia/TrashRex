<?php

namespace core;

trait singleton
{
    private static $instance = null;
    public static function getInstance() {
        static $instance;
        if(is_null($instance)) {
            $instance = new self;
        }
        return $instance;
    }
}
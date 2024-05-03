<?php

namespace core;

class propertyException extends \Exception
{
    private $data;
    // Redefine the exception so message isn't optional
    public function __construct($message, $data = null, $code = 0, \Throwable $previous = null) {
        // some code
        $this->data = $data;
        // make sure everything is assigned properly
        parent::__construct($message, $code, $previous);
    }

    // custom string representation of object
    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

    public function getData() {
        return $this->data;
    }

}
<?php

namespace controllers;

use core\frontend;
use models\client;
use models\company;
use models\user;

class auth
{
    public static function whoami() {
        $me = user::getMe();
        if(is_null($me)) {
            echo frontend::getInstance()->getResponseJson([
                'role' => 'guest'
            ]);
            return;
        }
        $result = [
            'id'   => $me->id,
            'email' => $me->email,
            'role' => $me->role,
        ];

        switch($authorised['role']) {
            case 'company':
                $result['data'] = company::get($authorised['id']);
                break;
            case 'client':
                $result['data'] = client::get($authorised['id']);
                break;
        }
    }
}
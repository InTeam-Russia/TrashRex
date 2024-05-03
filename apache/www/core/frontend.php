<?php

namespace core;

use \core\singleton;

enum responseType {
    case OK;
    case InvalidMethod;
    case InvalidProperty;
    case NotAuthorized;
    case NoAccess;
    case NotFound;
    case InternalError;
}


class frontend
{
    use singleton;
    public function parseRequestBody(string $requestJson) : mixed {
        return json_decode($requestJson);
    }
    public function responseTypeToCode(responseType $type) : int {
        switch($type) {
            case responseType::OK:
                return 200;
            case responseType::InvalidMethod:
                return 400;
            case responseType::InvalidProperty:
                return 400;
            case responseType::NotAuthorized:
                return 401;
            case responseType::NoAccess:
                return 403;
            case responseType::NotFound:
                return 404;
            default:
                return 500;

        }
    }
    public function getResponseJson(mixed $responseBody, responseType $type = responseType::OK) : string {
        http_response_code($this->responseTypeToCode($type));
        return json_encode($responseBody);
    }

    public function getErrorJson(responseType $type, $message = null, mixed $aditonal_info = []) : string {
        http_response_code($this->responseTypeToCode($type));
        $body = [];
        if(!is_null($message)) {
            $body["message"] = $message;
        }
        $body = array_merge($body, $aditonal_info);
        return json_encode($body);
    }

}
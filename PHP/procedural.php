<?php

function procedural (array $arr, int $number): array
{
    // No need check array and integer types. Because we already defined types on above.

    // Create return array ...
    $response = array(
        "message" => "Calculated values",
        "arraySum" => 0,
        "arrayAverage" => 0,
        "multiplyingSum" => 0,
    );


    //Check array empty status ...
    if(empty($arr)){ $response["message"] = "There is no element in array. Calculation cannot be completed."; return $response; }

    // Check array value's integer status ...
    foreach($arr as $value) {
        if(!is_int($value)){
            $response["message"] = "There is a non-integer value in the array or empty array. Calculation cannot be completed.";
            $response["multiplyingSum"] = 0;
            return $response;
        }
        $response["multiplyingSum"] += $number;
    }

    // Calculate array sum ...
    $response["arraySum"] = array_sum($arr);

    // Calculate array average ...
    $response["arrayAverage"] = round(array_sum($arr) / count($arr),2);

    // Return calculated values ...
    return $response;
}

print_r(procedural(array(32,42,42,34,234,36,4,5764,4432,45,34,354,53,64,354,3), 345));
<?php

/*
QUESTION: What does this do to $var? you can describe with words or give a sample input ($var) and output ($res).

With RegEx we can select some of the values.
It has no effect on the $val variable. Because preg_replace does not change the value of the source variable.
However, we can assign the newly changed value to the new variable if we want.
This RegEx selector deletes all alphanumeric letters in the $val variable.
The result of the variable $res will be the new value, which contains only numeric values.

*/

$val = "2374yvbo87qybvroq8e7ryboqew8vnrq@#$@ED#$%^TERF12";
$res = preg_replace("/[^0-9.\-]/", "", $val);

echo '$val: ' . $val . ' ---------- $res: ' . $res;
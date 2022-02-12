<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("../php/dbconnectsql.php");

$code = $_POST['code'];
$name = $_POST['name'];
$prodesc = $_POST['prodesc'];
$quantity = $_POST['quantity'];
$price = $_POST['price'];
$encoded_string = $_POST['image'];


$sqlinsert= "INSERT INTO `products`(`code`, `name`, `prodesc`, `quantity`, `price`) VALUES ('$code','$name','$prodesc','$quantity','$price')";

if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = $code;
    $decoded_string = base64_decode($encoded_string);
    $path = '../images/product/'.$filename.'.png';
    $is_written = file_put_contents($path, $decoded_string);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    echo $response;
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>
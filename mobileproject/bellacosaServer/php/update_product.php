<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("../php/dbconnectsql.php");
$procode =$_POST['procode'];
$proid = $_POST['proid'];
$proname = $_POST['proname'];
$prodesc = $_POST['prodesc'];
$proprice = $_POST['proprice'];
$proquan = $_POST['proquan'];

if (isset($_POST['image'])) {
    $encoded_string = $_POST['image'];
}
$sqlupdate = "UPDATE products SET name='$proname', prodesc ='$prodesc', price='$proprice',quantity='$proquan' WHERE  id = '$proid'";
if ($conn->query($sqlupdate) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    if (!empty($encoded_string)) {
        $decoded_string = base64_decode($encoded_string);
        $path = '../images/product/' . $procode . '.png';
        $is_written = file_put_contents($path, $decoded_string);
    }
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
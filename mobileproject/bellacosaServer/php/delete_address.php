<?php
include_once("../php/dbconnectsql.php");
$email = $_POST['email'];
$name= $_POST['name'];
$address = $_POST['address'];
$phone = $_POST['phone'];

$sqldelete = "DELETE FROM address  WHERE email = '$email' AND name = '$name' AND address = '$address' AND phone = '$phone'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Failed";
}
?>
<?php
include_once("../php/dbconnectsql.php");
$email = $_POST['email'];
$product_id = $_POST['product_id'];

$sqldelete = "DELETE FROM cart WHERE email='$email' AND code = '$product_id'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Failed";
}
?>
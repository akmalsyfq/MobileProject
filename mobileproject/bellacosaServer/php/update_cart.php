<?php
include_once("../php/dbconnectsql.php");
$email = $_POST['email'];
$product_id = $_POST['product_id'];
$op = $_POST['op'];
$qty = $_POST['qty'];

if ($op == "addcart") {
    $sqlupdatecart = "UPDATE cart SET cartquan = cartquan +1 WHERE code = '$product_id' AND email = '$email'";
    if ($conn->query($sqlupdatecart) === TRUE) {
        echo "Success";
    } else {
        echo "Failed";
    }
}
if ($op == "removecart") {
    if ($qty == 1) {
        echo "Failed";
    } else {
        $sqlupdatecart = "UPDATE cart SET cartquan = cartquan -1 WHERE code = '$product_id' AND email = '$email'";
        if ($conn->query($sqlupdatecart) === TRUE) {
            echo "Success";
        } else {
            echo "Failed";
        }
    }
}
?>
<?php
include_once("../php/dbconnectsql.php");
$email = $_POST['email'];
$name= $_POST['name'];
$address = $_POST['address'];
$phone = $_POST['phone'];

$sqlcheckaddress = "SELECT * FROM address WHERE email = '$email' AND name = '$name' AND address = '$address' AND phone = '$phone'"; 
$resultcheck = $conn->query($sqlcheckaddress);
    if ($resultcheck->num_rows != 0) {
          echo "Already Exist";
        }
else{
$sqladdaddress = "INSERT INTO address (name, address, phone,email ) VALUES ('$name', '$address', '$phone','$email')";
            if ($conn->query($sqladdaddress) === TRUE) {
                echo "Success";
            } else {
                echo "Failed";
            }
    
}
?>
<?php
error_reporting(0);
include_once("../php/dbconnectsql.php");
$email = $_GET['email'];
$otp = $_GET['otp'];

$sqlverify = "SELECT * FROM users WHERE email = '$email' AND otp = '$otp'";
//cho $sqlverify;
$result = $conn->query($sqlverify);

if ($result->num_rows > 0)
{
   $newotp = '1';
   $sqlupdate = "UPDATE users SET otp = '$newotp' WHERE email = '$email'";
  if ($conn->query($sqlupdate) === TRUE){
        echo "Verification Success";
        echo "Welcome to Bellacosa! Happy Shopping!!";
  }else{
      echo "failed";
  }
}
else{
echo"failed";}
 
?>
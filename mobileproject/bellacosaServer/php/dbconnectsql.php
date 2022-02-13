<?php
$servername = "localhost";
$username = "";
$password = "";
$dbname = "ppdkpcom_bellacosashopdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>

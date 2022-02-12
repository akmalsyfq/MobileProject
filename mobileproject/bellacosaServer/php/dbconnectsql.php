<?php
$servername = "localhost";
$username = "ppdkpcom_akmal";
$password = "pw9z*IxM9o.S";
$dbname = "ppdkpcom_bellacosashopdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
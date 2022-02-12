<?php
include_once("../php/dbconnectsql.php");

$sqlloadrepot = "SELECT * FROM payment";

$result = $conn->query($sqlloadrepot);

$total = 0.0;
if ($result->num_rows > 0) {
    $response['report'] = array();
    $response['price'] = array();
    while ($row = $result->fetch_assoc()) {
        $rplist[payid] = $row['payid'];
        $rplist[payreceipt] = $row['payreceipt'];
        $rplist[payown] = $row['payown'];
        $rplist[paypaid] = $row['paypaid'];
        $total += $row['paypaid'];
        $money[total] = $total;
       
        array_push($response['report'], $rplist);
        
       
    } array_push($response['price'], $money);
   //  array_push($res['price'], $money);
    echo json_encode($response);
 //  echo json_encode($res);
} else {
    echo "nodata";
}

?>
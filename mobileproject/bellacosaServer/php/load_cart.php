<?php
include_once("../php/dbconnectsql.php");
$email = $_POST['email'];

$sqlloadcart = "SELECT * FROM cart INNER JOIN products ON cart.code = products.code WHERE cart.email =  '$email'";

$result = $conn->query($sqlloadcart);

$total = 0.0;
if ($result->num_rows > 0) {
    $response['cart'] = array();
    $response['price'] = array();
    while ($row = $result->fetch_assoc()) {
        $prlist[product_id] = $row['code'];
        $prlist[product_name] = $row['name'];
        $prlist[product_price] = $row['price'];
        $prlist[cartqty] = $row['cartquan'];
        $quan = $row['price']*$row['cartquan'];
        $total = $total + $quan;
        $money[total] = $total;
       
        array_push($response['cart'], $prlist);
        
       
  
        
     //$prlist[total] = $total;
    } array_push($response['price'], $money);
   //  array_push($res['price'], $money);
    echo json_encode($response);
 //  echo json_encode($res);
} else {
    echo "nodata";
}

?>
<?php
include_once("../php/dbconnectsql.php");

$sqlloadproduct= "SELECT * FROM `products`";
$result=$conn->query($sqlloadproduct);
if ($result->num_rows>0){
    $response["products"]=array();
    while($row =$result->fetch_assoc()) {
        $prlist=array();
        $prlist['id']=$row['id'];
        $prlist['code']=$row['code'];
        $prlist['name']=$row['name'];
        $prlist['prodesc']=$row['prodesc'];
        $prlist['quantity']=$row['quantity'];
        $prlist['price']=$row['price'];
        $prlist['rate']=$row['rate'];
        array_push($response["products"],$prlist);
    }
    echo json_encode($response);
}else{
    echo "no data";
}
?>
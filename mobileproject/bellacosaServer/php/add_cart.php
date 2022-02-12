<?php
include_once("../php/dbconnectsql.php");
$email = $_POST['email'];
$product_id = $_POST['product_id'];

$sqlcheckstock = "SELECT * FROM products WHERE code = '$product_id' ";

$resultstock = $conn->query($sqlcheckstock);
if ($resultstock->num_rows > 0) {
     while ($row = $resultstock ->fetch_assoc()){
            $sqlcheckcart = "SELECT * FROM cart WHERE code = '$product_id' AND email = '$email'"; 
            $resultcart = $conn->query($sqlcheckcart);
            if ($resultcart->num_rows == 0) {
                  $sqladdtocart = "INSERT INTO cart (email, code, cartquan) VALUES ('$email','$product_id','1')";
                if ($conn->query($sqladdtocart) === TRUE) {
                    echo "Success";
                } else {
                    echo "Failed to add";
                }
            } else { 
                 $sqlupdatecart = "UPDATE cart SET cartquan = cartquan +1 WHERE code = '$product_id' AND email = '$email'";
                if ($conn->query($sqlupdatecart) === TRUE) {
                    echo "Success";
                } else {
                    echo "Failed to add";
                }
            }
        
    }
}else{
    echo "Failed woi";
}

?>
<?php
error_reporting(0);
include_once("../php/dbconnectpdo.php");

$email = $_GET['email'];
$mobile = $_GET['mobile'];
$amount = $_GET['amount'];

$data = array(
    'id' =>  $_GET['billplz']['id'],
    'paid_at' => $_GET['billplz']['paid_at'] ,
    'paid' => $_GET['billplz']['paid'],
    'x_signature' => $_GET['billplz']['x_signature']
);

$paidstatus = $_GET['billplz']['paid'];
if ($paidstatus == "true"){
    $paidstatus = "Success";
}else{
    $paidstatus = "Failed";
}
$receiptid = $_GET['billplz']['id'];
$signing = '';
foreach ($data as $key => $value) {
    $signing.= 'billplz'.$key . $value;
    if ($key === 'paid') {
        break;
    } else {
        $signing .= '|';
    }
}

$signed= hash_hmac('sha256', $signing, 'S-HBjSQG03fdRC4irkYTZbNg');

if ($signed === $data['x_signature']) {
   
    if ($paidstatus == "Success") {
    $sqlinsertpayment = "INSERT INTO `payment`(`payreceipt`, `payown`, `paypaid`) VALUES ('$receiptid','$email','$amount')";
        $sqlcart = "SELECT * FROM `cart` INNER JOIN products ON cart.code = products.code WHERE  cart.email = '$email'";
        $stmtcart= $conn->prepare($sqlcart);
        $stmtcart->execute();
        $number_of_rows = $stmtcart->rowCount();
        $rows = $stmtcart->fetchAll();
        if ($number_of_rows > 0)
        {
            foreach ($rows as $carts)
                {
                    $code = $carts['code'];
                    $cartqty = (int)$carts['cartquan'];
                    $proprice = (double)$carts['price'];
                    $totalprice = $proprice * $cartqty;
                    
                    $sqlinsertorders = "INSERT INTO `historder`(`receiptid`, `orderprocode`, `buyquan`, `custid`, `amountpaid`) VALUES('$receiptid','$code','$cartqty','$email','$totalprice')";
                    //$conn->exec($sqlinsertorders);
                    $stmt = $conn->prepare($sqlinsertorders);
                    $stmt->execute();
                    $sqlupdateqty = "UPDATE products SET quantity = quantity - 1 WHERE code = $code and quantity > 0";
                    $conn->exec($sqlupdateqty);
                    $stmt = $conn->prepare($sqlupdateqty);
                    $stmt->execute();
                }
        }
        $sqldeletecart = "DELETE FROM `cart` WHERE email = '$email'";
        
        try {
        $conn->exec($sqlinsertpayment);
        $stmt = $conn->prepare($sqldeletecart);
        $stmt->execute();
        date_default_timezone_set("Asia/Kuala_Lumpur");
   
        echo "<center><img src=../images/logo.png onerror=this.onerror=null;this.src='../images/product/products.png'></center>";
         echo '<body><div><h2><center>Your Receipt</center>
     </h1>
     <table border=1 width=80% align=center>
     <tr><td>Receipt ID</td><td>'.$receiptid.'</td></tr><tr><td>Email </td>
     <td>'.$email. ' </td></tr><td>Amount Paid </td><td>RM '.$amount.'</td></tr>
     <tr><td>Payment Status </td><td>'.$paidstatus.'</td></tr>
     <tr><td>Date </td><td>'.date("d/m/Y").'</td></tr>
     <tr><td>Time </td><td>'.date("h:i a").'</td></tr>
     </table><br>
     <p><center>Press back button to return to your app</center></p></div></body>';
            
            } catch (PDOException $e) {
            echo "<script>alert('Failed to pay')</script>";
            echo $e;
           }
    }
    else  
    {
        echo 'Payment Failed!';
    }
}
?>
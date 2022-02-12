<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home/ppdkpcom/public_html/PHPMailer/src/Exception.php';
require '/home/ppdkpcom/public_html/PHPMailer/src/PHPMailer.php';
require '/home/ppdkpcom/public_html/PHPMailer/src/SMTP.php';

if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("../php/dbconnectsql.php");

$user_name = $_POST['user_name'];
$email = $_POST['email'];
$password = sha1($_POST['password']);
$otp = rand(10000, 99999);


$sqlinsert = "INSERT INTO `users`(`user_name`, `email`, `password`,`otp`)VALUES('$user_name','$email','$password','$otp')";
if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    sendEmail($email,$otp);
    
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

function sendEmail($email,$otp)
{
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                                               //Disable verbose debug output
    $mail->isSMTP();                                                    //Send using SMTP
    $mail->Host       = 'mail.ppdkp.com';                          //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                           //Enable SMTP authentication
    $mail->Username   = 'akmalsyafiq@ppdkp.com';  
    $mail->Password   = 'akmalsyafiq';                                 //g(v!@D([]7UP$K7wty  /  T0MizfNmCddW
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    $from = "akmalsyafiq@ppdkp.com";
    $to = $email;
    $subject = 'Bellacosa Shop - Please verify your account';
    $message = "<h2>Welcome to Bellacosa Shop</h2> <p>Thank you for registering your account with us. To complete your registration please click the following.<p>
    <p><button><a href ='https://ppdkp.com/bellacosa/php/verify_account.php?email=$email&otp=$otp'>Verify Here</a></button>";
    
    $mail->setFrom($from,"Bellacosa Shop");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}
?>

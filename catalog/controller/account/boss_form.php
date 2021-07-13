<?php
class Controlleraccountbossform extends Controller {
    public function index() {
/* Осуществляем проверку вводимых данных и их защиту от враждебных
скриптов */

//$host = 'johnee12.mysql.tools';  // Хост, у нас все локально
//$user = 'johnee12_kavkaz';    // Имя созданного вами пользователя
//$pass = '#T76+3mkdJ'; // Установленный вами пароль пользователю
//$db_name = 'johnee12_kavkaz';   // Имя базы данных
//$link = mysqli_connect($host, $user, $pass, $db_name); // Соединяемся с базой

$backurl = 'index.php?route=account/newsletter';
$name = trim($_POST['firstname']);


$phone = trim($_POST['phone']);
$phone = strip_tags($phone);
$phone = htmlspecialchars($phone);

$mail = trim($_POST['email']);
$mail = strip_tags($mail);
$mail = htmlspecialchars($mail);

$theme = trim($_POST['text']);
$theme = strip_tags($theme);
$theme = htmlspecialchars($theme);

//$email = mysqli_connect("SELECT key, value FROM " . DB_PREFIX . "setting WHERE key = config_email_boss" );

if($name AND $phone AND $mail AND $theme){
    $email = "dudnik1986@gmail.com";
    $headers  = 'MIME-Version: 1.0' . "\r\n";
    $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
    $headers .= 'From: Интернет-магазин kavkaz-ochag <site@kavkaz-ochag>' . "\r\n";
    $subject = "Обращение к директору";
    $body = "<h1>Обращение к директору</h1>";
    $body .= "<p>Пользователь: ".$name."</p>";
    $body .= "<p>Телефон: ".$phone."</p>";
    $body .= "<a href='mailto:".$mail."'>$mail</a>";
    $body .= "<p>Сообщение: ".$theme."</p>";

    $result = mail($email, $subject, $body, $headers);
    print "<script language='Javascript'><!-- 
function reload() {location = \"$backurl\"}; setTimeout('reload()', 1000000); 
//--></script> ";
    exit;

}
}

}
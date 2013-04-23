<?
/*//////////////////////////////////////////////////////////////////////

Description:       Liberty Reserve Sample Store
Release Date:     Oct 06, 2011

Designed and Developed by Liberty Reserve development team.
Copyright (c) 2011 Liberty Reserve.
Website: http://www.libertyreserve.com

This program is distributed in the hope that it will be useful but 
WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  

//////////////////////////////////////////////////////////////////////*/

require_once("include/config.php");
require_once("include/content.php"); 

// You can recall any sent parameter using these sample codes:
// $_REQUEST["some_baggage_field"];
// $_REQUEST["lr_store"];
// $_REQUEST["lr_paidto"];
// $_REQUEST["lr_paidby"];
// and others..

// Building a string to be hashed
$str = 
  $_REQUEST["lr_paidto"].":".
  $_REQUEST["lr_paidby"].":".
  stripslashes($_REQUEST["lr_store"]).":".
  $_REQUEST["lr_amnt"].":".
  $_REQUEST["lr_transfer"].":".
  $_REQUEST["lr_currency"].":".
  $conf_merchantSecurityWord;
  
//Calculating hash
$hash = strtoupper(bin2hex(mhash(MHASH_SHA256, $str)));  

//Let's check that all parameters exist and match and that the hash 
//string we computed matches the hash string that was sent by LR system.
if (isset($_REQUEST["lr_paidto"]) &&  
    $_REQUEST["lr_paidto"] == strtoupper($conf_merchantAccountNumber) &&
    isset($_REQUEST["lr_store"]) && 
    stripslashes($_REQUEST["lr_store"]) == $conf_merchantStoreName &&
    isset($_REQUEST["lr_encrypted"]) &&
    $_REQUEST["lr_encrypted"] == $hash) {

// Response was validated and you can use this verified information to 
// complete selling process.
// Enter any code here that you want to be executed after a successful 
// payment.

// In our example we send email. The following code writes that the 
// payment was good to the email body.

  $msgBody = "Payment was verified and is successful.\n\n";
}
else {

// This block is for the code in case that the payment verification has 
// failed.
// In our example write the response to the body of the email we are 
// going to send.
  $msgBody = "Invalid response. Sent hash didn't match the computed hash.\n";
}

// Let's get all the data sent by LR and add it to our email.
$msgBody .= "Received data\n";
$reqKeys = array_keys ($_REQUEST);
foreach($reqKeys as &$key) {
  $msgBody .= $key." = ".$_REQUEST[$key]."\n";
}
// Our example sends email with the result of verification and all the 
// variables sent to this page.
if ($conf_merchantEmail != "") {
  mail($conf_merchantEmail, "LR SCI Status", $msgBody);
}
 
?>

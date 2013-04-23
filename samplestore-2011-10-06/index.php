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


$serverUrlAndPath = "http://".$_SERVER["HTTP_HOST"].dirname($_SERVER["REQUEST_URI"]);
$serverUrlAndPath = str_replace("\\", "/", $serverUrlAndPath);


$succesUrl = $serverUrlAndPath."success.php";
$failUrl = $serverUrlAndPath."fail.php";

$statusUrl = $serverUrlAndPath."status.php";

showHeader("Choose goods");
?>
<h1> Simple Mode (with no <i>lr_store</i>, <i>lr_status_url</i> or payment verification)</h1>
<form method="post" action="https://sci.libertyreserve.com">
<table width="100%" class="item">
  <tr>
    <td class="foto-block">
      <div class="foto">
        FOTO<br />
        #1
      </div></td>
    <td class="description-block">
      <h1>
        First Sell Item
      </h1>
      <p>
        Only for <span class="price">$0.01</span>
      </p>
    </td>
    <td style="width: 40%" class="sci-description-block">
      Simple payment form with hardcoded URLs.
    </td>
  </tr>
  <tr>
    <td class="buy-button-block">
      <input type="hidden" name="lr_acc" value="<?=$conf_merchantAccountNumber?>">
      <input type="hidden" name="lr_amnt" value="0.01">      
      <input type="hidden" name="lr_currency" value="LRUSD">
      <input type="hidden" name="lr_comments" value="Payment for First Sell Item">
      <input type="hidden" name="lr_merchant_ref" value="OID_000001">
      <!-- urls -->
      
      <input type="hidden" name="lr_success_url" value="<?=$succesUrl?>">
      <input type="hidden" name="lr_fail_url" value="<?=$failUrl?>">


      
      <!-- baggage fields -->
      <input type="hidden" name="order_id" value="000001" />
      <input type="hidden" name="item_name" value="First Sell Item" />      
      
      
      <input type="submit" value="Buy!" style="width: 100%" />
      
    </td>
  </tr>
</table>
</form>

<form method="post" action="https://sci.libertyreserve.com">
<table width="100%" class="item">
  <tr>
    <td class="foto-block">
      <div class="foto">
        FOTO<br />
        #2
      </div></td>
    <td class="description-block">
      <h1>
        Second Sell Item
      </h1>
      <p>
        Only for <span class="price">$0.10</span>
      </p>
    </td>
    <td style="width: 40%" class="sci-description-block">
      This example allows you to use different success and fail URLs than those that were set in your script.
      <table class="form" cellspacing="0" border="0" style="width: 100%" >
        <tr>
          <td style="width: 20%">
            Success URL:
          </td>
          <td>
            <input type="text" name="lr_success_url" value="<?=$succesUrl?>" style="width: 100%"/></td>
        </tr>
        <tr>
          <td>
            Fail URL:
          </td>
          <td>
            <input type="text" name="lr_fail_url" value="<?=$failUrl?>" style="width: 100%"/></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="buy-button-block">
      <input type="hidden" name="lr_acc" value="<?=$conf_merchantAccountNumber?>">            
      <input type="hidden" name="lr_amnt" value="0.10">
      <input type="hidden" name="lr_currency" value="LRUSD">
      <input type="hidden" name="lr_comments" value="Payment for Second Sell Item">
      <input type="hidden" name="lr_merchant_ref" value="OID_000002">
      <!-- baggage fields -->
      <input type="hidden" name="order_id" value="000002" />
      <input type="hidden" name="item_name" value="Second Sell Item" />      
      
      
      <input type="submit" value="Buy!" style="width: 100%"/>
    </td>
  </tr>
</table>
</form>

<h1> Advanced Mode (with <i>lr_store</i> and <i>lr_status_url</i> and payment verification)</h1>
<form method="post" action="https://sci.libertyreserve.com">
<table width="100%" class="item">
  <tr>
    <td class="foto-block">
      <div class="foto">
        FOTO<br />
        #1
      </div></td>
    <td class="description-block">
      <h1>
        First Sell Item
      </h1>
      <p>
        Only for <span class="price">$0.05</span>
      </p>
    </td>
    <td style="width: 40%" class="sci-description-block">
      <p>
        In this example URLs are not set in the script. LR will use the ULRs set in your store.
      </p>
      <p>
         This is the most secure option.
      </p>
    </td>
  </tr>
  <tr>
    <td class="buy-button-block">
      <input type="hidden" name="lr_acc" value="<?=$conf_merchantAccountNumber?>">
    <input type="hidden" name="lr_store" value="<?=$conf_merchantStoreName?>">
      <input type="hidden" name="lr_amnt" value="0.05">      
      <input type="hidden" name="lr_currency" value="LRUSD">
      <input type="hidden" name="lr_comments" value="Payment for First Sell Item">
      <input type="hidden" name="lr_merchant_ref" value="OID_000001">
      <!-- urls are taken from  SCIstore settings in your account -->     

      <!-- baggage fields -->
      <input type="hidden" name="order_id" value="000001" />
      <input type="hidden" name="item_name" value="First Sell Item" />      
      
      
      <input type="submit" value="Buy!" style="width: 100%" />
      
    </td>
  </tr>
</table>
</form>

<form method="post" action="https://sci.libertyreserve.com">
<table width="100%" class="item">
  <tr>
    <td class="foto-block">
      <div class="foto">
        FOTO<br />
        #2
      </div></td>
    <td class="description-block">
      <h1>
        Second Sell Item
      </h1>
      <p>
        Only for <span class="price">$0.10</span>
      </p>
    </td>
    <td style="width: 40%" class="sci-description-block">
      <p>This example allows you to override the success and fail URLs that were set in your store.</p>
      <p>Status URL will be retreived by LR from your SCI store.</p>
      <table class="form" cellspacing="0" border="0" style="width: 100%" >
        <tr>
          <td style="width: 20%">
            Success URL:
          </td>
          <td>
            <input type="text" name="lr_success_url" value="<?=$succesUrl?>" style="width: 100%"/></td>
        </tr>
        <tr>
          <td>
            Fail URL:
          </td>
          <td>
            <input type="text" name="lr_fail_url" value="<?=$failUrl?>" style="width: 100%"/></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="buy-button-block">
      <input type="hidden" name="lr_acc" value="<?=$conf_merchantAccountNumber?>">
      <input type="hidden" name="lr_store" value="<?=$conf_merchantStoreName?>">      
      <input type="hidden" name="lr_amnt" value="0.10">
      <input type="hidden" name="lr_currency" value="LRUSD">
      <input type="hidden" name="lr_comments" value="Payment for Second Sell Item">
      <input type="hidden" name="lr_merchant_ref" value="OID_000002">
      <!-- baggage fields -->
      <input type="hidden" name="order_id" value="000002" />
      <input type="hidden" name="item_name" value="Second Sell Item" />      
      
      
      <input type="submit" value="Buy!" style="width: 100%"/>
    </td>
  </tr>
</table>
</form>


<form method="get" action="https://sci.libertyreserve.com">
<table width="100%" class="item">
  <tr>
    <td class="foto-block">
      <div class="foto">
        FOTO<br />
        #3
      </div></td>
    <td class="description-block">
      <h1>
        Third Sell Item
      </h1>
      <p>
        Only for <span class="price">$0.01</span>
      </p>
    </td>
    <td style="width: 40%" class="sci-description-block">
      <p>
        This example allows you to override the status URL that was set in your store. Success and fail URLs will be retreived by LR from your store settings. You may also enter your email instead of a URL.
      </p>
      <p>
        Enter email in the following format: "mailto:myname@example.com"
      </p>
      <table class="form" cellspacing="0" border="0" style="width: 100%">
        <tr>
          <td style="width: 20%">
            Status URL:
          </td>
          <td>
            <input type="text" name="lr_status_url" value="<?=$statusUrl?>" style="width: 100%"/></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="buy-button-block">
      <input type="hidden" name="lr_acc" value="<?=$conf_merchantAccountNumber?>">
      <input type="hidden" name="lr_store" value="<?=$conf_merchantStoreName?>">      
      <input type="hidden" name="lr_amnt" value="0.01">
      <input type="hidden" name="lr_currency" value="LRUSD">
      <input type="hidden" name="lr_comments" value="Payment for Third Sell Item">
      <input type="hidden" name="lr_merchant_ref" value="OID_000003">
      
      
      <!-- baggage fields -->
      <input type="hidden" name="order_id" value="000003" />
      <input type="hidden" name="item_name" value="Third Sell Item" />      
      
      <input type="submit" value="Buy!" style="width: 100%"/>
    </td>
  </tr>
</table>
</form>


<?

showFooter();
?>

Liberty Reserve: A Sample Store

Provided example shows how to use Liberty Reserve 
Shopping Cart Interface

There are two methods you can use LR's SCI:
1. Simple mode: you do not need to verify the data sent by LR to your 
   server.
Usage:
   You will not need to create an SCI store inside your account.
   Also, nothing will be sent to status URL.
   A hash string of the sent data will not be created.
   You will have to specify the success and fail URLs and their data 
   transfer methods inside the script.
   You should not specify the store name or the status URL.

2. Advanced mode: you want to verify the data sent from LR.
   In this mode LR will send data to your status URL along with a hash 
   string.
Usage:
   This hash string represents the data sent with it. You can verify the 
   data by computing this hash string yourself together with your secret 
   word. 
   This example shows you how it is done.
   To do so you will have to create an SCI store inside your LR account.
   Login to your account and go to 'Merchant Tools.' Create an SCI 
   Store.
   Enter the success, fail, status URLs and their data transfer methods, 
   security word, which will be used to compute hash and the store name.
   You can override the URL settings inside your script.

Before you start to use this example you need to edit 
'includes/config.php' file and replace values of variables with your 
information.

For any questions please contact tech@libertyreserve.com

Useful links:
SCI Tutorial:
http://http://www.libertyreserve.com/en/help/sciguide

SCI Form Generator:
http://www.libertyreserve.com/en/paymentform
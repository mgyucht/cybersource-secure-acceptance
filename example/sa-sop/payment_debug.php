<html>
<head>
    <title>Receipt</title>
    <link rel="stylesheet" type="text/css" href="/css/payment.css"/>
</head>
<body>
<img src="/img/logo-cybersource.png" style="padding-bottom: 10px;" />
<br>
<a href="./payment_form.php">&lt;&lt; back</a>

<div id="container">
<pre>

change PAYMENT_URL at config.php
define('PAYMENT_URL', 'https://testsecureacceptance.cybersource.com/silent/pay');

<?php

$request = $_POST;
ksort($request);
print_r($request);

?>
</pre>
</div>

</body>
</html>
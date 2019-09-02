<%@ page contentType="text/html;charset=UTF-8"  language="java" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<%!

    private String getUTCDateTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", new Locale("en", "EN"));
        sdf.setTimeZone(TimeZone.getTimeZone("UTC"));

        return sdf.format(new Date());
    }

%>
<%

String responsePage = "https://miles-accounts.dev.databricks.com/cybersource-response";

%>
<!DOCTYPE html>
<html>
<head>
    <title>SOP - Payment Form</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link type="image/x-icon" href="../favicon.png" rel="shortcut icon">
    <link rel="stylesheet" type="text/css" href="../css/payment.css"/>
</head>
<body>
<div id="header">
    <div id="logo">
        <img src="../img/logo-cybersource.png" style="padding-bottom: 10px;" />
    </div>
    <div id="title_heaer">
        <h2>SOP - Payment Form</h2>
    </div>
</div>

<p>
<form id="payment_form" action="./payment_confirm.jsp" method="post">

    <input type="hidden" name="profile_id" value="<%= PROFILE_ID %>">
    <input type="hidden" name="access_key" value="<%= ACCESS_KEY %>">
    <input type="hidden" name="transaction_uuid" value="<%= UUID.randomUUID() %>">
    <input type="hidden" name="signed_date_time" value="<%= getUTCDateTime() %>"">

    <input type="hidden" name="signed_field_names" value="profile_id,access_key,transaction_uuid,signed_field_names,unsigned_field_names,signed_date_time,locale,payment_method,transaction_type,reference_number,amount,currency,merchant_descriptor,override_custom_receipt_page,bill_to_forename,bill_to_surname,bill_to_email,bill_to_company_name,bill_to_phone,bill_to_address_line1,bill_to_address_line2,bill_to_address_city,bill_to_address_state,bill_to_address_country,bill_to_address_postal_code">
    
    <input type="hidden" name="unsigned_field_names" value="card_type,card_number,card_expiry_date,card_cvn">
    
    <div id="paymentDetailsSection" class="section">
    <fieldset>
        <legend>Signed Data Fields</legend>
        These fields will be POSTed to your server for signing using the Security file included in the sample script.<br>
        The name of each signed field should be included in the signed_field_names.

            <h3>Payment Information</h3>
            <span>payment_method:</span>              <input type="text" name="payment_method" value="card"><br/>
            <span>transaction_type:</span>            <input type="text" name="transaction_type" value="create_payment_token"><br/>
            <span>reference_number:</span>            <input type="text" name="reference_number" value="<%= UUID.randomUUID() %>"><br/>
            <span>amount:</span>                      <input type="text" name="amount" value="0.00"><br/>
            <span>currency:</span>                    <input type="text" name="currency" max="3" value="USD"><br/>
            <span>locale:</span>                      <input type="text" name="locale" value="en-us"> (en-us, th-th, ja-jp)<br/>
            <span>merchant_descriptor:</span>         <input type="text" name="merchant_descriptor" value="<%= MERCHANT_ID %>">
    </fieldset>
    <p>
    <fieldset>
        <legend>Unsigned Data Fields</legend>
        The name of each unsigned field should be included in the unsigned_field_names.
            <h3>Billing Information</h3>
            <span>bill_to_forename:</span>            <input type="text" name="bill_to_forename" value="Harry"><br/>
            <span>bill_to_surname:</span>             <input type="text" name="bill_to_surname" value="Potter"><br/>
            <span>bill_to_email:</span>               <input type="text" name="bill_to_email" value="harry@ministryofmagic.co.uk"><br/>
            <span>bill_to_company_name:</span>        <input type="text" name="bill_to_company_name" value="Ministry of Magic"><br/>
            <span>bill_to_phone:</span>               <input type="text" name="bill_to_phone" value="+44 020 1234 5678"><br/>
            <span>bill_to_address_line1:</span>       <input type="text" name="bill_to_address_line1" maxlength="60" value="Whitehall"><br/>
            <span>bill_to_address_line2:</span>       <input type="text" name="bill_to_address_line2" maxlength="60" value="Somewhere in London"><br/>
            <span>bill_to_address_city:</span>        <input type="text" name="bill_to_address_city" value="London"><br/>
            <span>bill_to_address_state:</span>       <input type="text" name="bill_to_address_state" value="Greater London"><br/>
            <span>bill_to_address_country:</span>     <input type="text" name="bill_to_address_country" value="UK"><br/>
            <span>bill_to_address_postal_code:</span> <input type="text" name="bill_to_address_postal_code" value="SW15 5PU"><br/>

    </fieldset>
    </div>

    <input type="hidden" name="override_custom_receipt_page" value="<%= responsePage %>">

    <input type="submit" id="btn_submit" value="Submit"/>
</form>

<script type="text/javascript" src="../js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../js/payment_form.js"></script>
<script type="text/javascript">
    
    function createToken(create_token) {

        var type = 'sale';

        if (create_token.checked) {
            type += ',create_payment_token';
        }

        $("input[name='transaction_type']").val(type);
    }
</script>

</body>
</html>
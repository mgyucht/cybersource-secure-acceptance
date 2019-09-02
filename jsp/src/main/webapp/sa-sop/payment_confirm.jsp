<%@ page contentType="text/html;charset=UTF-8"  language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="security.jsp" %>
<%

String endpointUrl = TOKEN_CREATE_URL;

%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirm</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link type="image/x-icon" href="../favicon.png" rel="shortcut icon">
    <link rel="stylesheet" type="text/css" href="../css/payment.css"/>
</head>
<body>
<img src="../img/logo-cybersource.png" style="padding-bottom: 10px;" />
<h2>SOP - Review &amp; Confirm</h2>

<form id="payment_confirmation" action="<%= endpointUrl %>" method="post"/>
<%
    Map params = new HashMap();
    List<String> keys = Collections.list(request.getParameterNames());
    Collections.sort(keys);

    for (String key : keys) {
        params.put(key, request.getParameter(key));
    }
%>

<div style="display: block">
    <fieldset id="confirmation">
        <legend>Data Fields</legend>
        These fields have been signed on your server, and a signature has been generated.<br>
        This will detect tampering with these values as they pass through the consumers browser to the SA SOP endpoint.
        <p>
        <div>
        <%

            for (String name: keys) { 
                String value = (String) params.get(name);

                out.print("<div>\n");
                out.print("<span class='fieldName'>" + name + "</span><span class='fieldValue'>" + value + "</span>\n");
                out.print("<input type='hidden' id='" + name + "' name='" + name + "' value='" + value + "'/>\n");
                out.print("<div>\n");
            }
        %>
        </div>
        </p>
    </fieldset>
</div>

    <% if (request.getParameter("payment_token") == null) { %>

    <p>
    <fieldset>
        <legend>Card Information</legend>
        Card data fields are posted <u>directly to CyberSource</u>, together with the fields above.<br>
        These field names will need to be included in the unsigned_field_names.
        <p>
        <div id="UnsignedDataSection" class="section">
        <span>card_type:</span><input type="text" name="card_type" value="001"><br/>
        <span>card_number:</span><input type="text" name="card_number" maxlength="16" value="4111111111111111"><br/>
        <span>card_expiry_date:</span><input type="text" name="card_expiry_date" maxlength="7" value="12-2022"><br/>
        <span>card_cvn:</span><input type="text" name="card_cvn" maxlength="4" value="111"><br/>
    </div>
    </fieldset>

    <% } %>

    <input type="hidden" name="signature" value="<%= sign(params) %>" />
    <input type="submit" id="btn_submit" value="Confirm"/>

</form>

<script type="text/javascript" src="../js/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../js/payment_form.js"></script>
<script type="text/javascript" src="../js/jquery.maskedinput-1.3.js"></script>
<script type="text/javascript">

    $("#card_number").mask("9999 9999 9999 9999");

</script>

</body>
</html>

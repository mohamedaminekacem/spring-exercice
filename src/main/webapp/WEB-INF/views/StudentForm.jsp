<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <meta charset="UTF-8">
    <title>Student Form</title>
    <style>
        /* Centering only the form, not affecting the search bar */
        .form-container {
            background: white;
            padding: 60px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
            margin: 20px auto; /* Centers it */
        }

        .form-container h1 {
            font-size: 20px;
            margin-bottom: 15px;
        }

        .form-container form {
            display: flex;
            flex-direction: column;
        }

        .form-container input,
        .form-container select {
            width: 100%;
            padding: 8px;
            margin: 6px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-container input:focus,
        .form-container select:focus {
            border-color: #007BFF;
            outline: none;
        }

        .form-container .submit-btn {
            background: #1e3a8a; /* Slightly lighter blue */
            color: white;
            border: none;
            padding: 10px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 10px;
        }

        .form-container .submit-btn:hover {
            background: #0f235c; /* Slightly darker on hover */
        }

        /* Success message styling */
        .success-message {
            color: green;
            font-weight: bold;
        }

        /* Error message styling */
        .error-messages {
            color: red;
            font-weight: bold;
            list-style-type: none; /* Remove bullet points */
            padding-left: 0; /* Remove default padding */
        }

        .error-messages li {
            margin-bottom: 5px; /* Add spacing between error messages */
        }
    </style>
</head>
<body>

    <%-- Include the search bar --%>
    <jsp:include page="SearchBar.jsp"/>

    <div class="form-container">
        <h1><spring:message code="label.headerMessage"/></h1>
        <form:form action="submitStudent.html" modelAttribute="student" method="POST">
            <label><spring:message code="label.firstName"/></label>
            <form:input path="firstName" required="true"/>
            <form:errors path="firstName" cssClass="error" />

            <label><spring:message code="label.lastName"/></label>
            <form:input path="lastName" required="true"/>
            <form:errors path="lastName" cssClass="error" />

            <label><spring:message code="label.gender"/></label>
            <form:select path="gender">
                <form:option value="">Select Gender</form:option>
                <form:option value="male">Male</form:option>
                <form:option value="female">Female</form:option>
            </form:select>
            <form:errors path="gender" cssClass="error" />

            <label><spring:message code="label.address"/></label>
            <form:input path="address.country" placeholder="Country" required="true"/>
            <form:input path="address.state" placeholder="State" required="true"/>
            <form:input path="address.city" placeholder="City" required="true"/>
            <form:input path="address.street" placeholder="Street" required="true"/>
            <form:input path="address.zipCode" placeholder="Zip Code" required="true"/>

            <label><spring:message code="label.birthday"/></label>
            <form:input type="date" path="birthday" required="true"/>

            <button type="submit" class="submit-btn">Submit</button>
        </form:form>

        <c:if test="${not empty successMessage}">
            <p class="success-message"><b>${successMessage}</b></p>
        </c:if>

        <c:if test="${not empty errorMessages}">
            <ul class="error-messages">
                <c:forEach var="error" items="${errorMessages}">
                    <li><b>${error}</b></li>
                </c:forEach>
            </ul>
        </c:if>


        <a href="/tutorial?lang=en">English</a> | <a href="/tutorial?lang=fr">French</a>
    </div>




</body>
</html>
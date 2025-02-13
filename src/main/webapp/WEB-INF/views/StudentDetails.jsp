<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <meta charset="UTF-8">
    <title>Student Details</title>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 75vh; /* Moves content slightly higher */
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            text-align: left; /* Align text to the left */
        }

        .card h2 {
            color: #1e3a8a;
            margin-bottom: 20px;
            font-size: 26px;
            font-weight: bold;
            text-align: center;
        }

        .card p {
            font-size: 18px;
            margin: 10px 0;
            color: #333;
        }

        .card strong {
            font-size: 19px;
            color: #000;
        }

        /* Address Section: Everything aligned under "Country" */
        .address-container p {
            margin: 5px 0;
            font-size: 17px;
            color: #555;
        }

        /* Makes all address fields aligned under one another */
        .address-container {
            margin-left: 20px; /* Creates a clean alignment under "Country" */
        }

        .alert {
            margin-top: 20px;
        }

        /* Styling for the editable country field */
        .editable {
            display: inline-block;
            font-size: 17px;
            padding: 5px;
        }

        .editable input {
            font-size: 17px;
            padding: 5px;
            width: 150px;
        }

        .icon-btn {
            cursor: pointer;
        }
    </style>
</head>
<body>

    <jsp:include page="SearchBar.jsp"/>

    <div class="container">
        <c:choose>
            <c:when test="${not empty student}">
                <div class="card">
                    <h2>Student Details</h2>
                    <p><strong>First Name:</strong> ${student.firstName}</p>
                    <p><strong>Last Name:</strong> ${student.lastName}</p>
                    <p><strong>Gender:</strong> ${student.gender}</p>

                    <!-- Address Section -->
                    <p><strong>Address:</strong></p>
                    <div class="address-container">
                        <c:set var="fields" value="country, state, city, street, zipCode"/>
                        <c:forEach var="field" items="${fn:split(fields, ', ')}">
                            <p><strong><c:out value="${field}"/>:</strong>
                                <span class="editable">
                                    <span id="${field}Text"><c:out value="${student.address[field]}"/></span>
                                    <i class="bi bi-pencil-fill icon-btn editBtn" id="${field}EditBtn" data-field-name="${field}"></i>
                                    <form class="editFieldForm" id="${field}Form" method="POST" style="display: none;" data-field-name="${field}">
                                        <input type="text" class="fieldInput" id="${field}Input"
                                               value="<c:out value='${student.address[field]}'/>"
                                               data-original-value="<c:out value='${student.address[field]}'/>"
                                               data-field-name="${field}"/>
                                        <button type="submit" class="btn btn-primary btn-sm" id="${field}ApplyChangesBtn" disabled>Apply Changes</button>
                                    </form>
                                </span>
                            </p>
                        </c:forEach>


                    </div>

                    <p><strong>Birthday:</strong> ${student.birthday}</p>
                </div>
            </c:when>
            <c:when test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:when>
        </c:choose>
    </div>

    <script>
        const forms = document.querySelectorAll('.editFieldForm');
        const editButtons = document.querySelectorAll('.editBtn');
        const inputs = document.querySelectorAll('.fieldInput');

        // Loop through each button and attach an event listener
        editButtons.forEach(button => {
            button.addEventListener('click', function() {
                const fieldName = this.dataset.fieldName;
                const editFieldFormId = fieldName+"Form";
                const fieldTextId = fieldName+"Text";
                const editFieldForm = document.getElementById(editFieldFormId);
                const fieldText = document.getElementById(fieldTextId);
                // Hide the current text and show the form
                if (editFieldForm.style.display == 'none'){
                    fieldText.style.display = 'none';
                    editFieldForm.style.display = '';
                }else{
                    fieldText.style.display = '';
                    editFieldForm.style.display = 'none';
                }
            });
        });


        forms.forEach(form => {
            form.addEventListener('submit', function(event) {
                // Prevent the form from submitting immediately
                event.preventDefault();

                // Get the field name from the data attribute
                const fieldName = this.dataset.fieldName;

                // Get the value of the id of the input field
                const inputId = fieldName+"Input";
                const input = document.getElementById(inputId).value.trim();

                // Update the form's action attribute with the new value
                const encodedInput = encodeURIComponent(input);
                const studentId = "${student.id}";


                const formAction = "updateField?fieldName=" + fieldName + "&newValue=" + encodedInput + "&id=${student.id}";

                // Send the request using fetch
                fetch(formAction, {method: 'POST'})
                .then(response => {
                    if (response.ok) {
                        // If request is successful, refresh the page
                        location.reload();
                    } else {
                        // Handle failure, display an error message if necessary
                        alert('Failed to update the field');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error in updating field');
                });

            });
        });


        inputs.forEach(input => {
            input.addEventListener('input', function() {

                const originalValue = this.dataset.originalValue;
                const fieldName = this.dataset.fieldName;
                const currentValue = this.value.trim();

                const btnId = fieldName+"ApplyChangesBtn";
                const btn = document.getElementById(btnId);

                if (currentValue !== originalValue) {
                    btn.disabled = false;
                } else {
                    btn.disabled = true;
                }
            });
        });


    </script>

</body>
</html>

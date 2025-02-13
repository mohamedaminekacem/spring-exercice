<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <meta charset="UTF-8">
    <title>Search Results</title>
    <style>
        /* Container to center everything */
        .container {
            margin-top: 50px;
            padding: 20px;
            text-align: center;
        }

        /* Style for the table */
        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #1e3a8a;
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f2f2f2;
        }

        /* Message when no results are found */
        .no-results {
            font-size: 18px;
            color: #555;
            font-style: italic;
        }

        /* Responsive design */
        @media screen and (max-width: 768px) {
            table {
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <%-- Include the search bar --%>
    <jsp:include page="SearchBar.jsp"/>

    <div class="container">
        <c:if test="${getAllStudents}">
            <p>Showing All Students. Total: ${students.size()}</p>
        </c:if>
        <c:if test="${not getAllStudents and not empty students}">
            <p>Total results: ${students.size()}</p>
        </c:if>
        <c:if test="${not empty students}">
            <table>
                <tr>
                    <th>#</th> <!-- New header for the number column -->
                    <th>Last Name</th>
                    <th>First Name</th>
                    <th>Gender</th>
                    <th>Address</th>
                </tr>
                <c:forEach var="student" items="${students}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td> <!-- This will display 1, 2, 3... -->
                        <td><a href = "/tutorial/studentDetails.html?id=${student.id}">${student.lastName}</a></td>
                        <td>${student.firstName}</td>
                        <td>${student.gender}</td>
                        <td>${student.address}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <c:if test="${empty students and (not empty first_name or not empty last_name or not empty gender)}">
            <p class="no-results">No results found.</p>
        </c:if>
    </div>

</body>
</html>

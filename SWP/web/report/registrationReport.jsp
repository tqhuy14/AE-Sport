<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo đăng ký người dùng</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f8f8f8;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .nav {
            list-style-type: none;
            padding: 0;
            text-align: center;
            margin-bottom: 20px;
        }
        .nav-item {
            display: inline;
            margin-right: 10px;
        }
        .nav-link {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .nav-link:hover {
            text-decoration: underline;
        }
        canvas {
            display: block;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <h1>Báo cáo đăng ký người dùng</h1>
    <ul class="nav">
        <li class="nav-item">
            <a class="nav-link" href="report?action=registrationReport&period=week">Registration Report</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="report?action=activityReport&period=week">Activity Report</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="report?action=customActivityReport">Custom Activity Report</a>
        </li>
    </ul>
    <canvas id="userRegistrationChart" width="600" height="400"></canvas>

    <script>
        // Lấy dữ liệu từ JSTL và định dạng cho Chart.js
        const registrationData = {
            labels: [
                <c:forEach items="${registrationReport}" var="entry" varStatus="status">
                    '${entry.key}'<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [{
                label: 'Đăng ký người dùng',
                data: [
                    <c:forEach items="${registrationReport}" var="entry" varStatus="status">
                        ${entry.value}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        };

        const ctx = document.getElementById('userRegistrationChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: registrationData,
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo hoạt động người dùng tùy chỉnh</title>
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
    <h1>Báo cáo hoạt động người dùng tùy chỉnh</h1>
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
    <form action="report" method="GET">
        <input type="hidden" name="action" value="customActivityReport">
        <label for="start-date">Ngày bắt đầu:</label>
        <input type="date" id="start-date" name="start" required>
        <label for="end-date">Ngày kết thúc:</label>
        <input type="date" id="end-date" name="end" required>
        <button type="submit">Lấy báo cáo</button>
    </form>
    <canvas id="customUserActivityChart" width="600" height="400"></canvas>

    <script>
        // Lấy dữ liệu từ JSTL và định dạng cho Chart.js
        const customActivityData = {
            labels: [
                <c:forEach items="${customActivityReport}" var="entry" varStatus="status">
                    '${entry.key}'<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [{
                label: 'Hoạt động người dùng tùy chỉnh',
                data: [
                    <c:forEach items="${customActivityReport}" var="entry" varStatus="status">
                        ${entry.value}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        };

        const ctx = document.getElementById('customUserActivityChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: customActivityData,
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

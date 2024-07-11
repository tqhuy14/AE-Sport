<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo hoạt động người dùng</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
    <h1>Báo cáo hoạt động người dùng</h1>
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
    <form id="filterForm" action="report" method="GET" class="text-center mb-4">
        <input type="hidden" name="action" value="activityReport">
        <label for="period">Lọc theo:</label>
        <select id="period" name="period" onchange="document.getElementById('filterForm').submit()">
            <option value="day" ${param.period == 'day' ? 'selected' : ''}>Ngày</option>
            <option value="week" ${param.period == 'week' ? 'selected' : ''}>Tuần</option>
            <option value="month" ${param.period == 'month' ? 'selected' : ''}>Tháng</option>
        </select>
    </form>
    <canvas id="userActivityChart" width="600" height="400"></canvas>

    <script>
        // Lấy dữ liệu từ JSTL và định dạng cho Chart.js
        const activityData = {
            labels: [
                <c:forEach items="${activityReport}" var="entry" varStatus="status">
                    '${entry.key}'<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [{
                label: 'Hoạt động người dùng',
                data: [
                    <c:forEach items="${activityReport}" var="entry" varStatus="status">
                        ${entry.value}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        };

        const ctx = document.getElementById('userActivityChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: activityData,
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
	var ctx = document.getElementById('myChart');
	var myChart = new Chart(ctx, {
		type: 'bar',
		data: {
			labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
			datasets: [{
				label: '# of Votes',
				data: [12, 19, 3, 5, 2, 3],
				backgroundColor: [
					'rgba(255, 99, 132, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					'rgba(255, 206, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)',
					'rgba(153, 102, 255, 0.2)',
					'rgba(255, 159, 64, 0.2)'
				],
				borderColor: [
					'rgba(255, 99, 132, 1)',
					'rgba(54, 162, 235, 1)',
					'rgba(255, 206, 86, 1)',
					'rgba(75, 192, 192, 1)',
					'rgba(153, 102, 255, 1)',
					'rgba(255, 159, 64, 1)'
				],
				borderWidth: 1
			}]
		},
		options: {
			responsive: false,
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true
					}
				}]
			},
		}
	});
</script>
</head>
<body>

		<!-- 헤더 -->
		<div id="root">
			<div class="Main false">
				<%@ include file="/WEB-INF/views/layout/header.jsp"%>
				<%@ include file="/WEB-INF/views/manage/managerleft.jsp"%>
				<div class="w3-container managerbox" style="margin-left: 200px">
					<div class="body">
						<div class="content__title">
							<h1>요금제 통계</h1>
						</div>
						
						<canvas id="myChart" width="400" height="400"></canvas>
<!-- 						Area Chart -->
<!-- 						<div class="card shadow mb-4"> -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h6 class="m-0 font-weight-bold text-primary">Area Chart</h6> -->
<!--                                 </div> -->
<!--                                 <div class="card-body"> -->
<!--                                     <div class="chart-area"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> -->
<!--                                         <canvas id="myAreaChart" width="412" height="160" class="chartjs-render-monitor" style="display: block; width: 412px; height: 160px;"></canvas> -->
<!--                                     </div> -->
<!--                                     <hr> -->
<!--                                     Styling for the area chart can be found in the -->
<!--                                     <code>/js/demo/chart-area-demo.js</code> file. -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                            Bar Chart -->
<!--                            <div class="card shadow mb-4"> -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h6 class="m-0 font-weight-bold text-primary">Bar Chart</h6> -->
<!--                                 </div> -->
<!--                                 <div class="card-body"> -->
<!--                                     <div class="chart-bar"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> -->
<!--                                         <canvas id="myBarChart" width="412" height="160" class="chartjs-render-monitor" style="display: block; width: 412px; height: 160px;"></canvas> -->
<!--                                     </div> -->
<!--                                     <hr> -->
<!--                                     Styling for the bar chart can be found in the -->
<!--                                     <code>/js/demo/chart-bar-demo.js</code> file. -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                             Donut Chart -->
<!--                             <div class="col-xl-4 col-lg-5"> -->
<!--                             <div class="card shadow mb-4"> -->
<!--                                 Card Header - Dropdown -->
<!--                                 <div class="card-header py-3"> -->
<!--                                     <h6 class="m-0 font-weight-bold text-primary">Donut Chart</h6> -->
<!--                                 </div> -->
<!--                                 Card Body -->
<!--                                 <div class="card-body"> -->
<!--                                     <div class="chart-pie pt-4"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> -->
<!--                                         <canvas id="myPieChart" width="412" height="216" class="chartjs-render-monitor" style="display: block; width: 412px; height: 216px;"></canvas> -->
<!--                                     </div> -->
<!--                                     <hr> -->
<!--                                     Styling for the donut chart can be found in the -->
<!--                                     <code>/js/demo/chart-pie-demo.js</code> file. -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->

					</div>
				</div>
			</div>
		</div>
</body>
</html>
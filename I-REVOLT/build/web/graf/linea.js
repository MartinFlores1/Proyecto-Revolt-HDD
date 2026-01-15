document.addEventListener('DOMContentLoaded', function () {
    var chartDom = document.getElementById('gr_barra');
    var myChart = echarts.init(chartDom);

    // Function to fetch and render chart
function renderChart(month = '', year = '') {
    // Construct query parameters
    const params = new URLSearchParams();
    if (month) params.append('month', month);
    if (year) params.append('year', year);

    fetch(`${window.appContextPath}/IngresoMensualServlet?${params.toString()}`)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
                var option = {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'category',
                        data: data.months,
                        axisLabel: {
                            rotate: 45,
                            interval: 0
                        }
                    },
                    yAxis: {
                        type: 'value',
                        name: 'Ingresos (S/)',
                        axisLabel: {
                            formatter: 'S/ {value}'
                        }
                    },
                    series: [{
                        name: 'Ingresos',
                        data: data.revenues,
                        type: 'bar',
                        showBackground: true,
                        backgroundStyle: {
                            color: 'rgba(180, 180, 180, 0.2)'
                        },
                        itemStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {offset: 0, color: '#83bff6'},
                                {offset: 0.5, color: '#188df0'},
                                {offset: 1, color: '#188df0'}
                            ])
                        }
                    }]
                };
                myChart.setOption(option);
            })
            .catch(error => {
                console.error('Error fetching monthly revenues:', error);
                chartDom.innerHTML = '<p style="color: red; text-align: center;">No se pudieron cargar los datos de ingresos</p>';
            });
    }

renderChart();

// Function to handle filtering
function handleFiltering() {
    const monthSelect = document.getElementById('mesSelect');
    const yearSelect = document.getElementById('anoSelect');

    const month = monthSelect.value === 'default' ? '' : monthSelect.value;
    const year = yearSelect.value === 'default' ? '' : yearSelect.value;

    renderChart(month, year);
}

// Add event listeners for month and year selects
document.getElementById('mesSelect').addEventListener('change', handleFiltering);
document.getElementById('anoSelect').addEventListener('change', handleFiltering);

// Add resize event listener
window.addEventListener('resize', function() {
    myChart.resize();
});
});
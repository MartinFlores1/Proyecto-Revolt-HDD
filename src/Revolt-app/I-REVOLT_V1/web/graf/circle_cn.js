document.addEventListener('DOMContentLoaded', function () {
    const pieChartContainer = document.getElementById('pieChartContainer');
    const pieChartInstance = echarts.init(pieChartContainer);
    const monthSelect = document.getElementById('mesSelect');
    const yearSelect = document.getElementById('anoSelect');

    // Configuration without hardcoded data
    const pieChartConfig = {
        tooltip: {
            trigger: 'item',
            textStyle: {
                fontSize: 12
            }
        },
        legend: {
            top: '90%',
            left: 'center',
            itemWidth: 10,
            itemHeight: 10,
            orient: 'horizontal',
            textStyle: {
                fontSize: 12
            }
        },
        grid: {
            top: 0,
            bottom: '15%',
            left: '5%',
            right: '5%',
            containLabel: true
        },
        series: [
            {
                name: 'Ventas por Categoría',
                type: 'pie',
                radius: ['40%', '70%'],
                avoidLabelOverlap: false,
                padAngle: 5,
                itemStyle: {
                    borderRadius: 10
                },
                label: {
                    show: true,
                    position: 'inside',  // Inside the pie chart
                    formatter: function (params) {
                        return Math.round(params.percent) + '%';  // Round percentage
                    },
                    fontSize: 12,  // Font size
                    color: '#000',  // Black text for better contrast (you can change to white if needed)
                    backgroundColor: 'rgba(255, 255, 255, 0.7)',  // Semi-transparent white background
                    padding: [6, 6],  // Optional: add padding around the label for better readability
                    borderRadius: 5  // Optional: rounded corners for the background
                },

                emphasis: {
                    label: {
                        show: true,
                        fontSize: 20,
                        fontWeight: 'bold'
                    }
                },
                labelLine: {
                    show: false
                },
                data: [] // Empty data initially
            }
        ]
    };

    function fetchCategoryData() {
        // Prepare parameters
        const month = monthSelect.value === 'default' ? '' : monthSelect.value;
        const year = yearSelect.value === 'default' ? '' : yearSelect.value;

        // Construct query parameters
        const params = new URLSearchParams();
        if (month) params.append('month', month);
        if (year) params.append('year', year);

        // Fetch data from servlet with optional filtering
        fetch(`${window.appContextPath}/ObtenerIngresoPorCategoria?${params.toString()}`)
        .then(response => response.json())
        .then(data => {
            // Update the chart's data
            pieChartConfig.series[0].data = data;
            // Also update legend data
            pieChartConfig.legend.data = data.map(item => item.name);
            // Set the updated configuration
            pieChartInstance.setOption(pieChartConfig);
        })
        .catch(error => {
            console.error('Error fetching category income data:', error);
        });
    }

    // Initial load
    fetchCategoryData();

    // Add event listeners for month and year selects
    monthSelect.addEventListener('change', fetchCategoryData);
    yearSelect.addEventListener('change', fetchCategoryData);

    // Resize handling
    window.addEventListener('resize', function () {
        pieChartInstance.resize();
    });
});

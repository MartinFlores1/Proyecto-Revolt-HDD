document.addEventListener("DOMContentLoaded", function () {
    const chartDom = document.getElementById('main_gr');
    const myChart = echarts.init(chartDom);
    const monthSelect = document.getElementById('mesSelect');
    const yearSelect = document.getElementById('anoSelect');

    function fetchAndRenderChart() {
        // Prepare parameters
        const month = monthSelect.value === 'default' ? '' : monthSelect.value;
        const year = yearSelect.value === 'default' ? '' : yearSelect.value;

        // Construct query parameters
        const params = new URLSearchParams();
        if (month) params.append('month', month);
        if (year) params.append('year', year);

        fetch(`${window.appContextPath}/api/categoria-ingresos?${params.toString()}`)
        .then(response => response.json())
        .then(data => {
            var option = {
                color: ['#80FFA5', '#00DDFF', '#37A2FF', '#FF0087', '#FFBF00'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        label: {
                            backgroundColor: '#6a7985'
                        }
                    }
                },
                legend: {
                    data: data.categorias,
                    bottom: 5
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                grid: {
                    left: '10',
                    right: '10',
                    bottom: '15%',
                    top: '5%',
                    containLabel: true
                },
                xAxis: [{
                    type: 'category',
                    boundaryGap: false,
                    data: ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom']
                }],
                yAxis: {
                    type: 'value',
                    axisLine: {lineStyle: {color: '#ccc'}},
                    axisLabel: {
                        color: '#666',
                        show: false
                    },
                    splitLine: {lineStyle: {type: 'dashed', color: '#ddd'}}
                },
                series: data.categorias.map((categoria, index) => ({
                    name: categoria,
                    type: 'line',
                    stack: 'Total',
                    smooth: true,
                    lineStyle: { width: 0 },
                    showSymbol: false,
                    areaStyle: {
                        opacity: 0.8,
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                            { offset: 0, color: getGradientColors(index)[0] },
                            { offset: 1, color: getGradientColors(index)[1] }
                        ])
                    },
                    emphasis: { focus: 'series' },
                    data: data.seriesData[index]
                }))
            };
            myChart.setOption(option);
        })
        .catch(error => {
            console.error('Error fetching data:', error);
        });
    }

    // Helper function to generate gradient colors
    function getGradientColors(index) {
        const gradientSets = [
            ['rgb(128, 255, 165)', 'rgb(1, 191, 236)'],
            ['rgb(0, 221, 255)', 'rgb(77, 119, 255)'],
            ['rgb(55, 162, 255)', 'rgb(116, 21, 219)'],
            ['rgb(255, 0, 135)', 'rgb(135, 0, 157)']
        ];
        return gradientSets[index % gradientSets.length];
    }

    // Initial load
    fetchAndRenderChart();

    // Add event listeners for month and year selects
    monthSelect.addEventListener('change', fetchAndRenderChart);
    yearSelect.addEventListener('change', fetchAndRenderChart);

    // Redimensionar el gráfico cuando cambia el tamaño de la ventana
    window.addEventListener('resize', function () {
        myChart.resize();
    });
});
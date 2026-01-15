document.addEventListener('DOMContentLoaded', function () {
    const monthSelect = document.getElementById('mesSelect');
    const yearSelect = document.getElementById('anoSelect');

    function fetchRadarData() {
        // Obtener los valores de los selectores
        const month = monthSelect.value === 'default' ? '' : monthSelect.value;
        const year = yearSelect.value === 'default' ? '' : yearSelect.value;

        // Construir los parámetros para el fetch
        const params = new URLSearchParams();
        if (month) params.append('month', month);
        if (year) params.append('year', year);

        // Fetch actualizado con filtros
        fetch(`${window.appContextPath}/IngresoDiaServlet?${params.toString()}`)
            .then(response => response.json())
            .then(data => {
                const chartDom = document.getElementById('radarChart');
                const myChart = echarts.init(chartDom);

                // Configuración del radar
                const radarConfig = {
                    tooltip: { trigger: 'item' },
                    radar: {
                        center: ['50%', '50%'],
                        radius: '68%',
                        indicator: data.indicators
                    },
                    series: [{
                        type: 'radar',
                        symbol: 'none',
                        lineStyle: { width: 1 },
                        areaStyle: { opacity: 0.3 },
                        data: [{ value: data.values, name: 'Ventas por día' }]
                    }]
                };

                myChart.setOption(radarConfig);
                window.addEventListener('resize', function () {
                    myChart.resize();
                });
            })
            .catch(error => {
                console.error('Error fetching radar chart data:', error);
            });
    }

    // Cargar datos al inicio
    fetchRadarData();

    // Actualizar datos al cambiar los selectores
    monthSelect.addEventListener('change', fetchRadarData);
    yearSelect.addEventListener('change', fetchRadarData);
});

document.addEventListener('DOMContentLoaded', function() {
    const metodoPagoContainer = document.getElementById('metodoPago');
    const metodoPagoChart = echarts.init(metodoPagoContainer);

    // Obtener referencias a los selectores de mes y año
    const monthSelect = document.getElementById('mesSelect');
    const yearSelect = document.getElementById('anoSelect');

    // Función para obtener y renderizar los datos del gráfico
    function fetchAndRenderChart() {
        // Leer los valores de los selectores
        const month = monthSelect.value === 'default' ? '' : monthSelect.value;
        const year = yearSelect.value === 'default' ? '' : yearSelect.value;

        // Construir los parámetros de consulta
        const params = new URLSearchParams();
        if (month) params.append('month', month);
        if (year) params.append('year', year);

        // Hacer la solicitud al servlet con los filtros
        fetch(`${window.appContextPath}/IngresoMetodoPagoServlet?${params.toString()}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(paymentData => {
                // Configurar el gráfico con los datos obtenidos
                const option = {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: { type: 'shadow' },
                        formatter: function(params) {
                            const percentage = Math.round(params[0].data) + '%'; // Redondear el porcentaje
                            const amount = 'S/ ' + Math.round(params[1].data).toLocaleString(); // Formatear el monto
                            return `${params[0].name}<br />Porcentaje: ${percentage}<br />Monto: ${amount}`;
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'value',
                        boundaryGap: [0, 0.01]
                    },
                    yAxis: {
                        type: 'category',
                        data: paymentData.map(item => item.product) // Nombres de los métodos de pago
                    },
                    series: [
                        {
                            name: 'Porcentaje',
                            type: 'bar',
                            data: paymentData.map(item => Math.round(item.score)), // Porcentajes
                            itemStyle: {
                                color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [
                                    {offset: 0, color: '#83bff6'},
                                    {offset: 1, color: '#188df0'}
                                ])
                            }
                        },
                        {
                            name: 'Monto',
                            type: 'bar',
                            data: paymentData.map(item => Math.round(item.amount)), // Montos
                            itemStyle: {
                                color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [
                                    {offset: 0, color: '#2af598'},
                                    {offset: 1, color: '#009efd'}
                                ])
                            }
                        }
                    ]
                };

                metodoPagoChart.setOption(option); // Renderizar el gráfico
            })
            .catch(error => {
                console.error('Error fetching payment method data:', error);
                metodoPagoContainer.innerHTML = 'Error al cargar los datos';
            });
    }

    // Renderizar el gráfico inicialmente
    fetchAndRenderChart();

    // Agregar eventos a los selectores de mes y año
    monthSelect.addEventListener('change', fetchAndRenderChart);
    yearSelect.addEventListener('change', fetchAndRenderChart);

    // Ajustar el tamaño del gráfico cuando la ventana cambie de tamaño
    window.addEventListener('resize', function() {
        metodoPagoChart.resize();
    });
});

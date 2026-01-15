document.addEventListener('DOMContentLoaded', function () {
    // Obtain month and year select elements
    const monthSelect = document.getElementById('mesSelect');
    const yearSelect = document.getElementById('anoSelect');

    // Obtain the gauge container
    const gaugeContainer = document.getElementById('circlex');
    const gaugeChart = echarts.init(gaugeContainer);

    // Configuración personalizada
    const CONFIG = {
        panelImageURL: '../img/custom-gauge-panel.png',
        animationDuration: 1000,
        animationDurationUpdate: 1000, // Duración de la animación cuando se actualiza
        animationEasing: 'quarticInOut',
        valOnRadianMax: 100,
        outerRadius: 80,
        innerRadius: 60,
        pointerInnerRadius: 30,
        insidePanelRadius: 40
    };

    function renderItem(params, api) {
        const valOnRadian = api.value(1);  // Este es el valor para el gráfico
        const coords = api.coord([api.value(0), valOnRadian]);
        const polarEndRadian = coords[3];

        const imageStyle = {
            image: CONFIG.panelImageURL,
            x: params.coordSys.cx - CONFIG.outerRadius,
            y: params.coordSys.cy - CONFIG.outerRadius,
            width: CONFIG.outerRadius * 2,
            height: CONFIG.outerRadius * 2
        };

        return {
            type: 'group',
            children: [
                {
                    type: 'image',
                    style: imageStyle,
                    clipPath: {
                        type: 'sector',
                        shape: {
                            cx: params.coordSys.cx,
                            cy: params.coordSys.cy,
                            r: CONFIG.outerRadius,
                            r0: CONFIG.innerRadius,
                            startAngle: 0,
                            endAngle: -polarEndRadian,
                            transition: 'endAngle',
                            enterFrom: {endAngle: 0}
                        }
                    }
                },
                {
                    type: 'image',
                    style: imageStyle,
                    clipPath: {
                        type: 'polygon',
                        shape: {
                            points: makePionterPoints(params, polarEndRadian)
                        },
                        extra: {
                            polarEndRadian: polarEndRadian,
                            transition: 'polarEndRadian',
                            enterFrom: {polarEndRadian: 0}
                        },
                        during: function (apiDuring) {
                            apiDuring.setShape('points',
                                makePionterPoints(params, apiDuring.getExtra('polarEndRadian'))
                            );
                        }
                    }
                },
                {
                    type: 'circle',
                    shape: {
                        cx: params.coordSys.cx,
                        cy: params.coordSys.cy,
                        r: CONFIG.insidePanelRadius
                    },
                    style: {
                        fill: '#fff',
                        shadowBlur: 25,
                        shadowOffsetX: 0,
                        shadowOffsetY: 0,
                        shadowColor: 'rgba(76,107,167,0.4)'
                    }
                },
                {
                    type: 'text',
                    extra: {
                        valOnRadian: valOnRadian,
                        transition: 'valOnRadian',
                        enterFrom: {valOnRadian: 0}
                    },
                    style: {
                        // Aquí usar el valor de `customerCount` directamente
                        text: makeText(api.value(0)),  // Mostrar el valor que obtienes de la base de datos
                        fontSize: 28,
                        fontWeight: 700,
                        x: params.coordSys.cx,
                        y: params.coordSys.cy,
                        fill: 'rgb(0,50,190)',
                        align: 'center',
                        verticalAlign: 'middle',
                        enterFrom: {opacity: 0}
                    },
                    during: function (apiDuring) {
                        apiDuring.setStyle('text',
                            makeText(apiDuring.getExtra('valOnRadian'))
                        );
                    }
                }
            ]
        };
    }

    function convertToPolarPoint(renderItemParams, radius, radian) {
        return [
            Math.cos(radian) * radius + renderItemParams.coordSys.cx,
            -Math.sin(radian) * radius + renderItemParams.coordSys.cy
        ];
    }

    function makePionterPoints(renderItemParams, polarEndRadian) {
        return [
            convertToPolarPoint(renderItemParams, CONFIG.outerRadius, polarEndRadian),
            convertToPolarPoint(renderItemParams, CONFIG.outerRadius, polarEndRadian + Math.PI * 0.03),
            convertToPolarPoint(renderItemParams, CONFIG.pointerInnerRadius, polarEndRadian)
        ];
    }

    function makeText(val) {
        // Devolvemos el valor que se obtiene de la base de datos, sin transformaciones
        return Math.round(val).toString();
    }

    const gaugeOptions = {
        animationEasing: CONFIG.animationEasing,
        animationDuration: CONFIG.animationDuration,
        animationDurationUpdate: CONFIG.animationDurationUpdate,
        animationEasingUpdate: CONFIG.animationEasing,
        dataset: {
            source: [[1, 100]] // Valor inicial en 100
        },
        tooltip: {
            // Mostrar el valor real en el tooltip
            formatter: function (params) {
                return 'Valor: ' + Math.round(params.value[1]);
            }
        },
        angleAxis: {
            type: 'value',
            startAngle: 0,
            show: false,
            min: 0,
            max: CONFIG.valOnRadianMax
        },
        radiusAxis: {
            type: 'value',
            show: false
        },
        polar: {},
        series: [{
            type: 'custom',
            coordinateSystem: 'polar',
            renderItem: renderItem
        }]
    };

    // Inicializar el gauge
    gaugeChart.setOption(gaugeOptions);

    // Función para obtener el número de clientes
     function fetchCustomerCount() {
        // Prepare parameters
        const month = monthSelect.value === 'default' ? '' : monthSelect.value;
        const year = yearSelect.value === 'default' ? '' : yearSelect.value;

        // Construct query parameters
        const params = new URLSearchParams();
        if (month) params.append('month', month);
        if (year) params.append('year', year);

        fetch(`${window.appContextPath}/CantidadUsuariosServlet?${params.toString()}`)
            .then(response => response.json())
            .then(data => {
                const customerCount = data.customerCount;
                
                // Update the gauge chart
                gaugeChart.setOption({
                    dataset: {
                        source: [[customerCount, customerCount]]
                    }
                });
            })
            .catch(error => {
                console.error('Error fetching customer count:', error);
            });
    }

    // Obtener el conteo inicial de clientes
   fetchCustomerCount();

    // Add event listeners for month and year selects
    monthSelect.addEventListener('change', fetchCustomerCount);
    yearSelect.addEventListener('change', fetchCustomerCount);

    // Make the chart responsive
    window.addEventListener('resize', function () {
        gaugeChart.resize();
    });
});
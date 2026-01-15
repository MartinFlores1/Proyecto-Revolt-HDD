// Obtener el contenedor del gráfico
const gaugeChart = document.getElementById('gaugeContainer');
// Inicializar el gráfico con un método de redimensionamiento debounce
const speedGauge = echarts.init(gaugeChart);

// Función debounce para optimizar los eventos de redimensionamiento
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Configuración del gauge
const gaugeConfig = {
    series: [{
        type: 'gauge',
        startAngle: 200,
        endAngle: -20,
        min: 0,
        max: 100,
        splitNumber: 4,
        itemStyle: {
            color: '#58D9F9',
            shadowColor: 'rgba(0,138,255,0.45)',
            shadowBlur: 10,
            shadowOffsetX: 2,
            shadowOffsetY: 2
        },
        progress: {
            show: true,
            roundCap: true,
            width: 8
        },
        pointer: {
            icon: 'path://M2090.36389,615.30999 L2090.36389,615.30999 C2091.48372,615.30999 2092.40383,616.194028 2092.44859,617.312956 L2096.90698,728.755929 C2097.05155,732.369577 2094.2393,735.416212 2090.62566,735.56078 C2090.53845,735.564269 2090.45117,735.566014 2090.36389,735.566014 L2090.36389,735.566014 C2086.74736,735.566014 2083.81557,732.63423 2083.81557,729.017692 C2083.81557,728.930412 2083.81732,728.84314 2083.82081,728.755929 L2088.2792,617.312956 C2088.32396,616.194028 2089.24407,615.30999 2090.36389,615.30999 Z',
            length: '75%',
            width: 8,
            offsetCenter: [0, '5%']
        },
        axisLine: {
            roundCap: true,
            lineStyle: {
                width: 8
            }
        },
        axisTick: {
            splitNumber: 2,
            lineStyle: {
                width: 2,
                color: '#999'
            }
        },
        splitLine: {
            length: 6,
            lineStyle: {
                width: 3,
                color: '#999'
            }
        },
        axisLabel: {
            distance: 15,
            color: '#999',
            fontSize: 12
        },
        title: {
            show: false
        },
        detail: {
            backgroundColor: '#fff',
            borderColor: '#999',
            width: '60%',
            lineHeight: 40,
            height: 40,
            borderRadius: 8,
            offsetCenter: [0, '80%'],
            valueAnimation: true,
            formatter: function(value) {
                return '{value|' + value.toFixed(0) + '}{unit|%}';
            },
            rich: {
                value: {
                    fontSize: 25,
                    fontWeight: 'bolder',
                    color: '#777'
                },
                unit: {
                    fontSize: 15,
                    color: '#999',
                    padding: [0, 0, -20, 10]
                }
            }
        },
        data: [{
            value: 41 // Establece un valor fijo de 41
        }]
    }]
};

// Inicializar el gauge
speedGauge.setOption(gaugeConfig);

// Añadir evento de redimensionamiento con debounce
window.addEventListener('resize', debounce(function() {
    speedGauge.resize({
        width: 'auto',  // Ancho automático
        height: 'auto'  // Altura automática
    });
}, 250));  

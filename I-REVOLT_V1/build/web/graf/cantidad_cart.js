document.addEventListener('DOMContentLoaded', function() {
    // Function to fetch and update total revenue
    function updateTotalRevenue() {
        const monthSelect = document.getElementById('mesSelect');
        const yearSelect = document.getElementById('anoSelect');
        
        const month = monthSelect.value;
        const year = yearSelect.value;

        // Fetch total revenue
        fetch(`${window.appContextPath}/TotalIngresoMensualServlet?month=${month}&year=${year}`)
            .then(response => response.json())
            .then(data => {
                const totalRevenueElement = document.getElementById('totalRevenueDisplay');
                totalRevenueElement.textContent = `S/ ${data.totalRevenue.toLocaleString('es-PE', {minimumFractionDigits: 2, maximumFractionDigits: 2})}`;
            })
            .catch(error => {
                console.error('Error fetching total revenue:', error);
                document.getElementById('totalRevenueDisplay').textContent = 'Error al cargar';
            });

        // Fetch total orders
        fetch(`${window.appContextPath}/TotalOrdenesMensualesServlet?month=${month}&year=${year}`)
            .then(response => response.json())
            .then(data => {
                const totalOrdersElement = document.getElementById('totalOrdersDisplay');
                totalOrdersElement.textContent = data.totalOrdenes;
            })
            .catch(error => {
                console.error('Error fetching total orders:', error);
                document.getElementById('totalOrdersDisplay').textContent = 'Error';
            });
    }

    // Update revenue and orders when month or year is changed
    document.getElementById('mesSelect').addEventListener('change', updateTotalRevenue);
    document.getElementById('anoSelect').addEventListener('change', updateTotalRevenue);

    // Initial load
    updateTotalRevenue();
});
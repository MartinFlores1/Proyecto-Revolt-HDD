document.addEventListener("DOMContentLoaded", function() {
    // Filtro de productos
    const searchInput = document.getElementById("search");
    searchInput.addEventListener("input", function(event) {
        const query = event.target.value.toLowerCase();
        const products = document.querySelectorAll(".product");

        products.forEach(function(product) {
            const productName = product.querySelector("p").textContent.toLowerCase();
            if (productName.includes(query)) {
                product.style.display = "block";
            } else {
                product.style.display = "none";
            }
        });
    });

    // Lógica del Dropdown
    const dropdownButton = document.getElementById("dropdownButton");
    const dropdownMenu = document.getElementById("dropdownMenu");
    const dropdownPrompt = document.getElementById("dropdownPrompt");

    // Muestra u oculta el menú desplegable
    dropdownButton.addEventListener("click", function(event) {
        event.stopPropagation(); // Previene que el clic se propague a la parte de abajo
        dropdownMenu.classList.toggle("show");
    });

    // Cambia el valor del botón al seleccionar un item del menú
    const items = document.querySelectorAll(".dropdown-item");
    items.forEach(item => {
        item.addEventListener("click", function() {
            dropdownPrompt.textContent = item.textContent;  // Cambia el texto mostrado
            items.forEach(i => i.classList.remove("selected"));  // Elimina la selección de otros elementos
            item.classList.add("selected");  // Marca el item seleccionado
            dropdownMenu.classList.remove("show");  // Cierra el menú
        });
    });

    // Cierra el menú si se hace clic fuera de él
    document.addEventListener("click", function(event) {
        if (!dropdownButton.contains(event.target)) {
            dropdownMenu.classList.remove("show");
        }
    });
});

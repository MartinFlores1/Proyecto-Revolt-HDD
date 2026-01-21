// Función para actualizar el contador del carrito en el botón
function updateCartCount() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const cartCount = cart.reduce((total, product) => total + product.quantity, 0);  // Sumar las cantidades de productos
    const cartCountElement = document.getElementById('cart-count');
    cartCountElement.textContent = cartCount;
}


document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("checkoutForm");
    const orderSummary = document.getElementById("orderSummary");
    const orderDetails = document.getElementById("orderDetails");
    const orderTotal = document.getElementById("orderTotal");
    const editInfoButton = document.getElementById("editInfo");
    const confirmOrderButton = document.getElementById("confirmOrder");

    // Validar y procesar el formulario
    form.addEventListener("submit", (e) => {
        e.preventDefault();

        const name = document.getElementById("name").value;
        const address = document.getElementById("address").value;
        const city = document.getElementById("city").value;
        const country = document.getElementById("country").value;
        const postalCode = document.getElementById("postalCode").value;
        const paymentMethod = document.getElementById("paymentMethod").value;

        if (!name || !address || !city || !country || !postalCode || !paymentMethod) {
            alert("Por favor, complete todos los campos requeridos.");
            return;
        }

        // Mostrar el resumen del pedido
        form.style.display = "none";
        orderSummary.style.display = "block";

        // Cargar detalles del pedido
        const cart = JSON.parse(localStorage.getItem("cart")) || [];
        let total = 0;
        orderDetails.innerHTML = "";

        cart.forEach((item) => {
            const subtotal = item.price * item.quantity;
            total += subtotal;

            orderDetails.innerHTML += `
                <tr>
                    <td>${item.name}</td>
                    <td>x${item.quantity}</td>
                    <td>S/ ${subtotal.toFixed(2)}</td>
                </tr>
            `;
        });

        // Agregar total al resumen
        orderTotal.textContent = `S/ ${total.toFixed(2)}`;
    });

    // Volver a editar la información
    editInfoButton.addEventListener("click", () => {
        form.style.display = "block";
        orderSummary.style.display = "none";
    });

    // Confirmar y proceder
    confirmOrderButton.addEventListener("click", () => {
        alert("¡Pedido confirmado! Redirigiendo a la página de agradecimiento...");
        window.location.href = "thankyou.html";
    });
});




document.addEventListener('DOMContentLoaded', updateCartCount);
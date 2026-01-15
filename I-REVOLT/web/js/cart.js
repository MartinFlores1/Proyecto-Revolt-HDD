// Función para actualizar el contador del carrito en el botón
function updateCartCount() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const cartCount = cart.reduce((total, product) => total + product.quantity, 0);  // Sumar las cantidades de productos
    const cartCountElement = document.getElementById('cart-count');
    cartCountElement.textContent = cartCount;
}

// Cargar productos del carrito
function loadCart() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const cartItems = document.getElementById('cartItems');
    const subtotalElement = document.getElementById('subtotal');

    cartItems.innerHTML = '';
    let total = 0;

    cart.forEach(item => {
        const subtotal = item.price * item.quantity;
        total += subtotal;

        cartItems.innerHTML += `
            <tr>
                <td>
                    <img src="${item.image}" alt="${item.name}" style="width: 60px; height: auto; margin-right: 10px;">
                    ${item.name}
                </td>
                <td>S/ ${item.price.toFixed(2)}</td>
                <td>
                    <button class="decrement btn btn-light btn-sm" data-id="${item.id}">-</button>
                    ${item.quantity}
                    <button class="increment btn btn-light btn-sm" data-id="${item.id}">+</button>
                </td>
                <td>S/ ${subtotal.toFixed(2)}</td>
                <td><button class="remove btn btn-danger btn-sm" data-id="${item.id}">Eliminar</button></td>
            </tr>
        `;
    });

    // Actualizar subtotal en el DOM
    subtotalElement.textContent = total.toFixed(2);
}


// Incrementar cantidad
function incrementQuantity(productId) {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const product = cart.find(item => item.id === productId);
    if (product) {
        product.quantity += 1;
        localStorage.setItem('cart', JSON.stringify(cart));
        loadCart();
    }
}

// Decrementar cantidad
function decrementQuantity(productId) {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const product = cart.find(item => item.id === productId);
    if (product) {
        product.quantity = Math.max(1, product.quantity - 1);
        localStorage.setItem('cart', JSON.stringify(cart));
        loadCart();
    }
}

// Eliminar producto
function removeProduct(productId) {
    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    cart = cart.filter(item => item.id !== productId);
    localStorage.setItem('cart', JSON.stringify(cart));
    loadCart();
}

// Event Listeners
document.getElementById('cartItems').addEventListener('click', (e) => {
    const target = e.target;
    const productId = Number(target.dataset.id);

    if (target.classList.contains('increment')) {
        incrementQuantity(productId);
    } else if (target.classList.contains('decrement')) {
        decrementQuantity(productId);
    } else if (target.classList.contains('remove')) {
        removeProduct(productId);
    }
});


document.addEventListener('DOMContentLoaded', function() {
    const proceedButton = document.getElementById('proceedButton');
    const loginModal = document.getElementById('loginModal');
    
    proceedButton.addEventListener('click', function() {
        $(loginModal).modal('show');
    });

    const closeButton = document.querySelector('.close');
    if (closeButton) {
        closeButton.addEventListener('click', function() {
            $(loginModal).modal('hide');
        });
    }
});






// Inicializar carrito



document.addEventListener('DOMContentLoaded', loadCart);

document.addEventListener('DOMContentLoaded', updateCartCount);
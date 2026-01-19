let products = [];

// Obtener productos desde el servlet
async function fetchProducts() {
    try {
        const response = await fetch('/I-REVOLT/ProductoServlet');
        if (!response.ok) throw new Error('Error al obtener los productos');
        products = await response.json();
        applyFilters(); // Renderizar los productos después de obtenerlos
    } catch (error) {
        console.error('Error:', error);
    }
}

async function fetchProductsDetails() {
    try {
        const response = await fetch('/I-REVOLT/ProductoDetalleServlet');
        if (!response.ok) throw new Error('Error al obtener los productos');
        products = await response.json();
        applyFilters(); // Renderizar los productos después de obtenerlos
    } catch (error) {
        console.error('Error:', error);
    }
}

// Variables para almacenar los filtros activos
let activeFilters = {
    categories: [],
    brands: [],
    colors: [],
    maxPrice: 1000,
    searchTerm: '',
    sortOrder: ''
};

// Función para agregar al carrito
function addToCart(productId) {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const product = products.find(p => p.id === productId);

    // Verificar si el producto ya está en el carrito
    const existingProduct = cart.find(item => item.id === productId);
    if (existingProduct) {
        existingProduct.quantity += 1; // Incrementar cantidad
    } else {
        cart.push({...product, quantity: 1}); // Agregar nuevo producto con cantidad 1
    }

    localStorage.setItem('cart', JSON.stringify(cart));
showAlert(`${product.name} ha sido agregado al carrito.`);

    // Actualizar el contador de productos en el carrito
    updateCartCount();
}
function showAlert(message, type = 'success') {
    const alertContainer = document.getElementById('alertContainer');

    // Crear el div del mensaje
    const alertDiv = document.createElement('div');
    alertDiv.classList.add('alert');
    if (type === 'error') {
        alertDiv.style.backgroundColor = '#f44336'; // Rojo para errores
    }

    alertDiv.innerHTML = `
        <span>${message}</span>
        <button class="close-btn">&times;</button>
    `;

    // Agregar al contenedor
    alertContainer.appendChild(alertDiv);

    // Cerrar el mensaje al hacer clic en el botón "X"
    alertDiv.querySelector('.close-btn').addEventListener('click', () => {
        alertDiv.remove();
    });

    // Eliminar automáticamente después de 3 segundos
    setTimeout(() => {
        alertDiv.remove();
    }, 3000);
}
// Función para actualizar el contador del carrito en el botón
function updateCartCount() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const cartCount = cart.reduce((total, product) => total + product.quantity, 0);  // Sumar las cantidades de productos
    const cartCountElement = document.getElementById('cart-count');
    cartCountElement.textContent = cartCount;
}



// Función para renderizar productos
function renderProducts(filteredProducts) {
    const grid = document.getElementById('productsGrid');
    grid.innerHTML = '';

    filteredProducts.forEach(product => {
        const productCard = `
                <link href="otros/prx.css" rel="stylesheet" type="text/css"/>
                   <div class="col-md-6 col-lg-4 col-xl-3 mb-4">
                        <div class="card text-center cart_pd">
                            <div class="cart_pd__img">
                                 <img src="${product.image}" class="card-img-top" alt="${product.name}">
                                <div class="cart_pd__imgOverlay justify-content-center align-items-center">
                                    <ul class="list-inline mb-0">
        <li class="list-inline-item"><button class="btn btn-outline-primary" onclick="selectProductDetails(${product.id})"><i class="fa-solid fa-magnifying-glass"></i></button></li>
                                          <li class="list-inline-item"><button class="btn btn-outline-primary" onclick="addToCart(${product.id})"><i class="fa-solid fa-cart-shopping"></i></button></li>
                                        <li class="list-inline-item"><button class="btn btn-outline-primary"><i class="fa-regular fa-heart"></i></button></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body">
                                <p>${product.brand}</p>
                          <h5 class="cart_pd__title"><a href="single-product.html" onclick="selectProductDetails(${product.id})">${product.name}</a></h5>
                                <p class="cart_pd__price">S/ ${product.price}</p>
                            </div>
                        </div>
                    </div>
                `;
        grid.innerHTML += productCard;
    });
}

// Función para aplicar filtros
function applyFilters() {
    let filteredProducts = products.filter(product => {
        const categoryMatch = activeFilters.categories.length === 0 ||
                activeFilters.categories.includes(product.category);
        const brandMatch = activeFilters.brands.length === 0 ||
                activeFilters.brands.includes(product.brand);
        const colorMatch = activeFilters.colors.length === 0 ||
                activeFilters.colors.includes(product.color);
        const priceMatch = product.price <= activeFilters.maxPrice;
        const searchMatch = product.name.toLowerCase().includes(activeFilters.searchTerm.toLowerCase());

        return categoryMatch && brandMatch && colorMatch && priceMatch && searchMatch;
    });

    // Aplicar ordenamiento
    if (activeFilters.sortOrder) {
        filteredProducts.sort((a, b) => {
            return activeFilters.sortOrder === 'asc' ?
                    a.price - b.price :
                    b.price - a.price;
        });
    }

    renderProducts(filteredProducts);
}

// Event Listeners
// Categorías
document.querySelectorAll('.category-filter').forEach(checkbox => {
    checkbox.addEventListener('change', (e) => {
        if (e.target.checked) {
            activeFilters.categories.push(e.target.value);
        } else {
            activeFilters.categories = activeFilters.categories.filter(cat => cat !== e.target.value);
        }
        applyFilters();
    });
});

// Marcas
document.querySelectorAll('.brand-filter').forEach(checkbox => {
    checkbox.addEventListener('change', (e) => {
        if (e.target.checked) {
            activeFilters.brands.push(e.target.value);
        } else {
            activeFilters.brands = activeFilters.brands.filter(brand => brand !== e.target.value);
        }
        applyFilters();
    });
});

// Colores
document.querySelectorAll('.color-option').forEach(colorDiv => {
    colorDiv.addEventListener('click', () => {
        colorDiv.classList.toggle('selected');
        const color = colorDiv.dataset.color;

        if (colorDiv.classList.contains('selected')) {
            activeFilters.colors.push(color);
        } else {
            activeFilters.colors = activeFilters.colors.filter(c => c !== color);
        }
        applyFilters();
    });
});

// Precio
const priceRange = document.getElementById('priceRange');
const maxPrice = document.getElementById('maxPrice');

priceRange.addEventListener('input', (e) => {
    activeFilters.maxPrice = Number(e.target.value);
    maxPrice.textContent = `$${activeFilters.maxPrice}`;
    applyFilters();
});

// Búsqueda
const searchInput = document.getElementById('searchInput');
searchInput.addEventListener('input', (e) => {
    activeFilters.searchTerm = e.target.value;
    applyFilters();
});

// Ordenamiento
const sortSelect = document.getElementById('sortSelect');
sortSelect.addEventListener('change', (e) => {
    activeFilters.sortOrder = e.target.value;
    applyFilters();
});


function selectProductDetails(productId) {
    // Buscar el producto en la lista de productos
    const product = products.find(p => p.id === productId);
    if (product) {
        // Guardar el producto seleccionado en localStorage
        localStorage.setItem('selectedProduct', JSON.stringify(product));
        // Redirigir a la página de producto
        window.location.href = 'single-product.html';
    } else {
        console.error('Producto no encontrado');
    }
}

// Inicializar la vista
// Inicializar la vista
applyFilters();
fetchProducts();


// Llamar a la función para actualizar el contador al cargar la página
document.addEventListener('DOMContentLoaded', updateCartCount);


// Lista de IDs seleccionados para el primer grupo de productos
let selectedIds = [5, 6, 7, 8, 9, 10, 11, 12];

// Obtener productos para el primer grupo
async function fetchProducts() {
    try {
        const response = await fetch('/I-REVOLT/ProductoServlet');
        if (!response.ok) throw new Error('Error al obtener los productos');
        const products = await response.json();

        // Filtrar productos por los IDs seleccionados
        let filteredProducts = products.filter(product => selectedIds.includes(product.id));

        // Reordenar los productos según el orden de `selectedIds`
        filteredProducts.sort((a, b) => selectedIds.indexOf(a.id) - selectedIds.indexOf(b.id));

        renderProducts(filteredProducts); // Mostrar los productos filtrados y ordenados
    } catch (error) {
        console.error('Error:', error);
    }
}

// Función para renderizar productos en el primer contenedor
function renderProducts(products) {
    const grid = document.getElementById('productsGrid'); // Contenedor del primer grupo de productos
    grid.innerHTML = ''; // Limpiar el contenedor

    products.forEach(product => {
        const productCard = `
         <link href="otros/prx.css" rel="stylesheet" type="text/css"/>
            <div class="col-md-6 col-lg-4 col-xl-3 mb-4">
                <div class="card text-center cart_pd">
                    <div class="cart_pd__img">
                        <img src="${product.image}" class="card-img-top" alt="${product.name}">
                        <div class="cart_pd__imgOverlay justify-content-center align-items-center">
                            <ul class="list-inline mb-0">
                                <li class="list-inline-item"><button class="btn btn-outline-primary"><i class="fa-solid fa-magnifying-glass"></i></button></li>
                                <li class="list-inline-item"><button class="btn btn-outline-primary"><i class="fa-solid fa-cart-shopping"></i></button></li>
                                <li class="list-inline-item"><button class="btn btn-outline-primary"><i class="fa-regular fa-heart"></i></button></li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-body">
                        <p>${product.brand}</p>
                        <h5 class="cart_pd__title"><a href="single-product.html">${product.name}</a></h5>
                        <p class="cart_pd__price">S/ ${product.price}</p>
                    </div>
                </div>
            </div>
        `;
        grid.innerHTML += productCard;
    });
}

// Inicializar la vista para el primer grupo
fetchProducts();

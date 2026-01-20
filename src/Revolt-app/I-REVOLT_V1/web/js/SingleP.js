// Recuperar el producto seleccionado desde la página de categoría
const selectedProduct = JSON.parse(localStorage.getItem('selectedProduct'));

if (selectedProduct) {
       // Seleccionar todos los elementos de imagen en el carrusel
    const carouselImages = document.querySelectorAll('#carouselExample .carousel-item img');
    
    // Asignar las imágenes de manera dinámica
    carouselImages[0].src = selectedProduct.image; // Imagen principal
    carouselImages[1].src = selectedProduct.image_dir_d_01 || selectedProduct.image; // Primera imagen adicional
    carouselImages[2].src = selectedProduct.image_dir_d_02 || selectedProduct.image; // Segunda imagen adicional
    carouselImages[3].src = selectedProduct.image_dir_d_03 || selectedProduct.image; // Tercera imagen adicional
    
    // Asignar los valores del producto a los elementos del HTML
    document.getElementById('productImage').src = selectedProduct.image;
    document.getElementById('productName').textContent = selectedProduct.name;
    document.getElementById('productPrice').textContent = `$${selectedProduct.price.toFixed(2)}`;
    document.getElementById('productCategory').textContent = selectedProduct.category;
    document.getElementById('productBrand').textContent = selectedProduct.brand;
    document.getElementById('productColor').textContent = selectedProduct.color;
    document.getElementById('productDescription').textContent = selectedProduct.description || "No hay descripción disponible.";

    // Información adicional o secciones específicas si son necesarias
    const specPrice = document.getElementById('productSpecPrice');
    const specCategory = document.getElementById('productSpecCategory');
    const specBrand = document.getElementById('productSpecBrand');
    const specColor = document.getElementById('productSpecColor');

    if (specPrice) specPrice.textContent = `$${selectedProduct.price.toFixed(2)}`;
    if (specCategory) specCategory.textContent = selectedProduct.category;
    if (specBrand) specBrand.textContent = selectedProduct.brand;
    if (specColor) specColor.textContent = selectedProduct.color;

    const descriptionName = document.getElementById('productDescriptionName');
    const descriptionCategory = document.getElementById('productDescriptionCategory');
    const descriptionBrand = document.getElementById('productDescriptionBrand');
    const descriptionColor = document.getElementById('productDescriptionColor');

    if (descriptionName) descriptionName.textContent = selectedProduct.name;
    if (descriptionCategory) descriptionCategory.textContent = selectedProduct.category;
    if (descriptionBrand) descriptionBrand.textContent = selectedProduct.brand;
    if (descriptionColor) descriptionColor.textContent = selectedProduct.color;
    
    
    
// Manejar el botón de "Añadir al carrito"
    const addToCartButton = document.getElementById('addToCartButton');
    addToCartButton.addEventListener('click', (e) => {
        e.preventDefault();

        // Lógica para agregar al carrito
        const cart = JSON.parse(localStorage.getItem('cart')) || [];
        const existingProduct = cart.find(item => item.id === selectedProduct.id);

        if (existingProduct) {
            existingProduct.quantity += 1; // Incrementar cantidad si ya existe
        } else {
            cart.push({ ...selectedProduct, quantity: 1 }); // Agregar nuevo producto
        }

        localStorage.setItem('cart', JSON.stringify(cart)); // Guardar en localStorage
        alert(`${selectedProduct.name} ha sido agregado al carrito.`);

        // Actualizar contador del carrito
        updateCartCount();
    });




} else {
    // Redirigir a la página de categoría si no hay un producto seleccionado
    window.location.href = 'category.html';
}


function updateCartCount() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const cartCount = cart.reduce((total, product) => total + product.quantity, 0);  
    const cartCountElement = document.getElementById('cart-count');
    cartCountElement.textContent = cartCount;
}
updateCartCount();


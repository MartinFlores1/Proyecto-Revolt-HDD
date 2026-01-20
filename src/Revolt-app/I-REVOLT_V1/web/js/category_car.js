// Lista de IDs de productos más vendidos
const topSellingIds = [5, 6,10, 11, 12, 8];

// Función para obtener y mostrar los productos más vendidos
async function fetchTopSellingProducts() {
    try {
        const response = await fetch('/I-REVOLT/ProductoServlet');
        if (!response.ok) {
            throw new Error('Error al obtener los productos');
        }
        const products = await response.json();

        // Filtrar y ordenar productos según los IDs seleccionados
        const filteredProducts = products
                .filter(product => topSellingIds.includes(product.id))
                .sort((a, b) => topSellingIds.indexOf(a.id) - topSellingIds.indexOf(b.id));

        renderTopSellingProducts(filteredProducts);
        initializeCarousel(); // Inicializar el carrusel después de renderizar
    } catch (error) {
        console.error('Error al cargar productos:', error);
        document.querySelector('.second-carousel-container').innerHTML = `
            <div class="alert alert-danger">
                Error al cargar los productos. Por favor, intente más tarde.
            </div>
        `;
    }
}

// Función para renderizar los productos en el carrusel
function renderTopSellingProducts(products) {
    const carouselTrack = document.createElement('div');
    carouselTrack.className = 'second-carousel-track';

    products.forEach(product => {
        const slide = `
            <div class="second-carousel-slide">
                <div class="second-image-container">
                    <div class="card text-center card-product">
                        <div class="card-product__img">
                            <img class="card-img-top" src="${product.image}" alt="${product.name}">
                            <ul class="card-product__imgOverlay list-inline mb-0">
                                <li class="list-inline-item">
                                    <button class="btn btn-outline-primary">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </button>
                                </li>
                                <li class="list-inline-item">
                                    <button class="btn btn-outline-primary">
                                        <i class="fa-solid fa-cart-shopping"></i>
                                    </button>
                                </li>
                                <li class="list-inline-item">
                                    <button class="btn btn-outline-primary">
                                        <i class="fa-regular fa-heart"></i>
                                    </button>
                                </li>
                            </ul>
                        </div>
                        <div class="card-body">
                            <p>${product.category}</p>
                            <h4 class="card-product__title">
                                <a href="single-product.html">${product.name}</a>
                            </h4>
                            <p class="card-product__price">$${product.price.toFixed(2)}</p>
                        </div>
                    </div>
                </div>
            </div>
        `;
        carouselTrack.innerHTML += slide;
    });

    // Clonar slides para el efecto infinito
    const slides = carouselTrack.querySelectorAll('.second-carousel-slide');
    slides.forEach(slide => {
        const clone = slide.cloneNode(true);
        carouselTrack.appendChild(clone);
    });

    // Reemplazar el contenido del contenedor del carrusel
    const container = document.querySelector('.second-carousel-container');
    container.innerHTML = '';
    container.appendChild(carouselTrack);

    // Agregar botones de navegación
    container.innerHTML += `
        <button class="second-carousel-btn second-prev">❮</button>
        <button class="second-carousel-btn second-next">❯</button>
    `;
}

// Función para inicializar el carrusel
function initializeCarousel() {
    // Reutilizar la lógica existente del carrusel
    const secondTrack = document.querySelector('.second-carousel-track');
    const secondSlides = document.querySelectorAll('.second-carousel-slide');
    const secondPrevBtn = document.querySelector('.second-prev');
    const secondNextBtn = document.querySelector('.second-next');

    let secondIsDragging = false;
    let secondStartPos = 0;
    let secondCurrentTranslate = 0;
    let secondPrevTranslate = 0;
    let secondAnimationID = 0;
    let secondCurrentIndex = 0;
    let secondSlideWidth = getSecondSlideWidth(); // Función para obtener el ancho según el viewport
    let secondIsTransitioning = false;

// Función para obtener el ancho del slide según el viewport
    function getSecondSlideWidth() {
        if (window.innerWidth <= 768) {
            return 100; // 1 producto en móvil
        } else if (window.innerWidth <= 992) {
            return 50; // 2 productos en tablet
        } else if (window.innerWidth <= 1200) {
            return 33.333; // 3 productos en pantallas grandes
        } else {
            return 25; // 4 productos en pantallas muy grandes
        }
    }

// Actualizar slideWidth cuando cambie el tamaño de la ventana
    window.addEventListener('resize', () => {
        secondSlideWidth = getSecondSlideWidth();
        // Actualizar la posición del carrusel
        secondTrack.style.transition = 'none';
        secondTrack.style.transform = `translateX(-${secondCurrentIndex * secondSlideWidth}%)`;
        secondPrevTranslate = -secondCurrentIndex * secondSlideWidth * (secondTrack.offsetWidth / 100);
        secondCurrentTranslate = secondPrevTranslate;
    });

    secondSlides.forEach(slide => {
        const clone = slide.cloneNode(true);
        secondTrack.appendChild(clone);
    });

    secondTrack.addEventListener('mousedown', secondDragStart);
    secondTrack.addEventListener('touchstart', secondDragStart);
    secondTrack.addEventListener('mouseup', secondDragEnd);
    secondTrack.addEventListener('touchend', secondDragEnd);
    secondTrack.addEventListener('mousemove', secondDrag);
    secondTrack.addEventListener('touchmove', secondDrag);
    secondTrack.addEventListener('mouseleave', secondDragEnd);

    function secondDragStart(event) {
        if (secondIsTransitioning)
            return;
        event.preventDefault();
        secondStartPos = event.type === 'touchstart' ? event.touches[0].clientX : event.clientX;
        secondIsDragging = true;
        secondTrack.classList.add('dragging');
        secondAnimationID = requestAnimationFrame(secondAnimation);
    }

    function secondDrag(event) {
        if (!secondIsDragging)
            return;
        const currentPosition = event.type === 'touchmove' ? event.touches[0].clientX : event.clientX;
        secondCurrentTranslate = secondPrevTranslate + (currentPosition - secondStartPos);
    }

    function secondDragEnd() {
        secondIsDragging = false;
        secondTrack.classList.remove('dragging');
        cancelAnimationFrame(secondAnimationID);
        const movedBy = secondCurrentTranslate - secondPrevTranslate;
        if (Math.abs(movedBy) > 100) {
            secondUpdateCarousel(movedBy < 0 ? 1 : -1);
        } else {
            secondUpdateCarousel(0);
        }
    }

    function secondAnimation() {
        secondSetSliderPosition();
        if (secondIsDragging)
            requestAnimationFrame(secondAnimation);
    }

    function secondSetSliderPosition() {
        secondTrack.style.transform = `translateX(${secondCurrentTranslate}px)`;
    }

    function secondUpdateCarousel(direction) {
        if (secondIsTransitioning)
            return;
        secondIsTransitioning = true;
        secondCurrentIndex += direction;
        secondTrack.style.transition = 'transform 0.5s ease-in-out';
        secondTrack.style.transform = `translateX(-${secondCurrentIndex * secondSlideWidth}%)`;
        secondPrevTranslate = -secondCurrentIndex * secondSlideWidth * (secondTrack.offsetWidth / 100);
        secondCurrentTranslate = secondPrevTranslate;

        setTimeout(() => {
            if (secondCurrentIndex >= secondSlides.length) {
                secondTrack.style.transition = 'none';
                secondCurrentIndex = 0;
                secondResetSliderPosition();
            } else if (secondCurrentIndex < 0) {
                secondTrack.style.transition = 'none';
                secondCurrentIndex = secondSlides.length - 1;
                secondResetSliderPosition();
            }
            secondIsTransitioning = false;
        }, 500);
    }

    function secondResetSliderPosition() {
        secondTrack.style.transform = `translateX(-${secondCurrentIndex * secondSlideWidth}%)`;
        secondPrevTranslate = -secondCurrentIndex * secondSlideWidth * (secondTrack.offsetWidth / 100);
        secondCurrentTranslate = secondPrevTranslate;
    }

    secondPrevBtn.addEventListener('click', () => secondUpdateCarousel(-1));
    secondNextBtn.addEventListener('click', () => secondUpdateCarousel(1));

    document.addEventListener('dragstart', (e) => e.preventDefault());

}

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', fetchTopSellingProducts);
const track = document.querySelector('.carousel-track');
const slides = document.querySelectorAll('.carousel-slide');
const prevBtn = document.querySelector('.prev');
const nextBtn = document.querySelector('.next');

// Variables para el drag
let isDragging = false;
let startPos = 0;
let currentTranslate = 0;
let prevTranslate = 0;
let animationID = 0;
let currentIndex = 0;
let slideWidth = getSlideWidth(); // Función para obtener el ancho según el viewport
let isTransitioning = false;

// Función para obtener el ancho del slide según el viewport
function getSlideWidth() {
    if (window.innerWidth <= 768) {
        return 100; // Una columna
    } else if (window.innerWidth <= 1024) {
        return 50; // Dos columnas
    } else {
        return 33.333; // Tres columnas
    }
}

// Actualizar slideWidth cuando cambie el tamaño de la ventana
window.addEventListener('resize', () => {
    slideWidth = getSlideWidth();
    // Actualizar la posición del carrusel
    track.style.transition = 'none';
    track.style.transform = `translateX(-${currentIndex * slideWidth}%)`;
    prevTranslate = -currentIndex * slideWidth * (track.offsetWidth / 100);
    currentTranslate = prevTranslate;
});

// Clonar los slides para el efecto infinito
slides.forEach(slide => {
    const clone = slide.cloneNode(true);
    track.appendChild(clone);
});

// Eventos para el drag
track.addEventListener('mousedown', dragStart);
track.addEventListener('touchstart', dragStart);
track.addEventListener('mouseup', dragEnd);
track.addEventListener('touchend', dragEnd);
track.addEventListener('mousemove', drag);
track.addEventListener('touchmove', drag);
track.addEventListener('mouseleave', dragEnd);

function dragStart(event) {
    if (isTransitioning)
        return;

    event.preventDefault();
    if (event.type === 'touchstart') {
        startPos = event.touches[0].clientX;
    } else {
        startPos = event.clientX;
    }

    isDragging = true;
    track.classList.add('dragging');
    animationID = requestAnimationFrame(animation);
}

function drag(event) {
    if (!isDragging)
        return;

    let currentPosition;
    if (event.type === 'touchmove') {
        currentPosition = event.touches[0].clientX;
    } else {
        currentPosition = event.clientX;
    }

    const diff = currentPosition - startPos;
    currentTranslate = prevTranslate + diff;
}

function dragEnd() {
    isDragging = false;
    track.classList.remove('dragging');
    cancelAnimationFrame(animationID);

    const movedBy = currentTranslate - prevTranslate;

    // Determinar si el movimiento fue suficiente para cambiar de slide
    if (Math.abs(movedBy) > 100) {
        if (movedBy < 0) {
            updateCarousel(1);
        } else {
            updateCarousel(-1);
        }
    } else {
        // Volver a la posición original si el movimiento fue pequeño
        updateCarousel(0);
    }
}

function animation() {
    setSliderPosition();
    if (isDragging)
        requestAnimationFrame(animation);
}

function setSliderPosition() {
    track.style.transform = `translateX(${currentTranslate}px)`;
}

function updateCarousel(direction) {
    if (isTransitioning)
        return;
    isTransitioning = true;

    currentIndex += direction;
    track.style.transition = 'transform 0.5s ease-in-out';
    track.style.transform = `translateX(-${currentIndex * slideWidth}%)`;
    prevTranslate = -currentIndex * slideWidth * (track.offsetWidth / 100);
    currentTranslate = prevTranslate;

    setTimeout(() => {
        if (currentIndex >= slides.length) {
            track.style.transition = 'none';
            currentIndex = 0;
            track.style.transform = `translateX(0)`;
            prevTranslate = 0;
            currentTranslate = 0;
        } else if (currentIndex < 0) {
            track.style.transition = 'none';
            currentIndex = slides.length - 1;
            track.style.transform = `translateX(-${currentIndex * slideWidth}%)`;
            prevTranslate = -currentIndex * slideWidth * (track.offsetWidth / 100);
            currentTranslate = prevTranslate;
        }
        isTransitioning = false;
    }, 500);
}

prevBtn.addEventListener('click', () => updateCarousel(-1));
nextBtn.addEventListener('click', () => updateCarousel(1));

// Prevenir el comportamiento predeterminado del arrastre de imágenes
document.addEventListener('dragstart', (e) => e.preventDefault());
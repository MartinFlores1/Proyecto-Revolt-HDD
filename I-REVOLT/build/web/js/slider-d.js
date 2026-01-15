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
    if (secondIsTransitioning) return;
    event.preventDefault();
    secondStartPos = event.type === 'touchstart' ? event.touches[0].clientX : event.clientX;
    secondIsDragging = true;
    secondTrack.classList.add('dragging');
    secondAnimationID = requestAnimationFrame(secondAnimation);
}

function secondDrag(event) {
    if (!secondIsDragging) return;
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
    if (secondIsDragging) requestAnimationFrame(secondAnimation);
}

function secondSetSliderPosition() {
    secondTrack.style.transform = `translateX(${secondCurrentTranslate}px)`;
}

function secondUpdateCarousel(direction) {
    if (secondIsTransitioning) return;
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

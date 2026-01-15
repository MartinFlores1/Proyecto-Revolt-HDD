// Agregar este script al final de tu archivo JS o antes del cierre del body
document.addEventListener('DOMContentLoaded', function() {
    // Manejar el dropdown en móviles
    const dropdownToggle = document.querySelector('.dropdown-toggle');
    if (dropdownToggle) {
        dropdownToggle.addEventListener('click', function(e) {
            if (window.innerWidth < 992) {
                e.preventDefault();
                const dropdownMenu = this.nextElementSibling;
                dropdownMenu.classList.toggle('show');
            }
        });
    }

    // Cerrar el menú móvil al hacer click fuera
    document.addEventListener('click', function(e) {
        const navbar = document.querySelector('.navbar-collapse');
        const toggler = document.querySelector('.navbar-toggler');
        
        if (navbar.classList.contains('show') && 
            !navbar.contains(e.target) && 
            !toggler.contains(e.target)) {
            navbar.classList.remove('show');
        }
    });
});
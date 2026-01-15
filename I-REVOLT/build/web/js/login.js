const container = document.getElementById('container-l');
const registerBtn = document.getElementById('register');
const loginBtn = document.getElementById('login');

registerBtn.addEventListener('click', () => {
    container.classList.add("active");
});

loginBtn.addEventListener('click', () => {
    container.classList.remove("active");
});


function showRequirements() {
    var passwordField = document.getElementById('password');
    var popup = document.getElementById('passwordRequirements');

    // Obtener la posición del campo de contraseña
    var rect = passwordField.getBoundingClientRect();

    // Ajustar la posición del pop-up para que aparezca cerca del campo de contraseña
    popup.style.left = rect.left + 'px';
    popup.style.top = rect.bottom + 'px';

    // Mostrar el pop-up
    popup.style.display = 'block';
}

function hideRequirements() {
    // Ocultar el pop-up
    document.getElementById('passwordRequirements').style.display = 'none';
}

function checkPasswordRequirements() {
    const password = document.getElementById('password').value;

    // Verifica la longitud de la contraseña
    document.getElementById('length').classList.toggle('valid', password.length >= 8);
    document.getElementById('length').classList.toggle('invalid', password.length < 8);

    // Verifica si contiene una letra mayúscula
    document.getElementById('uppercase').classList.toggle('valid', /[A-Z]/.test(password));
    document.getElementById('uppercase').classList.toggle('invalid', !/[A-Z]/.test(password));

    // Verifica si contiene un número
    document.getElementById('number').classList.toggle('valid', /\d/.test(password));
    document.getElementById('number').classList.toggle('invalid', !/\d/.test(password));

    // Verifica si contiene un carácter especial
    document.getElementById('special').classList.toggle('valid', /[!@#$%^&*]/.test(password));
    document.getElementById('special').classList.toggle('invalid', !/[!@#$%^&*]/.test(password));
}

function validarContrasena() {
    // Obtiene el valor de la contraseña ingresada 
    const contrasena = document.getElementById('password').value;

    // Verifica los requerimientos de la contraseña
    const longitudValida = contrasena.length >= 8;
    const mayusculaValida = /[A-Z]/.test(contrasena);
    const numeroValido = /\d/.test(contrasena);
    const especialValido = /[!@#$%^&*]/.test(contrasena);

    // Si la contraseña cumple con todos los requisitos, devuelve true y envia el formulario 
    if (longitudValida && mayusculaValida && numeroValido && especialValido) {
        window.location.href = "../vistas/login.jsp";
        return true;
    } else {
        alert("Por favor, asegúrese de que la contraseña cumpla con todos los requisitos.");
        return false; // Evita el envío del formulario
    }
}
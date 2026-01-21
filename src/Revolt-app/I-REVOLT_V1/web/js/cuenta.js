function toggleEdit() {
    const inputs = document.querySelectorAll('.data-item input');
    const button = document.querySelector('.edit-btn');
    const form = document.getElementById('form-cliente');
    const modal = new bootstrap.Modal(document.getElementById('confirmEditModal'));
    const confirmEditButton = document.getElementById('confirmEditButton');
    const cancelEditButton = document.getElementById('cancelEditButton');

    if (button.textContent === 'Editar') {
        // Habilitar campos para edición
        inputs.forEach(input => input.disabled = false);
        button.textContent = 'Guardar'; // Cambiar texto del botón
    } else {
        // Mostrar el modal de confirmación de edición
        modal.show();

        // Si el usuario hace clic en "Guardar cambios", enviar el formulario
        confirmEditButton.onclick = function () {
            modal.hide(); // Ocultar el modal
            form.submit();  // Enviar el formulario
        }

        // Si el usuario hace clic en "Cancelar", recargar la página
        cancelEditButton.onclick = function () {
            modal.hide(); // Cerrar el modal
            location.reload();  // Recargar la página
        }
    }
}

// Cerrar el modal si el usuario hace clic fuera de él (comportamiento estándar de Bootstrap)
window.onclick = function (event) {
    const modal = document.getElementById('confirmEditModal');
    if (event.target === modal) {
        const bsModal = new bootstrap.Modal(modal);
        bsModal.hide();
    }
}

Entendido, ajustemos el reporte para que coincida exactamente con tu rama **`ianandrade`** y los cambios específicos que realizamos en el archivo del blog.

Aquí tienes la estructura actualizada:

---

# 📸 Evidencias Sprint 1 — Mejora de Blog y Accesibilidad

Este documento registra las mejoras realizadas en el archivo de blog para cumplir con los estándares de calidad y accesibilidad del proyecto.

---

## ✅ Análisis y Planificación de Mejoras en blog.html

Aplicando el flujo de trabajo establecido: `Pull → Branch → Edit → Commit → Push → PR`

### 📋 Información del Trabajo

* **Rama:** `ianandrade`
* **Autor:** Ian Andrade
* **Fecha:** 21/01/2026
* **Archivo analizado:** `src/Revolt-app/I-REVOLT_V1/web/blog.html`
* **Estado:** ✅ Cambios aplicados y validados

### 🔄 Flujo Aplicado

#### 1️⃣ Pull desde main ✅

```bash
git checkout main
git pull origin main

```

#### 2️⃣ Creación de rama feature ✅

```bash
git checkout -b ianandrade

```

#### 3️⃣ Análisis realizado - Mejoras identificadas (7 puntos)

**Commits sugeridos según Conventional Commits:**

##### Commit 1: `fix: cerrar etiqueta </head> y limpiar duplicados`

* Se corrigió el error de validación donde el `<head>` permanecía abierto.
* Se eliminó la doble importación de Font Awesome para mejorar el tiempo de carga.

<img width="1394" height="407" alt="image" src="https://github.com/user-attachments/assets/731d3b3e-4345-48d8-931c-0ba757438352" />


##### Commit 2: `refactor: eliminar espaciados <br> por margin/padding CSS`

* Limpieza de código eliminando saltos de línea manuales innecesarios.
* Uso de clases de espaciado de Bootstrap para consistencia visual.

<img width="1366" height="165" alt="image" src="https://github.com/user-attachments/assets/46075dfa-1a68-4a25-b4ff-c5162f2dd3dc" />

##### Commit 3: `fix: corregir estructura semántica del contenido`

* Refactorización semántica: Se migró el diseño a un sistema de tarjetas (cards) y rejilla (grid) de Bootstrap 5 para mejorar la responsividad y jerarquía visual.

* Optimización de accesibilidad: Se implementaron atributos aria-label en elementos interactivos y redes sociales, garantizando compatibilidad con lectores de pantalla.

<img width="1328" height="797" alt="image" src="https://github.com/user-attachments/assets/904fda11-7ed0-480e-ae14-1645e06cc835" />

##### Commit 4: `feat: agregar aria-label a botón de búsqueda`

*Se añadieron atributos aria-label a los botones de búsqueda y carrito para que los lectores de pantalla identifiquen su función correctamente.
*Se optimizó el botón de registro con ortografía profesional (¡Regístrate!), mejorando la localización y calidad visual de la interfaz.
<img width="1289" height="420" alt="image" src="https://github.com/user-attachments/assets/95d44f6d-7a3c-4adf-8a06-1752f2cf8bf3" />

##### Commit 5: `feat: mejorar accesibilidad en carrito de compras`
* El código se reestructuró en múltiples líneas (saltos de línea) para que los atributos no queden amontonados y sean más fáciles de leer.
* Se agregaron clases de Bootstrap al span (como translate-middle, badge, rounded-pill) para darle estilo de notificación.
<img width="1339" height="174" alt="image" src="https://github.com/user-attachments/assets/a1ab1915-b5ad-45d5-97d1-416c24a33570" />

##### Commit 6: `fix: corregir errores de traducción y typos`

<img width="1297" height="103" alt="image" src="https://github.com/user-attachments/assets/083874f0-2cf5-46d7-b74c-b4f9b2983657" />

* Se tradujeron términos del menú como "Confirmation" a "Confirmación".
* Se corrigieron acentos y puntuación en la sección de misión.

##### Commit 7: `feat: optimizar accesibilidad en redes sociales del autor`

<img width="1288" height="179" alt="image" src="https://github.com/user-attachments/assets/37b24881-b5ed-429a-abc6-4220e73b3e04" />

* Se añadieron labels descriptivos a los iconos de redes sociales en el sidebar para lectores de pantalla.

#### 4️⃣ Stage y Commit

```bash
git add web/blog.html
git commit -m "feat: optimizar accesibilidad y semántica en blog.html

- Corrección de etiquetas de cierre en el head
- Implementación de aria-labels en botones y enlaces
- Reemplazo de etiquetas br por espaciado Bootstrap
- Mejora de jerarquía semántica (main, article, aside)"

```

#### 5️⃣ Push a origin

```bash
git push origin ianandrade

```

### 📊 Impacto de los Cambios

| Categoría | Antes | Después |
| --- | --- | --- |
| **Validación HTML** | ❌ 1 error crítico | ✅ 100% válido |
| **Accesibilidad** | ⚠️ Sin etiquetas ARIA | ✅ +8 aria-labels |
| **Semántica** | ⚠️ Estructura plana | ✅ Jerarquía optimizada |
| **Traducción** | ❌ Spanglish | ✅ 100% Español |

### ✅ Checklist de Calidad

* [x] Código HTML válido (W3C)
* [x] Etiquetas correctamente cerradas
* [x] ARIA labels en elementos interactivos
* [x] Semántica HTML correcta
* [x] Push realizado a la rama `ianandrade`

---

// Animazione di scrittura dinamica
document.addEventListener("DOMContentLoaded", function () {
    const text = "Il Tuo Nome Qui";
    const typingElement = document.querySelector(".typing-animation");
    let index = 0;

    function typeEffect() {
        if (index < text.length) {
            typingElement.textContent += text.charAt(index);
            index++;
            setTimeout(typeEffect, 150);
        }
    }

    typingElement.textContent = ""; // Resetta il contenuto iniziale
    typeEffect();
});

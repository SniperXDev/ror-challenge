// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function () {
    const flashMessages = document.querySelectorAll('.flash-message');

    flashMessages.forEach(function (message) {
        setTimeout(function () {
            message.style.transition = 'opacity 0.5s ease';
            message.style.opacity = 0;

            setTimeout(function () {
                message.remove();
            }, 500);
        }, 3000);
    });
});

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"


document.addEventListener("DOMContentLoaded", () => {
    console.log("JavaScript is loaded and running!");
    const urlParams = new URLSearchParams(window.location.search);
    const showIcsModal = urlParams.get("show_ics_modal");

    const modal = document.getElementById("icsModal");
    const closeBtn = document.getElementById("closeIcsModal");

    if (showIcsModal && modal) {
        modal.style.display = "flex";
    }

    if (closeBtn) {
        closeBtn.addEventListener("click", () => {
        modal.style.display = "none";

        // Remove ?show_ics_modal=true from URL without reloading
        const baseUrl = window.location.href.split("?")[0];
        window.history.replaceState({}, document.title, baseUrl);
        });
    }
});

document.addEventListener("DOMContentLoaded", () => {
    console.log("JavaScript for combined ICS modal is loaded and running!");
    const urlParams = new URLSearchParams(window.location.search);

    // Combined ICS modal
    const showCombined = urlParams.get("show_combined_ics_modal");
    const combinedModal = document.getElementById("combinedIcsModal");
    const closeCombinedBtn = document.getElementById("closeCombinedIcsModal");

    if (showCombined && combinedModal) {
        combinedModal.style.display = "flex";
    }

    if (closeCombinedBtn) {
        closeCombinedBtn.addEventListener("click", () => {
        combinedModal.style.display = "none";

        // Clean the URL
        const baseUrl = window.location.href.split("?")[0];
        window.history.replaceState({}, "", baseUrl);
        });
    }
});

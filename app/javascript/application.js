// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"

const initSingleIcsModal = () => {
  const urlParams = new URLSearchParams(window.location.search)
  const showIcsModal = urlParams.get("show_ics_modal")
  const modal = document.getElementById("icsModal")
  const closeBtn = document.getElementById("closeIcsModal")

  if (showIcsModal && modal) {
    modal.style.display = "flex"
  }

  if (closeBtn) {
    closeBtn.addEventListener("click", () => {
      modal.style.display = "none"
      const baseUrl = window.location.href.split("?")[0]
      window.history.replaceState({}, document.title, baseUrl)
    })
  }
}

const initCombinedIcsModal = () => {
  const urlParams = new URLSearchParams(window.location.search)
  const showCombined = urlParams.get("show_combined_ics_modal")
  const combinedModal = document.getElementById("combinedIcsModal")
  const closeCombinedBtn = document.getElementById("closeCombinedIcsModal")

  if (showCombined && combinedModal) {
    combinedModal.style.display = "flex"
  }

  if (closeCombinedBtn) {
    closeCombinedBtn.addEventListener("click", () => {
      combinedModal.style.display = "none"
      const baseUrl = window.location.href.split("?")[0]
      window.history.replaceState({}, "", baseUrl)
    })
  }
}

const initCharacterCounters = () => {
  const wrappers = document.querySelectorAll("[data-character-count]")

  wrappers.forEach((wrapper) => {
    if (wrapper.dataset.characterCountInitialized === "true") return

    const input = wrapper.querySelector('[data-character-count-role="input"]')
    const counter = wrapper.querySelector('[data-character-count-role="counter"]')

    if (!input || !counter) return

    const maxChars =
      Number(wrapper.dataset.characterCountMax || input.getAttribute("maxlength")) || 0
    if (maxChars === 0) return

    const update = () => {
      counter.textContent = `${input.value.length}/${maxChars} characters`
    }

    input.addEventListener("input", update)
    update()

    wrapper.dataset.characterCountInitialized = "true"
  })
}

const initializeAppScripts = () => {
  initSingleIcsModal()
  initCombinedIcsModal()
  initCharacterCounters()
}

document.addEventListener("DOMContentLoaded", initializeAppScripts)
document.addEventListener("turbo:load", initializeAppScripts)

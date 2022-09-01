import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
    const navbar = document.querySelector('#navbar');
    window.addEventListener("scroll", () =>{
      this.handleNavbarPosition(navbar)
    })

  }
  disconnect() {
    const navbar = document.querySelector('#navbar');
    window.removeEventListener('scroll', () =>{
      this.handleNavbarPosition(navbar)
    })
  }

  handleNavbarPosition(navbar) {
    const windowPosition = window.pageYOffset
    if (windowPosition === 0) {
      navbar.classList.remove('navbar-bg')
    } else {
      navbar.classList.add('navbar-bg')
    }
  }
}

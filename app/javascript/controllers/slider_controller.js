import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["slide"]

  initialize() {
    this.currentIndex = 0;
    this.showCurrentSlide();
  }

  next() {
    this.currentIndex++;
    if (this.currentIndex >= this.slideTargets.length) {
      this.currentIndex = 0;
    }
    this.showCurrentSlide();
  }

  previous() {
    this.currentIndex--;
    if (this.currentIndex < 0) {
      this.currentIndex = this.slideTargets.length - 1;
    }
    this.showCurrentSlide();
  }

  showCurrentSlide() {
    this.slideTargets.forEach((slide, index) => {
      slide.classList.toggle("hidden", index !== this.currentIndex);
    });
  }
}

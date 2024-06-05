import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ['content', 'diary', 'bookmark', 'ward', 'profile']
  connect() {
    this.loadContent(this.diaryTarget.dataset.url)
  }

  loadContent(url) {
    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.contentTarget.innerHTML = html
      })
  }

  showDiary(event) {
    event.preventDefault()
    this.loadContent(this.diaryTarget.dataset.url)
  }

  showBookmarks(event) {
    event.preventDefault()
    this.loadContent(this.bookmarkTarget.dataset.url)
  }

  showWards(event) {
    event.preventDefault()
    this.loadContent(this.wardTarget.dataset.url)
  }

  showProfile(event) {
    event.preventDefault()
    this.loadContent(this.profileTarget.dataset.url)
  }
}

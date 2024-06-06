import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ['content', 'diary', 'bookmark', 'profile']
  connect() {
    this.loadContent(this.profileTarget.dataset.url)
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
    this.setActiveTab(event.currentTarget)
    this.loadContent(this.diaryTarget.dataset.url)
  }

  showBookmarks(event) {
    event.preventDefault()
    this.setActiveTab(event.currentTarget)
    this.loadContent(this.bookmarkTarget.dataset.url)
  }

  showProfile(event) {
    event.preventDefault()
    this.setActiveTab(event.currentTarget)
    this.loadContent(this.profileTarget.dataset.url)
  }

  setActiveTab(tab) {
    this.element.querySelectorAll('.tab').forEach(t => t.classList.remove('tab-active'))
    tab.classList.add('tab-active')
  }
}

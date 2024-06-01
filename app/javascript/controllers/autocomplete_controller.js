import { Autocomplete } from 'stimulus-autocomplete';

export default class extends Autocomplete {
  static targets = ['input', 'hidden', 'results', 'ward', 'parkId'];

  connect() {
    super.connect();
    this.resultsTarget.addEventListener('click', this.handleResultClick.bind(this)); // 公園の予測変換をクリックしたときに発火させる
  }

  handleResultClick(event) {
    const selectedItem = event.target.closest('li[role="option"]'); //クリックした要素に一番近い<li>を取得
    if (selectedItem) {
      this.parkIdTarget.value = selectedItem.dataset.autocompleteValue; // datasetのうちautocompleteValueの要素(park.id)を取得
      this.fetchTokyoWardInfo(this.parkIdTarget.value);
    }
  }

  async fetchTokyoWardInfo(parkId) {
    if (!parkId) {
      console.error('Park ID not found');
      return;
    }
    try {
      const response = await fetch(`/parks/tokyo_ward_info?park_id=${encodeURIComponent(parkId)}`);
      if (!response.ok) {
        throw new Error('Failed to fetch Tokyo ward info');
      }
      const data = await response.json();
      if (data.tokyo_ward_id) {
        this.wardTarget.value = data.tokyo_ward_id;
      }
    } catch (error) {
      console.error(error);
    }
  }
}
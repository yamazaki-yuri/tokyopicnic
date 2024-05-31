import { Autocomplete } from 'stimulus-autocomplete';

export default class extends Autocomplete {
  static targets = ['input', 'hidden', 'results', 'ward', 'parkId'];

  connect() {
    super.connect();
    console.log('Autocomplete connected');
    this.resultsTarget.addEventListener('click', this.handleResultClick.bind(this)); // イベントリスナーの追加
  }

  handleResultClick(event) {
    const selectedItem = event.target.closest('li[role="option"]');
    if (selectedItem) {
      console.log('Result item clicked:', selectedItem);
      this.parkIdTarget.value = selectedItem.dataset.autocompleteValue; // 公園IDをセット
      console.log('Park ID set to:', this.parkIdTarget.value); // デバッグメッセージ
      this.fetchTokyoWardInfo(this.parkIdTarget.value); // 公園IDが設定された後に区情報を取得
    }
  }

  async fetchTokyoWardInfo(parkId) {
    console.log('Fetching Tokyo Ward Info for Park ID:', parkId); // デバッグメッセージ
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
      console.log('Received Tokyo Ward Data:', data); // デバッグメッセージ
      if (data.tokyo_ward_id) {
        this.wardTarget.value = data.tokyo_ward_id;
        console.log('Ward Target Value Set:', this.wardTarget.value); // デバッグメッセージ
      }
    } catch (error) {
      console.error(error);
    }
  }
}
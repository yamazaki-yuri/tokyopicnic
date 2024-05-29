import ApplicationController from "./application_controller";

let map;
let markers = [];
let infoWindows = [];

// Connects to data-controller="google-map--index"
export default class extends ApplicationController {
  //デフォルトの地図の中心地を設定
  static values = {
    location: {
      lat: 35.6855322796429,
      lng: 139.75277781477016
    },
    zoom: 11,
    parks: []
  }
  static targets = ['map']

  connect() {
    this.setParks();
    this.initMapWithUserLocation();
  }

  initMapWithUserLocation() {
    const loader = this.setLoader();
    loader.load().then(async () => {
      const { Map } = await google.maps.importLibrary("maps");

      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            const userLocation = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
            this.createMap(userLocation);  // 現在地を中心に地図を作成
          },
          () => {
            console.warn("Geolocation failed or is not available.");
            this.createMap(this.locationValue);  // 現在地の取得に失敗した場合はデフォルトの中心地
          }
        );
      } else {
        console.warn("Geolocation is not supported by this browser.");
        this.createMap(this.locationValue);  // Geolocationがサポートされていない場合はデフォルトの中心地
      }
    });
  }

  createMap(center) {
    map = new google.maps.Map(this.mapTarget, {
      center: center,
      zoom: this.zoomValue,
    });
    this.addMarkersToMap();
  }

  addMarkersToMap() {
    this.parksValue.forEach((o, i) => {
      this.addMarkerToMarkers(o);
      this.addInfoWindowToInfoWindows(o);
      this.addEventToMarker(i);
    });
  }

  addMarkerToMarkers(o) {
    const marker = new google.maps.Marker({
      position: { lat: o.lat, lng: o.lng },
      map,
      name: o.name
    });
    markers.push(marker);
  }

  addInfoWindowToInfoWindows(o) {
    const infoWindow = new google.maps.InfoWindow({
      content: `
          <p>${o.name}</p><br>
          <a href="/parks/${o.id}" data-turbolinks="true">
            詳細を見る
          </a><br>
          <a href="/park_reports/new" data-turbolinks="true" data-park-name="${o.name}">
            この公園の投稿をする
          </a>
        `
    });
    infoWindows.push(infoWindow);
  }

  addEventToMarker(i) {
    markers[i].addListener('click', () => {
      infoWindows[i].open(map, markers[i]);
    });
  }

  setParks() {
    this.parksValue = JSON.parse(this.mapTarget.dataset.json);
  }
}
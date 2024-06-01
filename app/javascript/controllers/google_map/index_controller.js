import ApplicationController from "./application_controller";

let map;
let markers = [];
let infoWindows = [];

// Connects to data-controller="google-map--index"
export default class extends ApplicationController {
  //地図の初期値(中心地は皇居に設定)
  static values = {
    location: {
      lat: 35.6855322796429,
      lng: 139.75277781477016
    },
    zoom: 11,
    parks: [],
    mapId: "parkmap",
  }
  static targets = ['map', 'user_location']

  //HTMLのmap要素に接続された時に実行
  connect() {
    this.setParks();
    this.initMap();
    this.user_locationTarget.addEventListener('click', this.initMapWithUserLocation.bind(this)); // 修正: イベントリスナーに関数を渡す
  }

  initMap() {
    const loader = this.setLoader();
    loader.importLibrary("marker").then(async () => {
      const { Map } = await google.maps.importLibrary("maps");
      this.createMap(this.locationValue, this.zoomValue);
    });
  }

  initMapWithUserLocation() {
    const loader = this.setLoader();
    loader.importLibrary("marker").then(async () => {
      const { Map } = await google.maps.importLibrary("maps");

      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            const userLocation = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
            this.createMap(userLocation, 13);  // 現在地を中心に地図を作成。地図を初期値より拡大
          },
          () => {
            console.warn("Geolocation failed or is not available.");
            this.createMap(this.locationValue, this.zoomValue);  // 現在地の取得に失敗した場合はデフォルトの中心地
          }
        );
      } else {
        console.warn("Geolocation is not supported by this browser.");
        this.createMap(this.locationValue, this.zoomValue);  // Geolocationがサポートされていない場合はデフォルトの中心地
      }
    });
  }

  createMap(center, zoom) {
    const loader = this.setLoader();
    loader.importLibrary("marker").then(() => {
      map = new google.maps.Map(this.mapTarget, {
        center: center,
        zoom: zoom,
        mapId: this.mapIdValue
      });
      this.addMarkersToMap();
    });
  }

  //公園の情報を基に地図上にマーカーと情報ウィンドウを追加
  addMarkersToMap() {
    markers = [];
    infoWindows = [];
    this.parksValue.forEach((o, i) => {
      this.addMarkerToMarkers(o, i);
    });
  }

  //各公園の位置にマーカーを作成
  addMarkerToMarkers(o, index) {
    const marker = new google.maps.marker.AdvancedMarkerElement({
      position: { lat: o.lat, lng: o.lng },
      map,
      title: o.name
    });
    markers.push(marker);
    this.addInfoWindowToInfoWindows(o, marker);
  }

  //マーカーをクリックした時に表示される情報ウィンドウの内容
  addInfoWindowToInfoWindows(o, marker) {
    const infoWindow = new google.maps.InfoWindow({
      content: `
        <p class="text-park font-bold text-center text-lg">- ${o.name} -</p><br>
        <a href="/parks/${o.id}" data-turbo-frame="false" class="btn me-2 w-full hover:bg-slate-200 rounded-lg px-2 py-1 text-park">
          詳細を見る
        </a><br>
        <br>
        <a href="/park_reports/new?park_name=${encodeURIComponent(o.name)}&tokyo_ward_id=${encodeURIComponent(o.tokyo_ward_id)}" data-turbo-frame="true" class="btn me-2 w-full hover:bg-slate-200 rounded-lg px-2 py-1 text-park">
          この公園の日記を投稿する
        </a><br>
        <br>
      `
    });
    infoWindows.push(infoWindow);
    google.maps.event.addListener(marker, 'click', () => {
      infoWindows.forEach(info => info.close()); // すべての情報ウィンドウを閉じる
      infoWindow.open(map, marker);
    });
  }

  setParks() {
    this.parksValue = JSON.parse(this.mapTarget.dataset.json);
  }
}
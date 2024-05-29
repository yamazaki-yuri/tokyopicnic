import { Controller } from "@hotwired/stimulus"
import { Loader } from "@googlemaps/js-api-loader"

// Connects to data-controller="google-map--application"
export default class extends Controller {
  setLoader() {
    return new Loader({
      apiKey: window.ENV.GOOGLE_API_KEY,
      version: "weekly",
    });
  }
}

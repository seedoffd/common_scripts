provider "google" {
  credentials = "${file("test.json")}"
  project     = "spry-sensor-262821"
  region      = "us-central1"
}

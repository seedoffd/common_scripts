resource "google_project_iam_member" "project" {
  project = "spry-sensor-262821"
  count = "${length(var.roles)}"
  role    = "${var.roles[count.index]}"
  member = "user:rodnaya2303@gmail.com"
  
}






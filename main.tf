


# Example Usage - Life cycle settings for storage bucket objects
#BLOCK     #RESOURCE TYPE        #RESOURCE NAME
resource "google_storage_bucket" "maymadnessmantis-1" {
  name          = "mantismayhem-1"
  storage_class =  "STANDARD"
  location      = "us-central1"
  force_destroy = true
  labels = {
    environment = "theosclassroom"
    "dep" = "tryingnottogetkickedout"
  }
  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }
  
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  
  }

}
resource "google_storage_bucket_object" "photo-1" {
bucket = google_storage_bucket.maymadnessmantis-1.name
name = "mantismayhem"
source = "p1023588.jpg"
}

resource "google_storage_bucket_object" "photo-2" {
name = "mantismayhem2"
source = "index.html"
bucket = google_storage_bucket.maymadnessmantis-1.name
}

resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.maymadnessmantis-1.name
  role = "roles/storage.objectViewer"
  member = "allUsers"
}
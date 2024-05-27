


# Example Usage - Life cycle settings for storage bucket objects
#BLOCK     #RESOURCE TYPE        #RESOURCE NAME
resource "google_storage_bucket" "maymadnessmantis-1a" {
  name          = "mantismayhem-1a"
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
# retention_policy {
#   retention_period = 1
#   # #is_locked = false
# }

}
resource "google_storage_bucket_object" "photo-1" {
bucket = google_storage_bucket.maymadnessmantis-1a.name
name = "mantismayhem.jpg"
source = "p1023588.jpg"
content_type = "image/jpeg"
}

resource "google_storage_bucket_object" "photo-2" {
name = "index.html" #name = "p1023588.jpg" 
source = "index.html"
content_type = "text/html"
bucket = google_storage_bucket.maymadnessmantis-1a.name
# retention {
#   #retention_period = 30
#   #is_locked = false
#   mode = "Unlocked"
#   retain_until_time = "2025-06-01T00:00:00Z"
  
#          }

}

resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.maymadnessmantis-1a.name
  role = "roles/storage.objectViewer"
  member = "allUsers"
}
resource "aws_s3_object" "file_upload" {
  bucket = aws_s3_bucket.kittens.id
  key    = "index.html"
  source = "./statik-website/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "file_upload1" {
  bucket = aws_s3_bucket.kittens.id
  key    = "cat0.jpg"
  source = "./statik-website/cat0.jpg"
}

resource "aws_s3_object" "file_upload2" {
  bucket = aws_s3_bucket.kittens.id
  key    = "cat1.jpg"
  source = "./statik-website/cat1.jpg"
}

resource "aws_s3_object" "file_upload3" {
  bucket = aws_s3_bucket.kittens.id
  key    = "cat2.jpg"
  source = "./statik-website/cat2.jpg"
}



# resource "aws_s3_object" "file_upload" {
#   bucket = aws_s3_bucket.kittens.id
#   key    = "index.html"
#   source = "./index.html"
#   etag = filemd5("./index.html")
# }
# resource "aws_s3_object" "file_upload2" {
#   bucket = aws_s3_bucket.kittens.id
#   key    = "cat0.jpg"
#   source = "./cat0.jpg"
#     etag = filemd5("./cat0.jpg")
# }
# resource "aws_s3_object" "file_upload3" {
#   bucket = aws_s3_bucket.kittens.id
#   key    = "cat1.jpg"
#   source = "./cat1.jpg"
#     etag = filemd5("./cat1.jpg")
# }
# resource "aws_s3_object" "file_upload4" {
#   bucket = aws_s3_bucket.kittens.id
#   key    = "cat2.jpg"
#   source = "./cat2.jpg"
#   etag = filemd5("./cat2.jpg")
# }

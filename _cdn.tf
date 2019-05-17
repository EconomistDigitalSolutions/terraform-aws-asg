resource "aws_s3_bucket" "s3_bucket_logs" {
  count = "${var.use_cloudfront ? 1 : 0}"

  bucket = "cdn-logs-123454321"
  acl    = "private"
}

resource "aws_cloudfront_distribution" "cdn" {
  count = "${var.use_cloudfront ? 1 : 0}"

  aliases = ["${var.domain-name}"]
  enabled = true
  comment = ""

  origin = {
    domain_name = "${aws_lb.alb.dns_name}"
    origin_id   = "${aws_lb.alb.id}"

    custom_origin_config = {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  logging_config = {
    include_cookies = true
    bucket          = "${aws_s3_bucket.s3_bucket_logs.bucket_domain_name}"
    prefix          = "cnd-logs"
  }

  // DEFAULT CACHE BEHAVIOUR 
  //  - this is the last one to be applied 
  //  - this only applies if other did not match
  default_cache_behavior = {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_lb.alb.id}"

    forwarded_values = {
      query_string = true
      headers      = ["*"]

      cookies = {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 900
    max_ttl                = 3600
    viewer_protocol_policy = "redirect-to-https"
  }

  # CACHE WITH PRECEDENCE 0
  ordered_cache_behavior = {
    path_pattern     = "/static/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${aws_lb.alb.id}"

    forwarded_values = {
      query_string = false

      cookies = {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 900
    max_ttl                = 3600
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions = {
    geo_restriction = {
      restriction_type = "none"
    }
  }

  viewer_certificate = {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
    acm_certificate_arn      = "${data.aws_acm_certificate.example.arn}"
  }

  tags = "${local.common_tags}"
}

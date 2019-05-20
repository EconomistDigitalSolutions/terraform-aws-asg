resource "aws_s3_bucket" "s3_bucket_logs" {
  count = "${var.use_cloudfront != "false" ? 1 : 0}"

  bucket = "${var.s3_bucket_for_cloudfront_logs}"
  acl    = "private"
}

resource "aws_cloudfront_distribution" "cdn" {
  count = "${var.use_cloudfront != "false" ? 1 : 0}"

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

  // DEFAULT CACHE BEHAVIOUR 
  //  - this is the last one to be applied 
  //  - this only applies if other did not match
  default_cache_behavior = {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_lb.alb.id}"

    forwarded_values = {
      query_string = true
      headers      = ["Host"]
      cookies = {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = "${var.cfd_default_regular_ttl}"
    max_ttl                = "${var.cfd_default_max_ttl}"
    viewer_protocol_policy = "redirect-to-https"
  }

  # CACHE WITH PRECEDENCE 0
  #   - use for static
  ordered_cache_behavior = {
    path_pattern     = "/static/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${aws_lb.alb.id}"

    forwarded_values = {
      query_string = false
      headers      = ["Host"]
      cookies = {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = "${var.cfd_ordered_regular_ttl}"
    max_ttl                = "${var.cfd_ordered_max_ttl}"
    viewer_protocol_policy = "redirect-to-https"
  }

  # CACHE WITH PRECEDENCE 1
  #   - use for /_next
  ordered_cache_behavior = {
    path_pattern     = "/_next/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${aws_lb.alb.id}"

    forwarded_values = {
      query_string = false
      headers      = ["Host"]
      cookies = {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = "${var.cfd_ordered_regular_ttl}"
    max_ttl                = "${var.cfd_ordered_max_ttl}"
    viewer_protocol_policy = "redirect-to-https"
  }

  # CACHE TO BE REJECTED
  #   - use for /api
  ordered_cache_behavior = {
    path_pattern     = "/api/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${aws_lb.alb.id}"

    forwarded_values = {
      query_string = false
      headers      = ["Host"]
      cookies = {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    viewer_protocol_policy = "redirect-to-https"
  }
}

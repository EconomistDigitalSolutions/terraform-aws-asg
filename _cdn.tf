resource "aws_s3_bucket" "s3_bucket_logs" {
  count = "${var.use_cloudfront != "false" ? 1 : 0}"

  // If the bucket is marked for deletion, and is not empty, this forces it to be deleted
  force_destroy = true

  bucket = "${var.s3_bucket_for_cloudfront_logs}"
  acl    = "private"
}

resource "aws_cloudfront_distribution" "cdn" {
  count = "${var.use_cloudfront != "false" ? 1 : 0}"

  depends_on = ["aws_route53_record.internal-dns"]

  aliases = ["${var.domain-name}", "${local.cdn_hostnames_aliases}"]
  enabled = true

  origin = {
    domain_name = "${aws_route53_record.internal-dns.name}"
    origin_id   = "internal-dns"

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

  tags = "${local.common_tags_cdn}"

  default_cache_behavior = {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["HEAD", "GET", "OPTIONS"]
    target_origin_id = "internal-dns"

    forwarded_values = {
      query_string = true
      headers      = ["Host", "X-Economist-Host", "incap-geo"]

      cookies = {
        forward = "whitelist"
        whitelisted_names = [
          "economist_amp_consent",
          "economist_piano_id",
          "economist_has_visited_app_before",
          "ec_community",
          "login_callback",
          "geo_region"
        ]
      }
    }

    min_ttl                = 0
    default_ttl            = "${var.cfd_default_regular_ttl}"
    max_ttl                = "${var.cfd_default_max_ttl}"
    viewer_protocol_policy = "redirect-to-https"
  }
}

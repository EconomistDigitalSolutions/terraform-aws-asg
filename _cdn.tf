resource "aws_s3_bucket" "s3_bucket_logs" {
<<<<<<< HEAD
<<<<<<< HEAD
  count = "${var.use_cloudfront != "false" ? 1 : 0}"

  bucket = "${var.s3_bucket_for_cloudfront_logs}"
<<<<<<< HEAD
=======
  count = "${var.use_cloudfront ? 1 : 0}"
=======
  count = "${var.use_cloudfront != "false" ? 1 : 0}"
>>>>>>> 1f967ab... fixed boolean type (#14)

  bucket = "cdn-logs-123454321"
>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
>>>>>>> 97733d2... add variable for logs bucket (#16)
  acl    = "private"
}

resource "aws_cloudfront_distribution" "cdn" {
<<<<<<< HEAD
<<<<<<< HEAD
  count = "${var.use_cloudfront != "false" ? 1 : 0}"
=======
  count = "${var.use_cloudfront ? 1 : 0}"
>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
  count = "${var.use_cloudfront != "false" ? 1 : 0}"
>>>>>>> 1f967ab... fixed boolean type (#14)

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

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 8f2156e... Add variable to control Cloudfronts TTL (#17)
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

<<<<<<< HEAD
=======
>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
>>>>>>> 8f2156e... Add variable to control Cloudfronts TTL (#17)
  // DEFAULT CACHE BEHAVIOUR 
  //  - this is the last one to be applied 
  //  - this only applies if other did not match
  default_cache_behavior = {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_lb.alb.id}"

    forwarded_values = {
      query_string = true
<<<<<<< HEAD
<<<<<<< HEAD
      headers      = ["Host"]
=======
      headers      = ["*"]

>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
      headers      = ["Host"]
>>>>>>> 8f2156e... Add variable to control Cloudfronts TTL (#17)
      cookies = {
        forward = "none"
      }
    }

    min_ttl                = 0
<<<<<<< HEAD
<<<<<<< HEAD
    default_ttl            = "${var.cfd_default_regular_ttl}"
    max_ttl                = "${var.cfd_default_max_ttl}"
    viewer_protocol_policy = "redirect-to-https"
  }

  #CACHE WITH PRECEDENCE 0
  #   - use for static
  # ordered_cache_behavior = {
  #   path_pattern     = "/static/*"
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods   = ["GET", "HEAD", "OPTIONS"]
  #   target_origin_id = "${aws_lb.alb.id}"

  #   forwarded_values = {
  #     query_string = false
  #     headers      = ["Host"]
  #     cookies = {
  #       forward = "none"
  #     }
  #   }

  #   min_ttl                = 0
  #   default_ttl            = "${var.cfd_ordered_regular_ttl}"
  #   max_ttl                = "${var.cfd_ordered_max_ttl}"
  #   viewer_protocol_policy = "redirect-to-https"
  # }

  # CACHE WITH PRECEDENCE 1
<<<<<<< HEAD
  #   - use for /_next
  ordered_cache_behavior = {
    path_pattern     = "/_next/*"
=======
    default_ttl            = 900
    max_ttl                = 3600
=======
    default_ttl            = "${var.cfd_default_regular_ttl}"
    max_ttl                = "${var.cfd_default_max_ttl}"
>>>>>>> 8f2156e... Add variable to control Cloudfronts TTL (#17)
    viewer_protocol_policy = "redirect-to-https"
  }

<<<<<<< HEAD
  # CACHE WITH PRECEDENCE 0
<<<<<<< HEAD
  #   - use for static
  ordered_cache_behavior = {
    path_pattern     = "/static/*"
>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${aws_lb.alb.id}"

    forwarded_values = {
      query_string = false
<<<<<<< HEAD
<<<<<<< HEAD
      headers      = ["Host"]
=======

>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
      headers      = ["Host"]
>>>>>>> 8f2156e... Add variable to control Cloudfronts TTL (#17)
      cookies = {
        forward = "none"
      }
    }

    min_ttl                = 0
<<<<<<< HEAD
<<<<<<< HEAD
    default_ttl            = "${var.cfd_ordered_regular_ttl}"
    max_ttl                = "${var.cfd_ordered_max_ttl}"
    viewer_protocol_policy = "redirect-to-https"
  }

  # CACHE TO BE REJECTED
  # #   - use for /api
  # ordered_cache_behavior = {
  #   path_pattern     = "/api/*"
=======
  # #   - use for static
=======
  #CACHE WITH PRECEDENCE 0
  #   - use for static
>>>>>>> 6190ac7... Checkpoint for cloudfront
  # ordered_cache_behavior = {
  #   path_pattern     = "/static/*"
>>>>>>> c311959... Removing /static and /api caches (#18)
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods   = ["GET", "HEAD", "OPTIONS"]
  #   target_origin_id = "${aws_lb.alb.id}"

  #   forwarded_values = {
  #     query_string = false
  #     headers      = ["Host"]
  #     cookies = {
  #       forward = "none"
  #     }
  #   }

  #   min_ttl                = 0
<<<<<<< HEAD
  #   default_ttl            = 0
  #   max_ttl                = 0
  #   viewer_protocol_policy = "redirect-to-https"
  # }
=======
    default_ttl            = 900
    max_ttl                = 3600
=======
    default_ttl            = "${var.cfd_ordered_regular_ttl}"
    max_ttl                = "${var.cfd_ordered_max_ttl}"
>>>>>>> 8f2156e... Add variable to control Cloudfronts TTL (#17)
    viewer_protocol_policy = "redirect-to-https"
  }
=======
  #   default_ttl            = "${var.cfd_ordered_regular_ttl}"
  #   max_ttl                = "${var.cfd_ordered_max_ttl}"
  #   viewer_protocol_policy = "redirect-to-https"
  # }
>>>>>>> c311959... Removing /static and /api caches (#18)

  # CACHE WITH PRECEDENCE 1https://stage.econ-wp.com/the-world-this-week/2018/11/15/kals-cartoon?amp=1
=======
>>>>>>> dc163ab... Checkpoint for cloudfront
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

<<<<<<< HEAD
  tags = "${local.common_tags}"
>>>>>>> 69970ff... Add changes to support Cloudfront distributions (#12)
=======
  # CACHE TO BE REJECTED
<<<<<<< HEAD
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
>>>>>>> 8f2156e... Add variable to control Cloudfronts TTL (#17)
=======
  # #   - use for /api
  # ordered_cache_behavior = {
  #   path_pattern     = "/api/*"
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods   = ["GET", "HEAD", "OPTIONS"]
  #   target_origin_id = "${aws_lb.alb.id}"

  #   forwarded_values = {
  #     query_string = false
  #     headers      = ["Host"]
  #     cookies = {
  #       forward = "none"
  #     }
  #   }

  #   min_ttl                = 0
  #   default_ttl            = 0
  #   max_ttl                = 0
  #   viewer_protocol_policy = "redirect-to-https"
  # }
>>>>>>> c311959... Removing /static and /api caches (#18)
}

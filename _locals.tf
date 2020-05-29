locals {
  cdn_hostnames_aliases = "${split(",", var.environment == "production" ? join(",",var.hostnames_prod) : join(",", var.hostnames_staging))}"
}

locals {
  common_tags = {
    Product          = "${var.product}"
    Project          = "${var.project}"
    EmergencyContact = "${var.emergency-contact}"
    Owner            = "${var.owner}"
    Environment      = "${var.environment}"
    LastUpdate       = "${timestamp()}"
    GitHash          = "${var.git-hash}"
  }
}

locals {
  common_tags_cdn = {
    Product          = "${var.product}"
    Project          = "${var.project}"
    EmergencyContact = "${var.emergency-contact}"
    Owner            = "${var.owner}"
    Environment      = "${var.environment}"
  }
}

locals {
  common_tags_asg = [ ]
}

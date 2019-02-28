locals {
  common_tags = {
    Product           = "${var.product}"
    Project           = "${var.project}"
    EmergencyContact  = "${var.emergency-contact}"
    Owner             = "${var.owner}"
    Environment       = "${var.environment}"
    LastUpdate        = "${timestamp()}"
    GitHash           = "${var.git-hash}"
  }
}


locals {
  common_tags_asg = [
    {
      "key" = "Product",
      "value" = "${var.product}",
      "propagate_at_launch" = true
    },
    {
      "key" = "Project",
      "value" = "${var.project}",
      "propagate_at_launch" = true
    },
    {
      "key" = "EmergencyContact"
      "value" = "${var.emergency-contact}"
      "propagate_at_launch" = true
    },
    {
      "key" = "Owner"
      "value" = "${var.owner}"
      "propagate_at_launch" = true
    },
    {
      "key" = "Environment"
      "value" = "${var.environment}"
      "propagate_at_launch" = true
    },
    {
      "key" = "GitHash"
      "value" = "${var.git-hash}"
      "propagate_at_launch" = true
    },
    {
      "key" = "LastUpdate"
      "value" = "${timestamp()}"
      "propagate_at_launch" = true
    }   
  ]
}

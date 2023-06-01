variable "domain_name" {}

variable "use_website" {
    default = false
}

variable "website_root" {
    default = true
}

variable "website_subdomains" {
    default = ["*"]
}

variable "dmarc_policy" {
    default = "none"
}

variable "dmarc_address" {
    type     = string
    nullable = true
    default  = null
}

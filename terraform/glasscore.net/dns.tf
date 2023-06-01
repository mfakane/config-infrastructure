resource "cloudflare_record" "asm_aceinf" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "asm.aceinf"
  value   = "s223.xrea.com"
  proxied = true
  comment = "ACEINF Aircraft Build Simulator"
}

resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = data.cloudflare_zone.domain.name
  value   = "s223.xrea.com"
  proxied = true
}

resource "cloudflare_record" "log_star" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "A"
  name    = "log.star"
  value   = "192.0.2.1"
  proxied = true
}

resource "cloudflare_record" "nrmk_th123" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "nrmk.th123"
  value   = "s223.xrea.com"
  proxied = true
}

resource "cloudflare_record" "star2" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "star2"
  value   = "s223.xrea.com"
  proxied = true
}

resource "cloudflare_record" "star3" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "star3"
  value   = "s223.xrea.com"
  proxied = true
}

resource "cloudflare_record" "static_th123" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "static.th123"
  value   = "s223.xrea.com"
  proxied = true
}

resource "cloudflare_record" "th123" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "th123"
  value   = "s223.xrea.com"
  proxied = true
}

resource "cloudflare_record" "th123_google_site_verification" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = "th123"
  value   = "google-site-verification=MvFjbNAvBoFzid8ile3NJmGlCzEzhcclR4BNAEnTThU"
}

resource "cloudflare_record" "th135" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "th135"
  value   = "s223.xrea.com"
  proxied = true
}

resource "cloudflare_record" "th135_google_site_verification" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = "th135"
  value   = "google-site-verification=bFff7lk-0a5E3xEtHRY0O7hfYH4FD7DNlp85nDv2yp8"
}

resource "cloudflare_record" "keybase_site_verification" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = data.cloudflare_zone.domain.name
  value   = "keybase-site-verification=3pBz4ykw6BVbS1JmbgjSwVlIp7xI0xN4FtMJIDFcu-A"
  comment = "Keybase Proof"
}

module "fastmail" {
  source             = "../modules/cloudflare_fastmail"
  domain_name        = data.cloudflare_zone.domain.name
  dmarc_address      = "82364ceda9fa47919a6039e8fa8b867d@dmarc-reports.cloudflare.net"
}

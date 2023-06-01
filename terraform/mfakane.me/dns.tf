resource "cloudflare_record" "keybase_site_verification" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = data.cloudflare_zone.domain.name
  value   = "keybase-site-verification=tHDop69oaH7K_tEqsGh9KsQt_yopwlfGIXkjFWYEcHc"
  comment = "Keybase Proof"
}

resource "cloudflare_record" "github_pages" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = "_github-pages-challenge-mfakane"
  value   = "f9a2c86647874e4c71aaff5cd90281"
  comment = "GitHub Pages domain verification"
}

module "fastmail" {
  source             = "../modules/cloudflare_fastmail"
  domain_name        = data.cloudflare_zone.domain.name
  use_website        = true
  dmarc_address      = "e5b34fc1db29473db7dac0e9d4fca654@dmarc-reports.cloudflare.net"
}

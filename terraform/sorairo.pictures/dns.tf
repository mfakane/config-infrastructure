resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = data.cloudflare_zone.domain.name
  value   = "linearstar.pages.dev"
  proxied = true
  comment = "Linearstar"
}

resource "cloudflare_record" "infbuild" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "infbuild"
  value   = "infbuild.pages.dev"
  proxied = true
  comment = "InfBuild"
}

resource "cloudflare_record" "log" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "A"
  name    = "log"
  value   = "66.6.44.4"
  comment = "Tumblr"
}

resource "cloudflare_record" "google_site_verification" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = data.cloudflare_zone.domain.name
  value   = "google-site-verification=MCU5jsnXXZB2fcY1GsGsnn23k20NCB8KEC9LzO-7btg"
  comment = "Google Search Console"
}

resource "cloudflare_record" "keybase_site_verification" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = data.cloudflare_zone.domain.name
  value   = "keybase-site-verification=9mkoQ5mTJnv8RRIVKIPC4-yYJ6WX-7-Wllne_bV_O3c"
  comment = "Keybase Proof"
}

resource "cloudflare_record" "blog" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "NS"
  name    = "blog"
  value   = "dns1.p05.nsone.net"
  comment = "Linearstar Blog"
}

resource "cloudflare_record" "download" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "download"
  value   = "s223.xrea.com"
  proxied = true
  comment = "Linearstar Downloads"
}

resource "cloudflare_record" "aquamarine" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "aquamarine"
  value   = "0cf069e9-0369-4f00-ad9e-acbbbd166f24.cfargotunnel.com"
  proxied = true
  comment = "Aquamarine NAS"
}

resource "cloudflare_record" "github_pages" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = "_github-pages-challenge-mfakane"
  value   = "277ba4af7b44ed647792bb9a8a3a43"
  comment = "GitHub Pages domain verification"
}

module "fastmail" {
  source             = "../modules/cloudflare_fastmail"
  domain_name        = data.cloudflare_zone.domain.name
  dmarc_address      = "130666e3233742f3b2367569aede7ea5@dmarc-reports.cloudflare.net"
}

# Allows you to receive email at standard addresses, e.g. user@example.com
resource "cloudflare_record" "mx_root10" {
  zone_id  = data.cloudflare_zone.domain.id
  type     = "MX"
  name     = var.domain_name
  value    = "in1-smtp.messagingengine.com"
  priority = 10
}

resource "cloudflare_record" "mx_root20" {
  zone_id  = data.cloudflare_zone.domain.id
  type     = "MX"
  name     = var.domain_name
  value    = "in2-smtp.messagingengine.com"
  priority = 20
}

# Allows you to receive email at subdomain addresses, e.g. foo@user.example.com
resource "cloudflare_record" "mx_wildcard10" {
  zone_id  = data.cloudflare_zone.domain.id
  type     = "MX"
  name     = "*"
  value    = "in1-smtp.messagingengine.com"
  priority = 10
}

resource "cloudflare_record" "mx_wildcard20" {
  zone_id  = data.cloudflare_zone.domain.id
  type     = "MX"
  name     = "*"
  value    = "in2-smtp.messagingengine.com"
  priority = 20
}

# Allows us to sign the mail you send so receivers can verify it's from you.
# This is important to ensure your message is not classified as spam.
resource "cloudflare_record" "mail_domain_key0" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "mesmtp._domainkey.${var.domain_name}"
  value   = "mesmtp.${var.domain_name}.dkim.fmhosted.com"
  comment = "DKIM"
}

resource "cloudflare_record" "mail_domain_key1" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "fm1._domainkey.${var.domain_name}"
  value   = "fm1.${var.domain_name}.dkim.fmhosted.com"
  comment = "DKIM"
}

resource "cloudflare_record" "mail_domain_key2" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "fm2._domainkey.${var.domain_name}"
  value   = "fm2.${var.domain_name}.dkim.fmhosted.com"
  comment = "DKIM"
}

resource "cloudflare_record" "mail_domain_key3" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = "fm3._domainkey.${var.domain_name}"
  value   = "fm3.${var.domain_name}.dkim.fmhosted.com"
  comment = "DKIM"
}

# Allows receivers to know you send your mail via Fastmail, and other servers.
resource "cloudflare_record" "spf" {
  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = var.domain_name
  value   = "v=spf1 include:spf.messagingengine.com ?all"
  comment = "SPF"
}

# Add DMARC policy for monitoring spams.
resource "cloudflare_record" "dmarc" {
  count   = var.dmarc_address != null ? 1 : 0

  zone_id = data.cloudflare_zone.domain.id
  type    = "TXT"
  name    = "_dmarc"
  value   = "v=DMARC1; p=${var.dmarc_policy}; rua=mailto:${var.dmarc_address}"
}

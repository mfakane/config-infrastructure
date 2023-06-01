# Allows you to host websites at http://example.com/ from your Fastmail file storage
resource "cloudflare_record" "website_root" {
  count   = var.use_website && var.website_root ? 1 : 0

  zone_id = data.cloudflare_zone.domain.id
  type    = "CNAME"
  name    = var.domain_name
  value   = "web.messagingengine.com"
  proxied = true
  comment = "Fastmail Website"
}

# Allows you to host websites at subdomains, including http://www.example.com, from your Fastmail file storage.
resource "cloudflare_record" "website_subdomain" {
  for_each = toset(var.use_website ? var.website_subdomains : [])

  zone_id  = data.cloudflare_zone.domain.id
  type     = "CNAME"
  name     = each.value
  value    = "web.messagingengine.com"
  proxied = true
  comment  = "Fastmail Website"
}

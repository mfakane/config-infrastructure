resource "betteruptime_monitor" "root" {
    url             = "https://${cloudflare_record.root.hostname}"
    monitor_type    = "status"
    check_frequency = 600
    request_timeout = 60
}

resource "betteruptime_monitor" "infbuild" {
    url             = "https://${cloudflare_record.infbuild.hostname}"
    monitor_type    = "status"
    check_frequency = 600
    request_timeout = 60
}

resource "betteruptime_monitor" "download" {
    url             = "https://${cloudflare_record.download.hostname}"
    monitor_type    = "status"
    check_frequency = 1800
    request_timeout = 60
}

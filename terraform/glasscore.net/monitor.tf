resource "betteruptime_monitor" "th123" {
    url              = "https://${cloudflare_record.th123.hostname}"
    monitor_type     = "keyword"
    required_keyword = "編集は誰でもできますので"
    check_frequency  = 1800
    request_timeout  = 60
}

resource "betteruptime_monitor" "th135" {
    url              = "https://${cloudflare_record.th135.hostname}"
    monitor_type     = "keyword"
    required_keyword = "編集は誰でもできますので"
    check_frequency  = 1800
    request_timeout  = 60
}

resource "cloudflare_pages_project" "linearstar" {
    account_id        = var.cloudflare_account_id
    name              = "linearstar"
    production_branch = "master"

    build_config {
        build_command   = "npm run build"
        destination_dir = "dist"
    }

    source {
        type = "github"

        config {
            owner             = "mfakane"
            repo_name         = "sorairo.pictures"
            production_branch = "master"
        }
    }
}

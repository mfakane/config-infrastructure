#!/bin/bash

export TERRAFORM_VERSION=${1:-"latest"}
USERNAME=${2:-"automatic"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Determine the appropriate non-root user
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in ${POSSIBLE_USERS[@]}; do
        if id -u ${CURRENT_USER} > /dev/null 2>&1; then
            USERNAME=${CURRENT_USER}
            break
        fi
    done
    if [ "${USERNAME}" = "" ]; then
        USERNAME=root
    fi
elif [ "${USERNAME}" = "none" ] || ! id -u ${USERNAME} > /dev/null 2>&1; then
    USERNAME=root
fi

# Function to run apt-get if needed
apt-get-update-if-needed()
{
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update
    else
        echo "Skipping apt-get update."
    fi
}

if [ "${TERRAFORM_VERSION}" = "latest" ]; then
    export TERRAFORM_VERSION=
fi

# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

# Install apt-transport-https, curl, gpg if missing
if ! dpkg -s apt-transport-https curl ca-certificates > /dev/null 2>&1 || ! type gpg > /dev/null 2>&1; then
    apt-get-update-if-needed
    apt-get -y install --no-install-recommends apt-transport-https curl ca-certificates gnupg2 
fi

# Install Terraform if not already installed
if type terraform > /dev/null 2>&1; then
    echo "Terraform already installed."
else
    # Source /etc/os-release to get OS info
    . /etc/os-release
    # Import key safely (new 'signed-by' method rather than deprecated apt-key approach) and install
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/terraform-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/terraform-archive-keyring.gpg] https://apt.releases.hashicorp.com/ ${VERSION_CODENAME} main" > /etc/apt/sources.list.d/terraform.list
    apt-get update
    if [ "${TERRAFORM_VERSION}" != "" ]; then
        apt-get -y install --no-install-recommends terraform=${TERRAFORM_VERSION}
    else
        apt-get -y install --no-install-recommends terraform
    fi
fi

echo "Done!"

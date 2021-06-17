ARG VARIANT=buster-slim
FROM debian:${VARIANT}

# Copy base scripts to execute
COPY base-scripts/ /tmp/library-scripts/

# Copy library scripts to execute
COPY library-scripts/ /tmp/library-scripts/

# [Option] Install zsh
ARG INSTALL_ZSH="true"

# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="true"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    # Remove imagemagick due to https://security-tracker.debian.org/tracker/CVE-2019-10131
    && apt-get purge -y imagemagick imagemagick-6-common \
    # Install common packages, non-root user
    && bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install BorgBackup
ARG INSTALL_BORG="true"
ARG BORG_VERSION="1.1.16"
RUN if [ "$INSTALL_BORG" = "true" ]; then bash /tmp/library-scripts/borg-debian.sh "${BORG_VERSION}" "${USERNAME}"; fi

# Remove library scripts for final image
RUN rm -rf /tmp/library-scripts

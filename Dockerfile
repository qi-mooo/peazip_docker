# Use jlesage/docker-baseimage-gui as a parent image
FROM jlesage/baseimage-gui:ubuntu-20.04

# Install necessary tools and fonts
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xfce4-clipman \
    xclip \
    p7zip \
    wget \
    fonts-noto-cjk \
    --no-install-recommends && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# Download and install PeaZip
RUN wget https://github.com/peazip/PeaZip/releases/download/9.5.0/peazip_9.5.0.LINUX.GTK2-1_amd64.deb -P /tmp && \
    dpkg -i /tmp/peazip_9.5.0.LINUX.GTK2-1_amd64.deb && \
    rm /tmp/peazip_9.5.0.LINUX.GTK2-1_amd64.deb

# Update CA certificates
RUN update-ca-certificates

# Set the working directory
WORKDIR /app

# Set environment variables
ENV APP_NAME="PeaZip" \
    DISPLAY_WIDTH="1280" \
    DISPLAY_HEIGHT="1024"

# Copy the start script
COPY startapp.sh /startapp.sh

# Set the name of the application
ENV APP_NAME PeaZip

# Expose VNC and noVNC ports
EXPOSE 5800 5900 3000

# Set working directory
WORKDIR $HOME

# Start VNC server, Xfce4 and noVNC
CMD ["/init"]

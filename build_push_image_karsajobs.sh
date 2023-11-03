#!/usr/bin/env sh
# HOW TO RUN : . ./build_push_image_karsajobs.sh
# Membuat docker image dengan nama <username-docker>/karsajobs dan tag latest
docker build -t viencent/karsajobs:latest .

# Mengubah nama image sesuai dengan format GitHub Packages
docker tag viencent/karsajobs:latest ghcr.io/viencent27/karsajobs:latest

# Login ke GitHub Packages
echo $TOKEN_GITHUB_PACKAGES | docker login ghcr.io --username viencent27 --password-stdin

# Upload image ke GitHub Packages
docker push ghcr.io/viencent27/karsajobs:latest
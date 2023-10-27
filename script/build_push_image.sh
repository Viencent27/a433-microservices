#!/usr/bin/env sh
# HOW TO RUN : . ./script/build_push_image.sh
# Membuat docker image dengan nama item-app dan tag v1
docker build -t item-app:v1 .

# Melihat daftar image
docker images

# Input username GitHub
echo -n "\nMasukkan username GitHub Anda: "
read username

# Cek apakah token sudah tersimpan ke environment variable atau belum
if [ -n $TOKEN_GITHUB_PACKAGES ]
# Jika sudah apakah ingin memperbarui token atau tidak
then
  echo -n "\nGitHub token sudah ada, apakah Anda ingin memasukkan token baru?[y/n] "
  read pilihan
  if [[ $pilihan == "y" ]] || [[ $pilihan == "Y" ]]
  # Jika ingin memperbarui GitHub Token
  then
    echo -n "\nMasukkan token baru Anda: "
    read new_token
    export TOKEN_GITHUB_PACKAGES=$new_token
    echo "\nToken berhasil diperbarui!"
  fi
# Jika belum maka masukkan GitHub Token
else
  echo "\nBuat personal access token dengan cakupan/scope write:packages"
  echo -n "Masukkan personal access token Anda: "
  read token

  # Membuat environment variable untuk token GitHub Packages
  export TOKEN_GITHUB_PACKAGES=$token
fi

# Mengubah nama image sesuai dengan format GitHub Packages
docker tag item-app:v1 ghcr.io/$username/item-app:v1

# Login ke GitHub Packages
echo $TOKEN_GITHUB_PACKAGES | docker login ghcr.io --username $username --password-stdin

# Upload image ke GitHub Packages
docker push ghcr.io/$username/item-app:v1
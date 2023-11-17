# Mengunduh base image node dari Docker Hub dengan tag 18-alpine
FROM node:18-alpine as base
# Menetapkan working directory untuk container
WORKDIR /src
# Menyalin berkas package.json dan package-lock.json ke workdir
COPY package*.json ./

# Mendefinisikan production stage
FROM base as production
# Membuat aplikasi berjalan di production mode
ENV NODE_ENV=production
# Menginstal dependencies yang diperlukan
RUN npm ci
# Menyalin berkas index.js dan .env di local working directory ke container working directory
COPY index.js .env ./
# Menjalankan order service ketika container bekerja
CMD [ "npm", "start" ]

# Mendefinisikan development stage
FROM base as dev
# Menginstall bash
RUN apk add --no-cache bash
# Mengunduh berkas shell script bernama wait-for-it.sh
RUN wget -O /bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
# Mengubah hak aksesnya agar bisa di eksekusi
RUN chmod +x /bin/wait-for-it.sh
# Membuat aplikasi berjalan di development mode
ENV NODE_ENV=development
# Menginstal semua dependencies
RUN npm install
# Menyalin berkas index.js dan .env di local working directory ke container working directory
COPY index.js .env ./
# Menjalankan order service ketika container bekerja
CMD [ "npm", "dev" ]
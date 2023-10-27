# Mengunduh base image node dari Docker Hub dengan tag 14-alpine
FROM node:14-alpine

# Membuat working directory baru di dalam container
WORKDIR /app

# Menyalin semua berkas di local working directory ke container working directory
COPY . .

# Membuat aplikasi berjalan di production mode dan menggunakan container item-db sebagai database host
ENV NODE_ENV=production DB_HOST=item-db

# Menginstal dependencies untuk production dan mem-build aplikasi
RUN npm install --production --unsafe-perm && npm run build

# Mengekspos port pada container
EXPOSE 8080

# Menjalankan server setelah container diluncurkan
CMD [ "npm", "start" ]
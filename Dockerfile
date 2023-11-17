# Mengunduh base image node dari Docker Hub dengan tag 18-alpine
FROM node:18-alpine
# Menetapkan working directory untuk container
WORKDIR /app
# Menyalin package.json dan package-lock.json untuk instalasi dependensi
COPY package*.json ./
# Membuat aplikasi berjalan di production mode
ENV NODE_ENV=production
# Menginstal dependencies untuk production
RUN npm install
# Menyalin semua berkas di local working directory ke container working directory
COPY . .
# Mengekspos port pada container
EXPOSE 3001
# Menjalankan order service ketika container bekerja
CMD [ "npm", "start" ]
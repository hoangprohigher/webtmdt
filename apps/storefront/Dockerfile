# Sử dụng image bun chính thức, đã có sẵn mọi công cụ
FROM oven/bun:1.0

# Đặt thư mục làm việc
WORKDIR /app

# Copy các file định nghĩa dependencies
COPY package.json bun.lockb ./

# Cài đặt tất cả dependencies (bao gồm cả devDependencies để có prisma)
RUN bun install --frozen-lockfile

# Copy toàn bộ mã nguồn còn lại
COPY . .

# Mở cổng 3000
EXPOSE 3000

# Lệnh khởi động sẽ được định nghĩa trong docker-compose.yml




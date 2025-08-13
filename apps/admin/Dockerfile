# --- Giai đoạn 1: Build ---
# Sử dụng image bun chính thức để có sẵn mọi công cụ
FROM oven/bun:1.0 AS builder
WORKDIR /app

# Chỉ copy những file cần thiết để cài đặt dependencies trước
# Điều này tận dụng Docker cache, giúp build nhanh hơn ở những lần sau
COPY package.json bun.lockb ./

# Cài đặt dependencies
RUN bun install --frozen-lockfile

# Copy toàn bộ mã nguồn còn lại
COPY . .

# Chạy prisma generate với một DATABASE_URL giả
# Đây là bước quan trọng để khắc phục lỗi build
RUN DATABASE_URL="postgresql://dummy:dummy@dummy/dummy" bun prisma generate

# Build ứng dụng
RUN bun run build


# --- Giai đoạn 2: Run ---
# Sử dụng image slim để image cuối cùng nhẹ nhất
FROM oven/bun:1.0-slim AS runner
WORKDIR /app

# Chỉ định môi trường là production
ENV NODE_ENV=production

# Copy các file đã được build từ giai đoạn 1
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/bun.lockb ./bun.lockb

# Cài đặt chỉ production dependencies
RUN bun install --frozen-lockfile --production

# Mở cổng 3000
EXPOSE 3000

# Lệnh để khởi chạy ứng dụng
CMD ["bun", "run", "start"]



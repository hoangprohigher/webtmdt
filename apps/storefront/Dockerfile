# Stage 1: Build the application using the official Bun image
FROM oven/bun:1.0 AS builder
WORKDIR /app

# Copy dependency definition files
COPY package.json bun.lockb ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Generate Prisma client
RUN bun prisma generate

# Build the Next.js application
RUN bun run build

# Stage 2: Create a lean production image
FROM oven/bun:1.0-slim AS runner
WORKDIR /app

# Set environment variables
ENV NODE_ENV=production

# Copy production dependencies from the build stage
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# Copy built application from the builder stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/prisma ./prisma

# Expose the port the app runs on
EXPOSE 3000

# Start the Next.js application
CMD ["bun", "run", "start"]


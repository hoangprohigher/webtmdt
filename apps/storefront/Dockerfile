# Stage 1: Base image with bun
FROM oven/bun:1.0 AS base
WORKDIR /app

# Copy root package.json and lockfile
COPY package.json bun.lockb ./

# Install all dependencies
RUN bun install --frozen-lockfile

# Copy the rest of the monorepo
COPY . .

# Copy the entrypoint script and make it executable
COPY ./apps/storefront/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["entrypoint.sh"]

# Expose the port Next.js runs on
EXPOSE 3000




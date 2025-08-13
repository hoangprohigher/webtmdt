#!/bin/sh
set -e

# Navigate to the correct directory where the app is located
cd /app/apps/storefront

echo "Running Prisma generate..."
bunx prisma generate

echo "Running Prisma db push..."
bunx prisma db push

echo "Building the application..."
bun run build

echo "Starting the application..."
exec bun run start

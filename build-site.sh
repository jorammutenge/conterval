#!/bin/bash

set -e  # Exit immediately if any command fails
echo "=== Starting full build ==="

# -----------------------------
# Step 1: Build main website
# -----------------------------
echo "=== Building main website ==="
quarto render .

# -----------------------------
# Step 2: Build Polars book
# -----------------------------
echo "=== Building Polars book ==="
cd polars-book

# Render the book into the default _book/ folder
quarto render .

# Go back to repo root
cd ..

# -----------------------------
# Step 3: Copy compiled book to website folder
# -----------------------------
echo "=== Copying Polars book into docs/polars-book ==="

# Create target directory
mkdir -p docs/polars-book

# Remove old files first to avoid stale content
rm -rf docs/polars-book/*

# Copy everything from _book into docs/polars-book
cp -r polars-book/_book/* docs/polars-book/

echo "=== Build complete ==="

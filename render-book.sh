#!/bin/bash
cd polars-book
quarto render
cd ..
mkdir -p docs/polars-book
cp -r polars-book/_book/* docs/polars-book/
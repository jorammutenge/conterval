"""Resolve the {{< var author >}} shortcode in the RSS feed, which Quarto leaves as raw text.

Uses only the standard library so it runs under any Python that Quarto picks.
"""
import os
import re
from pathlib import Path

output_dir = os.environ.get("QUARTO_PROJECT_OUTPUT_DIR", "docs")
feed = Path(output_dir) / "blog" / "index.xml"
if feed.exists():
    variables = Path("_variables.yml").read_text()
    author = re.search(r'^author:\s*["\']?(.*?)["\']?\s*$', variables, re.M).group(1)
    feed.write_text(feed.read_text().replace("{{&lt; var author &gt;}}", author))

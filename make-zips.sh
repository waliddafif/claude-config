#!/bin/bash
# Generate Claude.ai-compatible zip files from skills/
# Usage: ./make-zips.sh [output-dir]
# Default output: ~/Downloads/claude-skills/

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"
OUTPUT_DIR="${1:-$HOME/Downloads/claude-skills}"

mkdir -p "$OUTPUT_DIR"

echo "Generating skill zips..."
echo "  Skills dir: $SKILLS_DIR"
echo "  Output dir: $OUTPUT_DIR"
echo ""

for skill_dir in "$SKILLS_DIR"/*/; do
  name=$(basename "$skill_dir")
  output_zip="$OUTPUT_DIR/${name}.zip"

  rm -f "$output_zip"
  (cd "$skill_dir" && zip -r "$output_zip" . -x "*.DS_Store")

  echo "  ✓ ${name}.zip"
done

echo ""
echo "✅ Done — $(ls "$OUTPUT_DIR"/*.zip 2>/dev/null | wc -l) zips in $OUTPUT_DIR"

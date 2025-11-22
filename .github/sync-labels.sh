#!/bin/bash
# Sync labels from labels.yml to GitHub repository
# Usage: .github/sync-labels.sh

set -e

LABELS_FILE=".github/labels.yml"

if [ ! -f "$LABELS_FILE" ]; then
    echo "Error: $LABELS_FILE not found"
    exit 1
fi

echo "Syncing labels from $LABELS_FILE to GitHub..."

# Parse YAML and create/update labels
# This requires yq (brew install yq) or we use a simpler approach

# For now, provide instructions
echo ""
echo "To sync labels, you have two options:"
echo ""
echo "Option 1: Use a label sync action (recommended)"
echo "  Add this workflow to .github/workflows/sync-labels.yml"
echo ""
echo "Option 2: Manually create labels using gh CLI"
echo "  Parse .github/labels.yml and run:"
echo "  gh label create \"name\" --color \"color\" --description \"desc\""
echo ""
echo "Current labels in labels.yml: $(grep -c '^- name:' $LABELS_FILE)"
echo ""

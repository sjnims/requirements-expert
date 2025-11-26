#!/bin/bash
# =============================================================================
# DEPRECATED: This script is kept for reference only.
#
# Labels are now synced automatically via GitHub Actions workflow:
#   .github/workflows/sync-labels.yml
#
# The workflow:
#   - Runs automatically when labels.yml is modified and merged to main
#   - Previews changes in dry-run mode on pull requests
#   - Can be triggered manually via GitHub Actions UI
#
# See .github/LABELS.md for full documentation.
# =============================================================================

set -e

LABELS_FILE=".github/labels.yml"

if [ ! -f "$LABELS_FILE" ]; then
    echo "Error: $LABELS_FILE not found"
    exit 1
fi

echo "==============================================="
echo "NOTE: Labels are now synced automatically!"
echo "See: .github/workflows/sync-labels.yml"
echo "==============================================="
echo ""
echo "For manual operations, use gh CLI:"
echo ""
echo "  Create:  gh label create \"name\" --color \"color\" --description \"desc\""
echo "  Update:  gh label edit \"name\" --color \"color\" --description \"desc\""
echo "  Delete:  gh label delete \"name\" --yes"
echo ""
echo "Current labels in labels.yml: $(grep -c '^- name:' "$LABELS_FILE")"
echo ""

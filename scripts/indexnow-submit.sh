#!/usr/bin/env bash
# Submits all sitemap URLs to IndexNow (notifies Bing, and via Bing, Bing Copilot/Yahoo/DuckDuckGo)
# so changes don't have to wait for the next crawl.
#
# Usage: ./scripts/indexnow-submit.sh
set -euo pipefail

HOST="motivez.app"
KEY="ea1ff9def93743ef863ae2774fc53e6c"
KEY_LOCATION="https://${HOST}/${KEY}.txt"

urls=(
  "https://${HOST}/"
  "https://${HOST}/about.html"
  "https://${HOST}/privacy"
  "https://${HOST}/terms"
  "https://${HOST}/guides/"
  "https://${HOST}/guides/best-free-things-to-do-toronto-this-weekend.html"
  "https://${HOST}/guides/free-museum-nights-toronto-rom-ago.html"
  "https://${HOST}/guides/how-university-students-plan-hangouts-gta.html"
  "https://${HOST}/guides/budget-hangout-spots-near-toronto-campuses.html"
  "https://${HOST}/guides/spontaneous-things-to-do-toronto.html"
  "https://${HOST}/guides/cheap-date-ideas-toronto-students.html"
  "https://${HOST}/guides/rainy-day-things-to-do-toronto.html"
  "https://${HOST}/guides/things-to-do-toronto-night-not-clubbing.html"
  "https://${HOST}/guides/new-to-toronto-student-guide.html"
)

url_list=$(printf '"%s",' "${urls[@]}")
url_list="[${url_list%,}]"

curl -s -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"host\":\"${HOST}\",\"key\":\"${KEY}\",\"keyLocation\":\"${KEY_LOCATION}\",\"urlList\":${url_list}}"

echo "Submitted ${#urls[@]} URLs to IndexNow."

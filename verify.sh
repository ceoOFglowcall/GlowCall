#!/usr/bin/env zsh

set -euo pipefail

PROJECT="GlowCall.xcodeproj"
SCHEME="GlowCall"
BUILD_DESTINATION="generic/platform=iOS"

echo "==> Building ${SCHEME}"
xcodebuild -project "${PROJECT}" -scheme "${SCHEME}" -destination "${BUILD_DESTINATION}" build

echo "==> Checking for test targets"
if xcodebuild -list -project "${PROJECT}" | rg -q "Tests"; then
  echo "==> Looking for an available simulator destination"
  DESTINATIONS="$(xcodebuild -showdestinations -project "${PROJECT}" -scheme "${SCHEME}")"
  SIM_NAME="$(printf "%s" "${DESTINATIONS}" | rg -o 'name:[^,}]+' | rg -v "Any iOS Simulator Device|My Mac|Any iOS Device" | head -n 1 | sed 's/name://')"

  if [[ -n "${SIM_NAME}" ]]; then
    echo "==> Running tests on simulator: ${SIM_NAME}"
    xcodebuild -project "${PROJECT}" -scheme "${SCHEME}" -destination "platform=iOS Simulator,name=${SIM_NAME}" test
  else
    echo "==> No concrete simulator found, skipping automated tests"
  fi
else
  echo "==> No test target found, skipping automated tests"
fi

echo "==> Verification complete"

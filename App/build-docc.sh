#!/bin/sh

## Based on turirial from:
## https://www.kodeco.com/40047657-docc-tutorial-for-swift-automating-publishing-with-github-actions

# App Scheme
xcrun xcodebuild docbuild \
    -project "$PWD/App/AlleSeller/AlleSeller.xcodeproj" \
    -scheme AlleSeller \
    -destination 'generic/platform=iOS Simulator' \
    -derivedDataPath "$PWD/.derivedData/alleseller"

xcrun docc process-archive transform-for-static-hosting \
    "$PWD/.derivedData/Build/Products/Debug-iphonesimulator/AlleSeller.doccarchive" \
    --output-path ".docs" \
    --hosting-base-path "seller"

# Fixes index file
echo "👨🏻‍🔧 Fixing index file..."
pwd
ls -la
echo '<script>window.location.href += "/documentation/alleseller"</script>' > .derivedData/.docs/index.html








# Selleer Package
# xcrun xcodebuild docbuild \
#     -project ../Seller/Package.swift \
#     -scheme Seller \
#     -destination 'generic/platform=iOS Simulator' \
#     -derivedDataPath "$PWD/.derivedData"

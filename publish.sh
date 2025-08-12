#!/bin/bash

# Script to publish github packages for Media3 fork libraries

set -e  # Exit on any error

# Configuration
GITHUB_REPO="fsa-streamotion/media"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}


# Function to set module-specific properties and publish
publish_library_if_needed() {
    local gradle_module=$1  # e.g., "lib-exoplayer"

    print_status "Publishing module: $gradle_module"

    # Check if module exists by trying to find its directory
    if ! ./gradlew :${gradle_module}:tasks &>/dev/null; then
        print_warning "Module $gradle_module not found or not configured, skipping..."
        return 0
    fi

    # Run gradle publish for this module
    if ./gradlew --no-daemon :${gradle_module}:publishReleasePublicationToGitHubPackagesRepository; then
        print_status "✅ Successfully published $gradle_module"
        return 0
    else
        print_error "❌ Failed to publish $gradle_module"
        return 1
    fi
}

# Main execution starts here
print_status "Building all modules first..."

# Build all modules
./gradlew --no-daemon clean \
    :lib-exoplayer:assembleRelease \
    :lib-common:assembleRelease \
    :lib-exoplayer-dash:assembleRelease \
    :lib-exoplayer-hls:assembleRelease \
    :lib-exoplayer-ima:assembleRelease \
    :lib-exoplayer-smoothstreaming:assembleRelease \
    :lib-ui:assembleRelease \
    :lib-cast:assembleRelease \
    :lib-datasource:assembleRelease \
    :lib-datasource-okhttp:assembleRelease \
    :lib-session:assembleRelease \
    :lib-extractor:assembleRelease \
    :lib-transformer:assembleRelease \
    :lib-decoder:assembleRelease \
    :lib-database:assembleRelease \
    :lib-container:assembleRelease \
    || exit 1

print_status "All modules built successfully. Starting publishing..."

# Track failed modules
failed_modules=()

# Publish each module
publish_library_if_needed "lib-exoplayer" || failed_modules+=("lib-exoplayer")
publish_library_if_needed "lib-common" || failed_modules+=("lib-common")
publish_library_if_needed "lib-exoplayer-dash" || failed_modules+=("lib-exoplayer-dash")
publish_library_if_needed "lib-exoplayer-hls" || failed_modules+=("lib-exoplayer-hls")
publish_library_if_needed "lib-exoplayer-smoothstreaming" || failed_modules+=("lib-exoplayer-smoothstreaming")
publish_library_if_needed "lib-exoplayer-ima" || failed_modules+=("lib-exoplayer-ima")
publish_library_if_needed "lib-ui" || failed_modules+=("lib-ui")
publish_library_if_needed "lib-cast" || failed_modules+=("lib-cast")
publish_library_if_needed "lib-datasource" || failed_modules+=("lib-datasource")
publish_library_if_needed "lib-datasource-okhttp" || failed_modules+=("lib-datasource-okhttp")
publish_library_if_needed "lib-database" || failed_modules+=("lib-database")
publish_library_if_needed "lib-decoder" || failed_modules+=("lib-decoder")
publish_library_if_needed "lib-container" || failed_modules+=("lib-container")
publish_library_if_needed "lib-extractor" || failed_modules+=("lib-extractor")

# Summary
echo
print_status "Publishing Summary:"
print_status "Total modules: 14"
print_status "Failed modules: ${#failed_modules[@]}"

if [[ ${#failed_modules[@]} -gt 0 ]]; then
    print_error "Failed modules:"
    for module in "${failed_modules[@]}"; do
        print_error "  - $module"
    done
    exit 1
else
    print_status "🎉 All modules published successfully to GitHub Packages!"
    print_status "Repository: https://github.com/$GITHUB_REPO/packages"
    print_status "Group ID: au.com.streamotion.media3"
    print_status "Version: $releaseVersion"
    echo
    print_status "You can now use these in your projects:"
    print_status "  implementation 'au.com.streamotion.media3:media3-exoplayer:$releaseVersion'"
    print_status "  implementation 'au.com.streamotion.media3:media3-common:$releaseVersion'"
    print_status "  implementation 'au.com.streamotion.media3:media3-ui:$releaseVersion'"
fi
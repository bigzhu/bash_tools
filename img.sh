#!/usr/bin/env bash

set -e

# Display usage information
usage() {
    echo "Usage: $0 <image_file> <image_type>"
    echo "Process and compress images for blog use"
    echo ""
    echo "Arguments:"
    echo "  image_file   Path to the image file"
    echo "  image_type   Type of image (jpg, png, gif, svg, webp)"
    echo ""
    echo "Examples:"
    echo "  $0 photo.jpg jpg"
    echo "  $0 diagram.png png"
    echo ""
    echo "Dependencies:"
    echo "  - imagemagick (magick/convert)"
    echo "  - trash (for macOS) or trash-cli (for Linux)"
    exit 1
}

# Check parameters
if [ $# -ne 2 ]; then
    echo "Error: Wrong number of arguments"
    usage
fi

if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Error: Image type cannot be empty"
    usage
fi

blog_img_path="$HOME/Sync/home/cheese/images"
url_path="images"

# Create directory if it doesn't exist
if [ ! -d "$blog_img_path" ]; then
    echo "Creating directory: $blog_img_path"
    mkdir -p "$blog_img_path" || {
        echo "Error: Failed to create directory $blog_img_path" >&2
        exit 1
    }
fi

# Process filename
file_name=$(basename "$1")
file_name=${file_name%.*}
file_name=$file_name.webp
echo "Processing: $file_name"
# Check if target file already exists
if [ -f "$blog_img_path/$file_name" ]; then
    echo "Error: Target file '$blog_img_path/$file_name' already exists"
    echo "Please rename the file or remove the existing one"
    exit 1
fi
# URL encode file name using pure bash
url_encode() {
    local string="$1"
    local encoded=""
    local i
    for (( i=0; i<${#string}; i++ )); do
        local c="${string:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) encoded+="$c" ;;
            *) encoded+=$(printf '%%%02X' "'$c") ;;
        esac
    done
    echo "$encoded"
}

encode_file_name=$(url_encode "$file_name")
markdow_img_link="![$file_name]($url_path/$encode_file_name)"
# Process image based on type
if [ "$2" = "svg" ] || [ "$2" = "webp" ] || [ "$2" = "gif" ]; then
    # No compression needed for these types
    echo "Moving file without compression..."
    if mv "$1" "$blog_img_path/"; then
        echo "File moved successfully"
    else
        echo "Error: Failed to move file" >&2
        exit 1
    fi
else
    # Compress image
    echo "Compressing $file_name..."
    case $(uname) in
    Darwin)
        # Check if magick command exists
        if ! command -v magick >/dev/null 2>&1; then
            echo "Error: ImageMagick not found. Please install with: brew install imagemagick" >&2
            exit 1
        fi
        if magick "$1" "$blog_img_path/$file_name"; then
            echo "Image compressed successfully"
        else
            echo "Error: Failed to compress image" >&2
            exit 1
        fi
        ;;
    Linux)
        # Check if convert command exists
        if ! command -v convert >/dev/null 2>&1; then
            echo "Error: ImageMagick not found. Please install with: sudo apt install imagemagick" >&2
            exit 1
        fi
        if convert "$1" "$blog_img_path/$file_name"; then
            echo "Image compressed successfully"
        else
            echo "Error: Failed to compress image" >&2
            exit 1
        fi
        ;;
    *)
        echo "Error: Unsupported operating system" >&2
        exit 1
        ;;
    esac
    
    # Remove original file using trash
    if command -v trash >/dev/null 2>&1; then
        if trash "$1"; then
            echo "Original file moved to trash"
        else
            echo "Warning: Failed to move original file to trash" >&2
        fi
    else
        echo "Warning: trash command not found. Original file not removed"
        echo "Install trash with: brew install trash (macOS) or sudo apt-get install trash-cli (Linux)"
    fi
fi

# Copy markdown link to clipboard
case $(uname) in
Darwin)
    if command -v pbcopy >/dev/null 2>&1; then
        echo "$markdow_img_link" | pbcopy
        echo "Markdown link copied to clipboard"
    else
        echo "Warning: pbcopy not found. Markdown link not copied"
    fi
    ;;
Linux)
    if command -v xclip >/dev/null 2>&1; then
        echo "$markdow_img_link" | xclip -selection clipboard
        echo "Markdown link copied to clipboard"
    else
        echo "Warning: xclip not found. Please install with: sudo apt install xclip"
    fi
    ;;
*)
    echo "Warning: Unsupported OS for clipboard operations"
    ;;
esac

echo "Markdown link: $markdow_img_link"
echo "Image processing completed successfully!"

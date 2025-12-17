# TODO: Change this line if change device
# Navigate to the Hugo project directory
# cd

# Ask user for content type
echo "Enter content type (e.g., Weekly(W), Post(P), Project(Proj), Music(M), Book(B)):"
read content_type

# Ask user for the title or filename
echo "Enter the title or filename:"
read title

# Determine content path and archetype based on user input

case $content_type in
    weekly)
    	content_path="post/$title/index.md"
	    archetype_name="weekly"
	;;
    w)
        content_path="post/$title/index.md"
        archetype_name="weekly"
    ;;
    music)
        content_path="like/$title/index.md"
        archetype_name="music"
        ;;
    m)
        content_path="like/$title/index.md"
        archetype_name="music"
        ;;
    book)
        content_path="like/$title/index.md"
        archetype_name="book"
        ;;
    b)
        content_path="like/$title/index.md"
        archetype_name="book"
        ;;
    project)
        content_path="project/$title/index.md"
        archetype_name="project"
        ;;
    proj)
        content_path="project/$title/index.md"
        archetype_name="project"
        ;;
    post)
        content_path="post/$title/index.md"
        archetype_name="post"
        ;;
    p)
        content_path="post/$title/index.md"
        archetype_name="post"
        ;;
    *)
        archetype_name="$content_type"
        content_path="$content_type/$title/index.md"
        ;;
esac

# Print out the paths for debugging
echo "Using archetype: $archetype_name"
echo "Creating content at: $content_path"

# Create content using Hugo and the specified archetype
hugo new content --kind $archetype_name $content_path

echo "Content created successfully!"

open -a "Typora" "content/$content_path"

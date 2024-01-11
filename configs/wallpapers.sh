# Check if the Wallpapers JSON file exists
if [ -z "$(ls -A $wallpapers_folder)" ]; then
    warning "Wallpapers JSON file not found in $wallpapers_folder"
else
    # Create Wallpaper folder
    mkdir -p $system_wallpapers_folder

    # Loop through categories
    for category in $(cat "$wallpapers_data" | sed -n 's/"\([^"]*\)": \[.*/\1/p'); do
        # Create folder for the category inside Wallpaper
        warning "Downloading Wallpapers for: $category"
        mkdir -p "$system_wallpapers_folder/$category"
        
        # Loop through URLs in the category
        for url in $(cat "$wallpapers_data" | sed -n "/$category\": \[/,/]/p" | sed -e 's/^[[:space:]]*//' -e 's/"//g' -e 's/,//'); do
            # Download the file and save it to the category folder
            curl -s "$url" -o "$system_wallpapers_folder/$category/$(basename "$url")"
        done
        msg "Downloaded all images into Wallpaper/$category folder"
    done
fi


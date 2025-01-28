-- crop_screenshot.lua
-- This script allows you to crop the screenshot using ImageMagick's `magick` command

function crop_screenshot()
    local w = mp.get_property_native("dwidth")
    local h = mp.get_property_native("dheight")
    local screenshot_directory = mp.get_property("screenshot-directory")
    local screenshot_format = mp.get_property("screenshot-format")

    -- Capture the screenshot using the existing mpv settings
    mp.command("screenshot")

    -- Find the most recent screenshot in the directory
    local screenshot_template = mp.get_property("screenshot-template")
    local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
    local screenshot_path = string.format("%s/%s.%s", screenshot_directory, screenshot_template:gsub("%%", "%%%%"), screenshot_format)

    -- Crop the screenshot using ImageMagick's `magick` command
    local cropped_screenshot_path = screenshot_path:gsub("%."..screenshot_format, "_cropped."..screenshot_format)
    local command = string.format('magick "%s" -crop %dx%d+0+0 "%s"', screenshot_path, w, h, cropped_screenshot_path)
    os.execute(command)

    mp.osd_message("Screenshot cropped and saved to " .. cropped_screenshot_path)
end

mp.add_key_binding("Ctrl+s", "crop_screenshot", crop_screenshot)

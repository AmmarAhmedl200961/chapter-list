-- chapter_list.lua
-- A script for MPV to display all chapters in the OSD.

local mp = require "mp"

-- Function to display the chapter list
function display_chapter_list()
    local chapter_count = mp.get_property_number("chapters", 0)
    if chapter_count == 0 then
        mp.osd_message("No chapters available.")
        return
    end

    local current_chapter = mp.get_property_number("chapter", 0) + 1
    local chapter_list = "Chapters:\n"

    for i = 0, chapter_count - 1 do
        local title = mp.get_property(string.format("chapter-list/%d/title", i)) or ("Chapter " .. (i + 1))
        if i + 1 == current_chapter then
            chapter_list = chapter_list .. string.format("→ %d. %s\n", i + 1, title) -- Highlight the current chapter
        else
            chapter_list = chapter_list .. string.format("   %d. %s\n", i + 1, title)
        end
    end

    -- Display the chapter list in the OSD
    mp.osd_message(chapter_list, 5) -- Show for 5 seconds
end

-- Bind the function to a key
mp.add_key_binding("F7", "show-chapter-list", display_chapter_list)

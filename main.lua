-- ~/.config/yazi/plugins/jump_to_clipboard.lua (Corrected command check)
-- 重新使用标准、可靠的函数来检查命令是否存在
local function command_exists(cmd)
    return os.execute("command -v " .. cmd .. " > /dev/null 2>&1")
end

local function notify_error(message, urgency)
    ya.notify({
        title = "Clipboard Jump",
        content = message,
        level = urgency,
        timeout = 5
    })
end

return {
    entry = function()
        local paste_cmd

        -- 使用 command_exists 函数来决定用哪个剪贴板工具
        if command_exists("wl-paste") then
            paste_cmd = "wl-paste --no-newline"
        elseif command_exists("xclip") then
            paste_cmd = "xclip -o -selection clipboard"
        else
            return notify_error("Can't find 'wl-paste' or 'xclip'", "error")
        end

        -- 执行粘贴命令并获取路径
        local pipe = io.popen(paste_cmd)
        if not pipe then
            return
        end

        local path = pipe:read("*a")
        pipe:close()

        -- 清理路径字符串
        path = path:match("^[\r\n\t ]*(.-)[\r\n\t ]*$")

        if path and #path > 0 then
            -- 如果路径指向一个文件，则回退到其父目录
            local escaped = path:gsub("'", "'\\''")
            if os.execute("test -f '" .. escaped .. "'") == 0 then
                path = path:match("(.*)/") or path
            end
            ya.emit("cd", {path})
        else
            return notify_error("Cliboard content is empty or invalid.", "error")
        end
    end
}

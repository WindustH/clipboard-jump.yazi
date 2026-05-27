local function notify_error(message, urgency)
    ya.notify({
        title = "Clipboard Jump",
        content = message,
        level = urgency,
        timeout = 5,
    })
end

return {
    entry = function()
        local path = ya.clipboard()
        if not path or #path == 0 then
            return notify_error("Clipboard content is empty or invalid.", "error")
        end

        path = path:match("^[\r\n\t ]*(.-)[\r\n\t ]*$")
        path = path:gsub("^file://", ""):match("[^\r\n]+")

        if not path or #path == 0 then
            return notify_error("Clipboard content is empty or invalid.", "error")
        end

        local cha, err = fs.cha(Url(path))
        if not cha then
            return notify_error("Path does not exist: " .. path, "error")
        elseif not cha.is_dir then
            ya.emit("reveal", { target = path })
        else
            ya.emit("cd", { path })
        end
    end,
}

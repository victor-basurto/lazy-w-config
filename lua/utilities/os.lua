local M = {}

function M.get_os()
  local handle = io.popen("uname -s")
  if not handle then
    return "Unknown"
  end

  local os_name = handle:read("*a")
  handle:close()

  if not os_name then
    return "Unknown"
  end

  os_name = string.lower(os_name)

  if string.find(os_name, "windows") then
    return "Windows"
  elseif string.find(os_name, "darwin") then
    return "macOS"
  elseif string.find(os_name, "linux") then
    return "Linux"
  else
    return "Unknown"
  end
end

local current_os = M.get_os()
print("Detected OS:", current_os)

return M

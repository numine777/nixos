local files = vim.api.nvim_get_runtime_file("lua/numine/lazy/*.lua", true)

for _, file in ipairs(files) do
    local start = string.find(file, "numine")
    local path = file:sub(start)
    local require_path = path:gsub("/", "."):gsub(".lua", "")
    if string.find(require_path, "init") == nil then
        require(require_path).setup()
    end
end

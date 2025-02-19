return {
    {
        "MagicDuck/grug-far.nvim",
        opts = function (_, opts)
            table.insert(opts, { extraRgArgs = '--pcre2' })
        end,
    }
}

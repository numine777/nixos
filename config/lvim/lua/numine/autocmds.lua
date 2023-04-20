lvim.autocommands = {
	{ { "BufNewFile", "BufRead" }, {
		pattern = { "*Jenkinsfile" },
		command = ":set ft=groovy",
	} },
	{
		"TextYankPost",
		{
			pattern = "*",
			callback = function()
				vim.highlight.on_yank({
					highgroup = "IncSearch",
					timeout = 40,
				})
			end,
		},
	},
	{
		{ "BufNewFile", "BufRead" },
		{
			pattern = { "Podfile", "Gemfile", "Gymfile", "Fastfile", "Appfile", "Matchfile", "Pluginfile" },
			command = ":set ft=ruby",
		},
	},
	{
		"ColorScheme",
		{
			pattern = "*",
			callback = function()
				require("numine.colors").ColorMyPencils()
			end,
		},
	},
}

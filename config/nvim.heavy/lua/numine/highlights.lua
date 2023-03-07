local M = {}
local cmd = vim.cmd

M.init = function ()
	cmd "hi link NvimTreeLspDiagnosticsWarning LspDiagnosticsSignWarning"
	cmd "hi link NvimTreeLspDiagnosticsError LspDiagnosticsSignError"
	cmd "hi link NvimTreeLspDiagnosticsInformation LspDiagnosticsSignInformation"
	cmd "hi link NvimTreeLspDiagnosticsHint LspDiagnosticsSignHint"
	cmd "highlight WinSeparator guibg=None"
	cmd [[colorscheme gruvbox]]
end

return M

function ColorMyVi(color)
	color = color or "onedark_vivid"
	vim.cmd.colorscheme(color)
end

function MakeTrasparent()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyVi()

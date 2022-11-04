local status, catppuccin = pcall(require, "catppuccin")
if not status then
	print("catppuccin is not installed")
	return
end

catppuccin.setup({
	flavour = "mocha",
})

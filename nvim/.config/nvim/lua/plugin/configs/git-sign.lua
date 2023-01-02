local status, gitsigns = pcall(require, "gitsigns")
if not status then
	print("git signs not installed")
	return
end

gitsigns.setup({})

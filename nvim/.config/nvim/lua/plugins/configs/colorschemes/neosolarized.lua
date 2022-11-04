local status, neosolarized = pcall(require, "neosolarized")
if not status then
	print("neosolarized not installed")
	return
end

neosolarized.setup({
	comment_italics = true,
})

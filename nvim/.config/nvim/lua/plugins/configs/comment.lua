local status, comment = pcall(require, "Comment")
if not status then
	print("Commnet nvim not installed")
	return
end

comment.setup({})

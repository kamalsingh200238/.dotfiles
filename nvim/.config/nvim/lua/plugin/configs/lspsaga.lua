local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
	print("lspsaga not installed")
	return
end

lspsaga.setup{}

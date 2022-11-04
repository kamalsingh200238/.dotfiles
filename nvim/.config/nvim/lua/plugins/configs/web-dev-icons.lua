local status_ok, web_dev_icons = pcall(require, "nvim-web-devicons")
if not status_ok then
	return
end

web_dev_icons.setup({
	-- your personnal icons can go here (to override)
	-- DevIcon will be appended to `name`
	override = {
		js = {
			icon = "",
			color = "#FFD600",
			name = "Js",
		},
	},
})

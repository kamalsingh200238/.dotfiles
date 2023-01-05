local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	print("indent_blankline not installed")
	return
end

indent_blankline.setup({
  show_trailing_blankline_indent = false,
	show_current_context = true,
  show_current_context_start = false,
  use_treesitter = true,
  context_char = "▎",
  char = "▎",
  buftype_exclude = {
    "nofile",
    "terminal",
  },
  filetype_exclude = {
    "help",
    "startify",
    "aerial",
    "alpha",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "neo-tree",
    "Trouble",
  },
  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
})

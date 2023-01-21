local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	-- essentials ------------------------[[[
	"nvim-lua/plenary.nvim",
	"lewis6991/impatient.nvim",
	-- essentials ------------------------]]]

	-- helpers --------------------------[[[
	"tpope/vim-surround",
	"ThePrimeagen/harpoon",
	"mbbill/undotree",
	"mattn/emmet-vim",
	"tpope/vim-fugitive",
	-- helpers --------------------------]]]

	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
		priority = 1000,
		config = function()
			require("plugin.configs.web-dev-icons")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		tag = "nightly",
	}, -- explorer nvim-tree

	{ "nvim-telescope/telescope.nvim" }, -- fuzzy finder telescope

	{ -- tree sitter syntax highlighting
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{ "windwp/nvim-ts-autotag" },

			{
				"windwp/nvim-autopairs",
				config = function()
					require("nvim-autopairs").setup({})
				end,
			},

			{ "p00f/nvim-ts-rainbow", lazy = false, priority = 1000 },

			{ "NvChad/nvim-colorizer.lua" },

			{ "numToStr/Comment.nvim" },

			{ "JoosepAlviste/nvim-ts-context-commentstring" }, -- better comments in jsx
		},
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("plugin.configs.lsp")
		end,
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- null ls
			{
				"jose-elias-alvarez/null-ls.nvim",
			},
			{ "jay-babu/mason-null-ls.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			-- Pretty lsp
			{ "onsails/lspkind.nvim" },
			{ "glepnir/lspsaga.nvim" },
		},
	},

	{ "nvim-lualine/lualine.nvim" },

	{ "akinsho/bufferline.nvim" },
	"mrjones2014/smart-splits.nvim",

	{ "lukas-reineke/indent-blankline.nvim" },

	{ "lewis6991/gitsigns.nvim" },
	"dinhhuy258/git.nvim",

	-- dap
	"mfussenegger/nvim-dap",

	-- colorschemes
	"rose-pine/neovim",
	"bluz71/vim-nightfly-colors",
	"catppuccin/nvim",
	"EdenEast/nightfox.nvim",
	"savq/melange-nvim",
	"sainnhe/sonokai",
	"sainnhe/everforest",
	"sainnhe/edge",
	"rebelot/kanagawa.nvim",
	"sainnhe/gruvbox-material",

	"LunarVim/synthwave84.nvim",
	"LunarVim/horizon.nvim",
	"LunarVim/tokyonight.nvim",

	{ "monsonjeremy/onedark.nvim", branch = "treesitter" },
})

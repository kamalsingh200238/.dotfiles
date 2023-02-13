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

require("lazy").setup({
	-- essentials ------------------------[[[
	{ "nvim-lua/plenary.nvim", lazy = true },
	"lewis6991/impatient.nvim",
	-- essentials ------------------------]]]

	-- helpers --------------------------[[[
	"tpope/vim-surround",
	"ThePrimeagen/harpoon",
	"mbbill/undotree",
	"mattn/emmet-vim",
	"tpope/vim-fugitive",
	"ggandor/leap.nvim",
	"lervag/vimtex",
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
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("plugin.configs.telescope")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("plugin.configs.treesitter")
		end,
		dependencies = {
			{ "windwp/nvim-ts-autotag" },
			{
				"windwp/nvim-autopairs",
				config = function()
					require("nvim-autopairs").setup({})
				end,
			},
			{ "p00f/nvim-ts-rainbow" },
			{ "NvChad/nvim-colorizer.lua" },
			{ "numToStr/Comment.nvim" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
		},
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- null ls
			{ "jose-elias-alvarez/null-ls.nvim" },
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
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin.configs.lualine")
		end,
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin.configs.bufferline")
		end,
	},

	{ "mrjones2014/smart-splits.nvim" },

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		config = function()
			require("plugin.configs.indent-line")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("plugin.configs.git-sign")
		end,
	},
	{ "dinhhuy258/git.nvim" },

	{ "mfussenegger/nvim-dap" },

	-- colorschemes
	{ "rose-pine/neovim" },
	{ "bluz71/vim-nightfly-colors" },
	{ "catppuccin/nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "savq/melange-nvim" },
	{ "sainnhe/sonokai" },
	{ "sainnhe/everforest" },
	{ "rebelot/kanagawa.nvim" },
	{ "sainnhe/gruvbox-material" },
	{ "LunarVim/synthwave84.nvim" },
	{ "LunarVim/horizon.nvim" },
	{ "LunarVim/tokyonight.nvim" },
	{ "olimorris/onedarkpro.nvim" },
})

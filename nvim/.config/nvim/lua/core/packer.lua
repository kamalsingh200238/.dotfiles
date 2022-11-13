local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	print("Now installing Packer")
	print("After installation, restart packer again")
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
	return
end

packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "lewis6991/impatient.nvim" })

	-- helpers
	use({
		"tpope/vim-surround",
	})

	use({ -- lsp
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lsp.lspconfig")
		end,
	})
	use({ "onsails/lspkind.nvim", module = "lspkind" }) --lspicons
	use({ -- lsp saga
		"glepnir/lspsaga.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.configs.lsp.lspsaga")
		end,
	})
	use({ -- null ls
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.configs.lsp.null-ls")
		end,
	})

	use({ --mason
		"williamboman/mason.nvim",
		config = function()
			require("plugins.configs.lsp.mason")
		end,
	})
	use({ -- mason tools installer
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		after = { "nvim-lspconfig", "mason.nvim" },
		config = function()
			require("plugins.configs.lsp.mason-tool-installer")
		end,
	})

	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.configs.cmp")
		end,
	})
	use({ "hrsh7th/cmp-nvim-lsp" }) -- Don't lazy load this, because it's needed by nvim-lspconfig to work
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({
		"L3MON4D3/LuaSnip",
		tag = "v<CurrentMajor>.*",
		config = function()
			require("plugins.configs.luasnip")
		end,
	}) -- snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- snippets collection

	use({ -- Treesitter
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		event = "BufEnter",
		cmd = {
			"TSInstall",
			"TSInstallInfo",
			"TSInstallSync",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
			"TSDisableAll",
			"TSEnableAll",
		},
		config = function()
			require("plugins.configs.treesitter")
		end,
	})
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"NvChad/nvim-colorizer.lua",
		event = "BufEnter",
		config = function()
			require("plugins.configs.colorizer")
		end,
	})
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
	use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" }) -- better comments in jsx
	use({ -- comment
		"numToStr/Comment.nvim",
		module = { "Comment", "Comment.api" },
		keys = { "gc", "gb" },
		config = function()
			require("plugins.configs.comment")
		end,
	})

	use({ -- telescope
		"nvim-telescope/telescope.nvim",
		-- cmd = "Telescope",
		-- module = "telescope",
		config = function()
			require("plugins.configs.telescope")
		end,
	})

	use({ -- Web dev iconspacker
		"nvim-tree/nvim-web-devicons",
		module = "nvim-web-devicons",
		config = function()
			require("plugins.configs.web-dev-icons")
		end,
	})
	use({ -- Lua Line
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.configs.lualine")
		end,
	})
	use({ -- Bufferline
		"akinsho/bufferline.nvim",
		event = "UIEnter",
		config = function()
			require("plugins.configs.bufferline")
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.configs.indent-line")
		end,
	})

	use({ -- nvim tree
		"nvim-tree/nvim-tree.lua",
		tag = "nightly",
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
		config = function()
			require("plugins.configs.nvim-tree")
		end,
	})

	use({ -- Gitsigns
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.configs.git-sign")
		end,
	})
	use({ "dinhhuy258/git.nvim" })

	-- colorschemes
	use({ "rose-pine/neovim" })
	use({
		"catppuccin/nvim",
		config = function()
			require("plugins.configs.colorschemes.catppuccin")
		end,
	})
	use({ "folke/tokyonight.nvim" })
	use({ "dracula/vim" })
	use({ "tjdevries/colorbuddy.nvim" })
end)

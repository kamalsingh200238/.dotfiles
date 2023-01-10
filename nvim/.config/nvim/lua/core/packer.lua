local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- bootstrap to download packer automatically

-- for automatically compiling the packer file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer = require("packer")
packer.startup(function(use)
	-- essentials ------------------------[[[
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "lewis6991/impatient.nvim" })
	-- essentials ------------------------]]]

	-- helpers --------------------------[[[
	use({ "tpope/vim-surround" })
	use({ "ThePrimeagen/harpoon" })
	use({ "mbbill/undotree" })
	use({ "mattn/emmet-vim" })
	-- helpers --------------------------]]]

	use({ "nvim-tree/nvim-tree.lua", tag = "nightly" })
	use({ "nvim-telescope/telescope.nvim" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			{ "windwp/nvim-ts-autotag" },
			{
				"windwp/nvim-autopairs",
				config = function()
					require("nvim-autopairs").setup({})
				end,
			},
			{ "p00f/nvim-ts-rainbow" },
			{ "NvChad/nvim-colorizer.lua" },
		},
	})

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
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
			{ "glepnir/lspsaga.nvim" },
		},
	})

	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" }) -- better comments in jsx

	use({ "nvim-tree/nvim-web-devicons" })

	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/bufferline.nvim" })
	use({ "mrjones2014/smart-splits.nvim" })

	use({ "lukas-reineke/indent-blankline.nvim" })

	use({ "lewis6991/gitsigns.nvim" })
	use({ "dinhhuy258/git.nvim" })

	-- dap
	use({ "mfussenegger/nvim-dap" })

	-- colorschemes
	use({ "tjdevries/colorbuddy.nvim" })
	use({ "rose-pine/neovim" })
	use({ "catppuccin/nvim" })
	use({ "morhetz/gruvbox" })
	use({ "bluz71/vim-nightfly-colors" })
	use({ "LunarVim/synthwave84.nvim" })
	use({ "Tsuzat/NeoSolarized.nvim" })
	use({ "monsonjeremy/onedark.nvim", branch = "treesitter" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)

return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	build = ":TSUpdate",
	opts = {
		auto_install = true,
		indent = { enable = true },
		folds = { enable = true },
		highlight = { enable = true },
	},
}

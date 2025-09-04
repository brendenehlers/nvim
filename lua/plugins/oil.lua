return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
		opts = {},
	},
	{
		"benomahony/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
	}
}

return {
    'nvim-telescope/telescope-bibtex.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function ()
       vim.keymap.set("n", "<leader>lb", "<cmd>Telescope bibtex<CR>", {desc = "Insert bibtex quote"})
    end,
}

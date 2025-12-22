return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    config = function()
        require("luasnip.loaders.from_lua").lazy_load({paths = "/home/meide/.config/nvim/lua/meide/plugins/luasnip/"})
        local ls = require("luasnip")
        ls.setup({
            update_events = {"TextChanged", "TextChangedI"},
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
        })
        vim.keymap.set({"i", "s"}, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true, desc = "select autocomplete"})
    end
}



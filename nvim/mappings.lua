local M = {}
M.general = {
   n = {
      ["<leader>rr"] = {"<Plug>RestNvim", "Run curl request"},
      ["<leader>rp"] = {"<Plug>RestNvimPreview", "Preview curl request "},
      ["<leader>rl"] = {"<Plug>RestNvimLast", "Rerun last curl request"},
      ["fo"] = {"<cmd> foldopen <CR>", "Open Fold"},
      ["fc"] = {"<cmd> foldclose <CR>", "Close Fold"}
   },
   v = {
      ["fm"] = {"<cmd> fold <CR>", }
   }
}

return M

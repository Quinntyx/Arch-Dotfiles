return {
  ["elkowar/yuck.vim"] = { ft = "yuck" },

  ["sakhnik/nvim-gdb"] = {
    config = function()
      require "custom.plugins.nvim-gdb"
    end,
  },

  ["jbyuki/instant.nvim"] = {
    config = function()
      require "custom.plugins.instant"
    end
  },

  ["andweeb/presence.nvim"] = {
    config = function()
      require "custom.plugins.presence"
    end
  },
  ["NTBBloodbath/rest.nvim"] = {
    config = function()
      require "custom.plugins.rest"
    end
  },
  ["kevinhwang91/nvim-ufo"] = {
    requires = "kevinhwang91/promise-async",
    config = function()
      require "custom.plugins.nvim-ufo"
    end
  },
  ["sbdchd/neoformat"] = {
    config = function()
      require "custom.plugins.neoformat"
    end
  },
  ["goolord/alpha-nvim"] = {
     disable = false,
  }
}

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "nordfox",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          sections = { "error" },
        },
      },
      lualine_c = {
        {
          "filename",
          path = 1,
        },
      },
      lualine_x = { "encoding", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {
        {
          "buffers",
          icons_enabled = false,
          show_modified_status = false,
        },
      },
    },
    extensions = {},
  },
  dependecies = {
    "kyazdani42/nvim-web-devicons",
  },
}

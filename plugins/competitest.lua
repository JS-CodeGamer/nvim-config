return {
  "xeluxee/competitest.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  keys = { { "<leader>c", desc = "CompetiTest" } },
  cmd = "CompetiTest",
  config = function()
    require("competitest").setup()
    require("which-key").register({
      c = {
        name = "CompetiTest",
        r = {
          name = "Recieve",
          t = { "<cmd>CompetiTest receive testcases<cr>", "Testcases" },
          p = { "<cmd>CompetiTest receive problem<cr>", "Problem" },
          c = { "<cmd>CompetiTest receive contest<cr>", "Contest" },
        },
        t = { "<cmd>CompetiTest run<cr>", "Run Testcases" },
      },
    }, { prefix = "<leader>" })
  end,
}

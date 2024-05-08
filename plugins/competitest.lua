local cp_folder = "$(HOME)/dev/cp/"
local contest_folder = cp_folder .. "$(JUDGE)/$(CONTEST)/"
return {
  "xeluxee/competitest.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  keys = { { "<leader>cp" } },
  cmd = "CompetiTest",
  init = function()
    require("which-key").register({
      r = {
        name = "recieve",
        t = { "<cmd>CompetiTest receive testcases<cr>", "testcases" },
        p = { "<cmd>CompetiTest receive problem<cr>", "problem" },
        c = { "<cmd>CompetiTest receive contest<cr>", "contest" },
      },
      t = { "<cmd>CompetiTest run<cr>", "test" },
    }, { prefix = "<leader>cp" })
  end,
  opts = {
    testcases_directory = ".testcases",
    template_file = cp_folder .. ".templates/template.$(FEXT)",
    evaluate_template_modifiers = true,
    -- date_format = "%d/%m/%y %H:%M:%S",
    received_problems_path = contest_folder .. "$(PROBLEM).$(FEXT)",
    received_contests_directory = contest_folder,
  },
  config = function(_, opts)
    require("competitest").setup(opts)
  end,
}

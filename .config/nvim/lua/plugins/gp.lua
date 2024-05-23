return {
  {
    "robitx/gp.nvim",
    config = function()
      local config = {
        openai_api_key = "op read op://Personal/OpenAI/credential --no-newline",
      }
      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)

      require("gp").setup()
      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
  },
}

-- ChatGPT.nvim setup
return {
  -- Lazy
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      local config = {
        api_key_cmd = "op read op://Personal/OpenAI/credential --no-newline",
        extra_curl_params = {
          "-H",
          "Origin: https://example.com",
        },
        openai_params = {
          model = "gpt-4o",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 2000,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      }

      require("chatgpt").setup(config)
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}

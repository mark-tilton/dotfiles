-- Add leap for better movement
return {
  "ggandor/leap.nvim",
  config = function()
    require("leap").create_default_mappings()
  end,
}

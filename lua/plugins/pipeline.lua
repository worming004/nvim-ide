return {
  'topaxi/pipeline.nvim',
  -- optional, you can also install and use `yq` instead.
  build = 'go install github.com/mikefarah/yq/v4@latest',
  ---@type pipeline.Config
  opts = {},

}

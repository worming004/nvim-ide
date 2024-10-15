local wk = require "which-key"

function l(toappend)
  return "<leader>" .. toappend
end

wk.add({
  { l("c"),  group = "copilot" },
  { l("d"),  group = "dap" },
  { l("e"),  group = "edit" },
  { l("f"),  group = "telescope / search" },
  { l("fg"), group = "git" },
  { l("g"),  group = "git" },
  { l("gg"), group = "git" },
  { l("k"),  group = "kube" },
  { l("l"),  group = "lsp" },
  { l("la"), group = "lifecycle" },
  { l("n"),  group = "navigation" },
  { l("na"), group = "aerial" },
  { l("nh"), group = "harpoon" },
  { l("nt"), group = "test" },
  { l("o"),  group = "nvim-tree" },
  { l("q"),  group = "quick quit" },
  { l("t"),  group = "test" },
  { l("u"),  group = "utils" },
  { l("ud"), group = "duck?" },
  { l("um"), group = "markdown" },
  { l("v"),  group = "view" },
  { l("w"),  group = "write",             desc = "write helper" },
})

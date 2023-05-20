local config = {}

config.settings = {
  gopls = {
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralType = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
    },
  },
}
return config

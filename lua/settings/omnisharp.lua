local config = {
  enable_import_completion = true,
  -- enable_roslyn_analyzers = true, commented out waiting to get correct optionts configured
  enable_analyzer_support = true,
  enable_decompilation_support = true,
  organize_imports_on_format = true,
  inlay_hints_options = {
    enable_for_parameters = true,
    for_literal_parameters = true,
    for_indexer_parameters = true,
    for_object_creation_parameters = true,
    for_other_parameters = true,
    suppress_for_parameters_that_differ_only_by_suffix = false,
    suppress_for_parameters_that_match_method_intent = false,
    suppress_for_parameters_that_match_argument_name = false,
    enable_for_types = true,
    for_implicit_variable_types = true,
    for_lambda_parameter_types = true,
    for_implicit_object_creation = true,
  },
  handlers = {
    ["textDocument/definition"] = require("omnisharp_extended").handler,
  },
}
return config

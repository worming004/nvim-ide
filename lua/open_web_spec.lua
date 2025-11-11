-- https://github.com/nvim-lua/plenary.nvim/blob/master/TESTS_README.md
describe("open_web", function()
  local module

  before_each(function()
    module = require "open_web"
  end)

  it("github repo should be detected as github", function()
    -- arrange
    local remote = "https://www.github.com/worming004/nvim-ide.git"

    -- act
    local detected = module.detect_remote_type(remote)

    -- assert
    assert.equals(detected[1], 0, "should be detected")
    assert.equals(detected[2], "github", "should be detected as github")
  end)

  it("ssh format should be replaced to https format", function()
    -- arrange
    local remote = "git@github.com:worming004/nvim-ide.git"
    local remote_type = "github"

    -- act
    local result = module.replace_git_format_to_http(remote, remote_type)

    -- assert
    assert.is_string(result)
    assert.are_equal("https://www.github.com/worming004/nvim-ide", result)
  end)

  it("https format should not be replaced", function()
    -- arrange
    local remote = "https://www.github.com/worming004/nvim-ide"
    local remote_type = "github"

    -- act
    local result = module.replace_git_format_to_http(remote, remote_type)

    -- assert
    assert.is_string(result)
    assert.are_equal("https://www.github.com/worming004/nvim-ide", result)
  end)

  it("https format but with .git end should be trimmed", function()
    -- arrange
    local remote = "https://www.github.com/worming004/nvim-ide.git"
    local remote_type = "github"

    -- act
    local result = module.replace_git_format_to_http(remote, remote_type)

    -- assert
    assert.is_string(result)
    assert.are_equal("https://www.github.com/worming004/nvim-ide", result)
  end)

  it("trim_git should remove .git extension on url", function()
    local result = module.trim_git("truc/bidule.git")
    assert.are_equal(result, "truc/bidule")
  end)
end)

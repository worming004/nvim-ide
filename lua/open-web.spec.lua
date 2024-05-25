describe("open-web", function()
  local module

  before_each(function()
    module = require "open-web"
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
end)

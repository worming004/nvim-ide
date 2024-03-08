local M = {}

M.new = function()
  local I = {}

  -- this is the entry proint for the strategy
  I.waddle = function(self)
    return function(duck)
      local global_strategy = self.col_or_row(self)
      if global_strategy.comparer(duck) then
        if self.get_random() > self.probability then -- then 1/3 chance to go right
          return global_strategy.returner(duck)
        end
      end

      local sub_pos = self.sub_strategy(duck)
      if global_strategy.end_of_screen_reached(duck) then -- do not reach the end of the screen
        sub_pos = global_strategy.end_of_screen_returner(sub_pos)
      end
      return sub_pos
    end
  end

  I.col_or_row = function(self)
    return {
      comparer = function(duck)
        return duck.col < self.screen_pos_trigger()
      end,
      returner = function(duck)
        return { row = duck.row, col = duck.col + 1 }
      end,
      end_of_screen_returner = function(duck)
        local duck = vim.deepcopy(duck)
        duck.col = duck.col - 1
        return duck
      end,
      end_of_screen_reached = function(duck)
        return duck.col > vim.o.columns - 1
      end
    }
  end

  I.screen_pos_trigger = function()
    return vim.o.columns * 2 / 3
  end

  I.probability = 0.66

  I.get_random = function()
    -- replace this function if you want to control the random values
    return math.random()
  end

  I.sub_strategy = function(duck)
    local strats = require('duck').default_strategies
    local rnd = strats.random_waddle
    return rnd(duck)
  end

  -- this function is used to configure the strategy to target the rows with default values
  I.default_setup_for_row = function(self)
    self.col_or_row = function()
      return {
        comparer = function(duck)
          return duck.row > self.screen_pos_trigger()
        end,
        returner = function(duck)
          return { row = duck.row - 1, col = duck.col }
        end,
        end_of_screen_reached = function(duck)
          return duck.row < 1
        end,
        end_of_screen_returner = function(duck)
          local duck = vim.deepcopy(duck)
          duck.row = duck.row + 1
          return duck
        end
      }
    end

    self.screen_pos_trigger = function()
      return vim.o.lines * 1 / 3
    end
  end

  return I
end

M.top_right_corner_strategy = function(self)
  local col_strategy = self.new()

  local parent_row_strategy = self.new()
  parent_row_strategy:default_setup_for_row()
  parent_row_strategy.sub_strategy = col_strategy:waddle()
  return parent_row_strategy:waddle()
end

return M

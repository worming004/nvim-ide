function table.merge(t1, t2)
  for k, v in ipairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

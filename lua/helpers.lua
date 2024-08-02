function table.merge(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

function table.merge_dictionary(t1, t2)
  for k, v in pairs(t2) do t1[k] = v end
end

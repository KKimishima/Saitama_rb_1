require "./lib/deep_freezable"

class Bank
  CURR = deep_freezable(
    {"ja" => "yen","us" => "dollar","india" => "rupee"},
  )
end

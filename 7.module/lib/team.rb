require "./lib/deep_freezable"

class Team
  extend DeepFreezable
  COUN = deep_freezable(["ja","us","india"])
end

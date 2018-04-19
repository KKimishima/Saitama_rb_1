UNIT = {m:1.0,ft:3.28,in:39.37}
def convert_length(num,from: :m,to: :m)
  (num / UNIT[from] * UNIT[to]).round(2)
end



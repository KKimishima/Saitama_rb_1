def to_hex(r,g,b)
=begin
  "#" +
   r.to_s(16).rjust(2,"0") +
   g.to_s(16).rjust(2,"0") +
   b.to_s(16).rjust(2,"0")
=end
=begin
  hex = "#"
  [r,g,b].each do |n|
    hex += n.to_s(16).rjust(2,"0")
  end
=end
  [r,g,b].inject("#") do |hex,n|
    hex + n.to_s(16).rjust(2,"0")
  end
end

def to_ints(in_hex)
=begin
  out_hex = []
  out_hex <<  in_hex[1..2].hex
  out_hex <<  in_hex[3..4].hex
  out_hex <<  in_hex[5..6].hex
=end
=begin
  r = in_hex[1..2]
  g = in_hex[3..4]
  b = in_hex[5..6]
  
  out_hex = []
  [r,g,b].each do |i|
    out_hex << i.hex
  end
  out_hex
=end
  r = in_hex[1..2]
  g = in_hex[3..4]
  b = in_hex[5..6]
  [r,g,b].map{|n| n.hex}
end

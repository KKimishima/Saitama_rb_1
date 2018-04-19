h1 = {"ja"=>"日本","us"=>"アメリカ","cn"=>"中国"}

#p h1["ja"]

h1.each_with_index do |c,i|
  p c[i]
end

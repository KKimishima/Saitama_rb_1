def fizz_buzz(num)
  n = num.to_i
  if n == 0
    "無効な値でです"
  elsif n % 15 == 0
    "Fizz_Buzz"
  elsif n % 3 == 0
    "Fizz"
  elsif n % 5 == 0
    "Buzz"
  else
    n.to_s
  end
end

puts "fizz_buzzの判別する数値を入力してくだしてください"
print "数値:"
num = gets.to_i
puts "結果_#{fizz_buzz(num)}"

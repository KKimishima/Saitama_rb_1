# 配列作製
a1 = []
p a1[0]
# 要素追加
a1[0] = 0
p a1[0]
# 要素追加
a1 << 1
p a1
# 削除
a1.delete_at(0)
p a1
a1 << 2

# ループ
num = [1,2,3]
sum = 0
num.each do |n|
  sum += n
end
p sum

num2 = [1,23,4512,55,3,12]
num2.delete_if do |n|
  n.odd?
end
p num2

num3 = [1,2,3]
num4 = []
num4 = num3.map{|n| n*10}
p num4

module DeepFreezable
  def deep_freezable(arry_or_hash)
    arry_or_hash.each do |i|
      i.freeze
    end
    arry_or_hash.freeze
  end
end

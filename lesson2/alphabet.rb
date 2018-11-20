alphabet = (:a..:z).to_a
vowels_array = [:a,:e,:i,:o,:u,:y]
vowels_hash = {}

alphabet.each_with_index do |letter, number|
  vowels_hash[letter] = number + 1 if vowels_array.include?(letter)
end

puts vowels_hash

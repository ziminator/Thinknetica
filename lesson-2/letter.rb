alphabet = ("A".."Z").to_a
vow = ["A", "E", "I", "O", "U", "Y"]
vow_hash = {}

alphabet.each_with_index { |char, index| vow_hash[char] = index + 1 if vow.include?(char) }

puts vow_hash

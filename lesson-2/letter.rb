alp1 = ("А".."Е").to_a
alp1 << "Ё"
alp2 = ("Ж".."Я").to_a
alphabet = alp1 + alp2
vow = [ "А", "Е", "Ё", "И", "О", "У", "Ы", "Э", "Ю", "Я" ]
vow_hash = {}

alphabet.each_with_index { |char, index| vow_hash[ char ] = index + 1 if vow.include?( char ) }

puts vow_hash

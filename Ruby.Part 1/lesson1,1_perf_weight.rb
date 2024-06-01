puts "Как тебя зовут?"
name = gets.chomp
puts "Какого ты роста?"
height = gets.chomp.to_i
otvet = "#{name}, nвой идеальный вес #{(height - 110)*1.15}"
if (height - 110)*1.15 < 0 
	puts "Ваш вес уже оптимален"
else puts otvet
end
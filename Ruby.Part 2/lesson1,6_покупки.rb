baza1 = {}
baza2 = {}
loop do 
	puts "Please write goods name, pcs and prise"
	komanda1 = gets.chomp.to_s
	break if komanda1 == "stop"
	komanda2 = gets.chomp.to_i
	komanda3 = gets.chomp.to_f
	baza1 ["#{komanda1}"] = {"#{komanda2}" => "#{komanda3}"} 
	baza2 ["#{komanda1}"] = komanda2*komanda3

end
puts baza1
puts baza2
puts baza2.values.sum
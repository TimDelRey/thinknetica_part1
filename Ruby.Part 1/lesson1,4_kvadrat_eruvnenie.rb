puts "Введите 3 коэффициента квадратного уравнения"
puts "коэффициент а:"
a = gets.chomp.to_i
puts "коэффициент b:"
b = gets.chomp.to_i
puts "коэффициент c:"
c = gets.chomp.to_i

d = (b**2)-(4*a*c)

if d > 0 
x1 = (-b+(Math.sqrt(d)))/2*a
x2 = (-b-(Math.sqrt(d)))/2*a
	puts "дискриминант равен #{d}, корни уравнения #{x1} и #{x2}"
elsif d == 0
	puts "дискриминант равен #{d}, корень уравнения #{-b/2*a}"
elsif d < 0 
	puts "дискриминант равен #{d}, корней нет"
else puts "все пропало"	
end 
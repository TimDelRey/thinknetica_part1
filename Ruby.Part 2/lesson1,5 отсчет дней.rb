# Определение высокосного года
a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

months2={}
months3=[]
months = {1=>31,2=>28,3=>31,4=>30,5=>31,6=>30,7=>31,8=>31,9=>30,10=>31,11=>30,12=>31}
monthsv = {1=>31,2=>29,3=>31,4=>30,5=>31,6=>30,7=>31,8=>31,9=>30,10=>31,11=>30,12=>31}

if c % 4 == 0
	if c % 100 == 0
		if c % 400 == 0
			year = monthsv
			else year = months
			end
		else year = monthsv
		end
	else year = monthsv
end

months2 = year.select {|key, value| key < b}
months2.each {|key,value| months3.push(value)}
otvet = months3.sum+a
puts otvet
		
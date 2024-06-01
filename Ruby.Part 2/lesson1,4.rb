bykvi=('a'..'z').to_a
numbers=(1..bykvi.to_a.size)
number = 0
all = {}
while number < numbers.last do
	all["#{bykvi[number]}"]=number+1
number+=1
end
glas = ["e", "y", "u", "i", "a", "o"]
all2 = all.select {|key, value| glas.include?(key)}

#all.each do |key, value|
#if key != "e"||"u"||"u"||"i"||"o"||"a"
#	all.delete(key)
#end

year = {
	:junaury=> 31, 
	:febraury=>28, 
	:march=>31, 
	:aprel=> 30, 
	:may=> 31, 
	:june=> 30, 
	:jule=> 31, 
	:august=>31, 
	:septeber=>30, 
	:october=>31, 
	:november=>30, 
	:december=> 31}
year.each {|month, days|
if days == 30
puts "#{month}"
end}
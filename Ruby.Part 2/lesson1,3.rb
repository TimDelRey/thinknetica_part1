arr = [0,1]
while arr.last < 100 #правильно arr[i-2]+arr[i-1]<100
i=0
arr.push (arr[i-2]+arr[i-1])
i+=1
end
str = `vmstat`
arr1 = str.split("\n")
arr2 = arr1[2].split(" ")
a={"cpu_ut"=> arr2[-4],"cpu_st"=>arr2[-3],"cpu_it"=>arr2[-2],"cpu_wa"=>arr2[-1]}
a.each{|name,fact|
        Facter.add(name) do
	confine :operatingsystem => :Ubuntu
		setcode do
			fact
		end
	end
}


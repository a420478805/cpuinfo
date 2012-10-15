if(FileTest::exist?("/tmp/cpu.info"))
	i = 0
	total_ut=0
	total_st=0
	total_it=0
	total_wa=0
	File.open("/tmp/cpu.info","r") do |file|
	while line  = file.gets
		        #puts line #打印出文件内容
		        if((!line.include?"procs")&&(!line.include?"swpd"))
		                #puts line
		                i = i + 1
		                arr = line.split(" ")
		                total_ut=total_ut+arr[-4].to_f
		                total_st=total_st+arr[-3].to_f
		                total_it=total_it+arr[-2].to_f
		                total_wa=total_wa+arr[-1].to_f
		        end
		end
	end
	open("/tmp/cpu.info","w+")
	if(i!=0)
		cpu_ut = ((total_ut/i)*100).round/100.0
		cpu_st = ((total_st/i)*100).round/100.0
		cpu_it = ((total_it/i)*100).round/100.0
		cpu_wa = ((total_wa/i)*100).round/100.0
		#p "cpu_ut: "+cpu_ut.to_s
		#p "cpu_st: "+cpu_st.to_s
		#p "cpu_it: "+cpu_it.to_s
		#p "cpu_wa: "+cpu_wa.to_s
		a={"cpu_ut"=>cpu_ut ,"cpu_st"=>cpu_st,"cpu_it"=>cpu_it,"cpu_wa"=>cpu_wa}
		a.each{|name,fact|
		        Facter.add(name) do
		        confine :operatingsystem => :Ubuntu
		                setcode do
		                        fact
		                end
		        end
		}
	end
end

if(File.directory?'/tmp/instance')
        str = `cd /tmp/instance && ls`
        arr = str.split(' ')
        for tmp in arr
                total_cpu = 0
                total_mem = 0
                i = 0
                File.open("/tmp/instance/#{tmp}","r") do |file|
                        while line  = file.gets
                                if(line.include?"kvm")
                                        #puts line
                                        i = i + 1
                                        arr1 = line.split(" ")
                                        total_cpu = total_cpu + arr1[8].to_f
                                        total_mem = total_mem + arr1[9].to_f
                                end
                        end
                end
                open("/tmp/instance/#{tmp}","w+")
                if(i!=0)
                        cpu = ((total_cpu/i)*100).round/100.0
                        mem = ((total_mem/i)*100).round/100.0
                        a={"#{tmp}_cpu"=>cpu ,"#{tmp}_mem"=>mem}
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
end

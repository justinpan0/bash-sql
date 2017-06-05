# Stress testing for mysql-mycat distributed database

#! /bin/bash

if [ $(id -u) = "0" ]; then
        echo "superuser"
fi

echo -n "Enter test time (in minute): "
read time
echo "You entered: $time minute"
echo -n "Enter test number: "
read number
echo "You entered: $number times"
echo "Test begin"
iter=0
while [ $iter != 3 ]; do
        end=$((SECONDS+time))
        sum=0
        count=0
        while [ $SECONDS -lt $end ]; do
                diff=$((end-SECONDS))
                if [ $((diff%60)) -eq 0 ]; then
                        temp=$(top -n 2 -d 1 | grep Cpu | awk 'NR%1000=2' | awk '{print substr($2,1,3)}')
                        sum=$(echo "$sum+$temp" | bc)
                        echo Tic #Heartbeat
                        count=$((count+1))
                        sleep 1m
                fi
        done
        sum=$(echo "$sum/$count" | bc)
        count=$(mysql --host=10.1.10.110 --user=root --password=root -se "use #database#; select count(*) from #database#;")
        echo -e "$(date +%Y%m%d%H%m%d)\t$count\t$sum" >> test.txt
        echo Tak #Heartbeat
        iter=$((iter+1))
done

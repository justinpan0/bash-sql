# Stress testing for mysql-mycat distributed database

#! /bin/bash

if [ $(id -u) = "0" ]; then
        echo "superuser"
fi

iter=0
while [ $iter != 3 ]; do
        end=$((SECONDS+3600))
        while [ $SECONDS -lt $end ]; do
                continue;
        done
        read count <<< $(mysql --host=10.1.10.110:3066 --user=root --password=root -se "select count(*) from picppoc")
        count >> date.txt
        iter=$((iter+1))
done

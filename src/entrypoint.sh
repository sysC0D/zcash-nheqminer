#!/bin/bash
echo "-> Update DNS"
echo "nameserver 208.67.222.222" > /etc/resolv.conf
echo "nameserver 208.67.220.220" >> /etc/resolv.conf

echo "-> Wait network connexion"
netwreach=0
while [ "$netwreach" == 0 ]
do
        if ping -c 1 8.8.8.8
        then
                netwreach=1
        else
                echo "--> Waiting network..."
                sleep 1
        fi
done

buildok="/root/build.ok"
if [ ! -f "$buildok" ]
then
	echo "Prepare Mining Zcash"
	cd /root/nheqminer/cpu_xenoncat/Linux/asm/
	sh assemble.sh
	cd ../../../Linux_cmake/nheqminer_cpu
	cmake .
	make -j $(nproc)
	touch $buildok
fi

sleep 5
echo "Launch Mining Zcash"
cd /root/nheqminer/Linux_cmake/nheqminer_cpu; ./nheqminer_cpu \
-l $stratum -u $workeruser -p $workerpwd -t $cpulim &

echo "Launch Supervisor"
/usr/bin/supervisord

exec "$@"

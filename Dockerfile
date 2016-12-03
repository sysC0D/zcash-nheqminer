FROM        	debian:latest
MAINTAINER  	sysc0d

RUN apt-get update && apt-get install -y \ 
		cmake build-essential libboost-all-dev \
		git curl supervisor vim

RUN cd /root \
	&& git clone -b Linux https://github.com/nicehash/nheqminer.git \
	&& cd nheqminer/cpu_xenoncat/Linux/asm/ \
	&& sh assemble.sh \
	&& cd ../../../Linux_cmake/nheqminer_cpu \
	&& cmake . \
	&& make -j $(nproc)

COPY src/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY src/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh 
ENTRYPOINT ["/entrypoint.sh"]

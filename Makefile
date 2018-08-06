
VOLUMES = -v maven-repo:/root/.m2 -v $(shell pwd):/data
VOLUMES+= -v $(HOME)/.m2/settings.xml:/root/.m2/settings.xml
VOLUMES+= -v $(HOME)/.gnupg:/root/.gnupg

ENV = -e GPG_TTY=/dev/pts/0

DEFAULT_CMD = docker run -it --rm $(VOLUMES) -w /data $(ENV)  maven:3.5-jdk-10

build:
	$(DEFAULT_CMD) mvn clean install

clean:
	$(DEFAULT_CMD) mvn clean

deploy:
	$(DEFAULT_CMD) mvn clean deploy

release:
	$(DEFAULT_CMD) mvn nexus-staging:release

wiki:
	echo Starting server @ http://127.0.0.1:8088/index.html
	docker run -v ${PWD}:/media -p 127.0.0.1:8088:80 -it --rm sashgorokhov/webdav



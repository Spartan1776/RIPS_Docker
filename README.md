# About rips-docker
rips-docker is a Docker build for the (now abandoned) RIPS 0.5 static source code analyzer for PHP vulnerabilities

## How to use this project 

### Clone this repo 
```shell
git clone https://github.com/Spartan1776/rips-docker/
cd rips-docker
```

### Configure Docker
If you haven't already installed docker, you'll need to do so. If you're running Ubuntu or a similar Debian-based distro that uses the Advanced Package Tool (APT, or "apt"), you can convert easyDockerInstall to an executable and run the installation file:
```shell
chmod +700 easyDockerInstall
sudo ./easyDockerInstall
```

If easyDockerInstall fails, try running kaliDockerFix
```shell
chmod +700 kaliDockerFix
sudo ./kaliDockerFix
```

## Configuring Source Code Location
The rips-docker project was originally developed to support static source code analysis of PHP vulnerabilities in Hackazon; however, it includes functionality (see Option #2 below) for static analysis of any .php files.

### Context - Hackazon
Hackazon is a vulnerable test application site, that incorporates a realistic e-commerce workflow with full functionality and technology commonly used in today’s mobile and web applications.

If you'd like to load Hackazon in a Docker container (not required to scan source code), an updated version of Newlode's Dockerized Hackazon project (now archived) is available here: https://github.com/Spartan1776/hackazon

### Two Options for Source Code Analysis:
The [Dockerfile](https://github.com/Spartan1776/RIPS_Docker/blob/master/Dockerfile) is pre-configured with two ways to analyze source code:

1 - Load Hackazon source code directly with no user interaction:

Uncommenting the lines:
```shell
ADD https://github.com/rapid7/hackazon/archive/master.zip /tmp/
RUN cd /tmp/ && unzip master.zip && mkdir -p /container/source_code && cp -R /tmp/hackazon-master/* /container/source_code/
```
will load Hackazon source code directly from Rapid7's Hackazon GitHub project (https://github.com/rapid7/hackazon)



2 - Add Hackazon (or your own source code) to this project's "source code" folder

Uncommenting the lines (uncommented by default):
```shell
RUN mkdir -p /container/source_code
ADD source_code/* /container/source_code
```
will move whatever source code you have placed in the LOCAL source_code directory (note: remove "REMOVE_ME.txt" file from folder) to a source_code directory located at /container/source_code inside the Docker container (and therefore accessible by the Docker container).

### Build and start
Once Docker is installed, start the docker image:
```shell
sudo docker-compose up
```

### Wait for a few seconds then contact the server:
For Firefox:
```shell
firefox http://127.0.0.1:8086
```
For Chrome:
```shell
chromium http://127.0.0.1:8086
```

## Scanning source code
This guide won't go into an in-depth explanation of the settings available on the RIPS localhost page.

However, in order to scan your source code, enter:
```shell
/container/source_code
```
into the "path / file:" box on the RIPS localhost page.

Also check the "code style:" value ("phps" for Hackazon) prior to clicking "scan".

## Changing source code between scans

To swap source code, use Option #1 or #2 for adding source code (mentioned above), then rebuild the docker image using:
```shell
sudo docker-compose up --build
```

Happy hunting!

## Special Thanks
This project was developed around the ripsscanner RIPS 0.5 static source code analyzer for PHP vulnerabilities (https://github.com/ripsscanner/rips).

The Docker configuration was developed with inspiration from Newlode's Dockerized Hackazon project (https://github.com/Newlode/hackazon).

Thanks for all the hard work!

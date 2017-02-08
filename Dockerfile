FROM suchja/wine:latest
MAINTAINER Jonata Weber <jonataa@gmail.com>

# get at least error information from wine
ENV WINEDEBUG -all,err+all

# unfortunately we later need to wait on wineserver. Thus a small script for waiting is supplied.
USER root
COPY waitonprocess.sh /scripts/
RUN chmod +x /scripts/waitonprocess.sh

# Install .NET Framework 4.0
USER xclient
# Dismiss .net, we only need innosetup
RUN wine wineboot --init \
		&& /scripts/waitonprocess.sh wineserver #\
#		&& winetricks --unattended dotnet40 dotnet_verifier \
#		&& /scripts/waitonprocess.sh wineserver

# Install Inno Setup binaries
RUN mkdir /home/xclient/inno \
		&& cd /home/xclient/inno \
		&& curl -SL "http://www.jrsoftware.org/download.php/is.exe" -o is.exe \
		&& wine is.exe /SILENT; exit 0  

USER root
COPY iscc.sh /scripts/
RUN chmod +x /scripts/iscc.sh

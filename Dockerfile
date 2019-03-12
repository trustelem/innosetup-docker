FROM suchja/wine:latest
MAINTAINER Aaron Madlon-Kay <aaron@madlon-kay.com>

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends xvfb \
    && rm -rf /var/lib/apt/lists/*

# get at least error information from wine
ENV WINEDEBUG -all,err+all

# Run virtual X buffer on this port
ENV DISPLAY :99

COPY opt /opt
RUN chmod +x /opt/bin/*
ENV PATH $PATH:/opt/bin

USER xclient

# Install Inno Setup binaries
RUN curl -SL "http://www.jrsoftware.org/download.php/is.exe" -o is.exe \
    && wine-x11-run wine is.exe /SP- /VERYSILENT \
    && rm is.exe

WORKDIR /work
ENTRYPOINT ["wine-x11-run", "iscc"]

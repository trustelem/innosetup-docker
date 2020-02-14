FROM amake/wine:latest
MAINTAINER Aaron Madlon-Kay <aaron@madlon-kay.com>

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends procps xvfb \
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
RUN curl -SL "http://files.jrsoftware.org/is/6/innosetup-6.0.3.exe" -o is.exe \
    && wine-x11-run wine is.exe /SP- /VERYSILENT /ALLUSERS /SUPPRESSMSGBOXES \
    && rm is.exe

# Install unofficial languages
RUN cd "/home/xclient/.wine/drive_c/Program Files/Inno Setup 6/Languages" \
    && curl -L "https://api.github.com/repos/jrsoftware/issrc/tarball/ec262f6ded5eaa9db2565977463ea633b3b1df60" \
    | tar xz --strip-components=4 --wildcards "*/Files/Languages/Unofficial/*.isl"

WORKDIR /work
ENTRYPOINT ["iscc"]

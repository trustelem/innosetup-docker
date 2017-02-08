

working :

docker run --rm -it --link display:xserver --volumes-from display suchja/wine:latest /bin/bash


after having
launch first:
docker run -d --name display -e VNC_PASSWORD=newPW -e XFB_SCREEN=1280x800x24 -p 5900:5900 suchja/x11server


----

xclient@49e054e195f2:~$ history
    1  wineboot --ini
    2  curl -SL "http://www.jrsoftware.org/download.php/is.exe" -o is.exe
    3  wine is.exe /VERYSILENT
    4  ls
    5  ls /
    6  vi iscc.sh
    7  vim iscc.sh
    8  nano iscc.sh
    9  help
   10  curl -SL "https://raw.githubusercontent.com/basix38/innosetup-docker/master/iscc.sh" -o iscc.sh
   11  chmod +x iscc.sh 
   12  ./iscc.sh 
   13  ./iscc.sh toto.iss
   14  curl -SL "https://raw.githubusercontent.com/basix38/innosetup-docker/master/helloworld.iss" -o helloworld.iss
   15  ./iscc.sh helloworld.iss 
   16  ls
   17  ls Output/
   18  history


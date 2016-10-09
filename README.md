docker-filebot-ui
=================

This is a Docker container for running [FileBot](http://www.filebot.net/), a media file organizer. Unlike
coppit/filebot, this version is interactive, with a GUI exposed via RDP.

Usage
-----

This docker image is available as a [trusted build on the docker index](https://index.docker.io/u/coppit/filebot/).

Run:

`sudo docker run --name=FileBot-UI -d -p 3389:3389 -v /input/dir/path:/input -v /output/dir/path:/output:rw -v /config/dir/path:/config:rw coppit/filebot-ui`

Then connect a remote desktop client to your server. If you have changed the host port, then specify the server as `<host
ip>:<host port>`. There are RDP clients for multiple platforms:

* Microsoft Remote Desktop for Windows (built into the OS)
* [Microsoft Remote Desktop for OS X](https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417?mt=12)
* [rdesktop for Linux](http://www.rdesktop.org/)

Connect with any username and password to use the FileBot UI.

With the default configuration, files written to the input directory will be renamed and copied to the output directory.
It is recommended that you do **not** overlap your input and output directories. FileBot will end up re-processing files
that it already processed, and generally make a mess of things.

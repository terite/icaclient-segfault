### How to use this repository
0. Be on a M1/arm64 mac.
1. Grab a valid `launch.ica` file and move it next to the Dockerfile
2. run `bash repro.sh`
3. Connect to the VNC server listening on port 5920 with password "password".
4. Accept the EULA (if you're fast enough to click it). Observe segfault.

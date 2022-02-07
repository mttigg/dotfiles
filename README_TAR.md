Installing tar files:

`cd ~/Downloads`
`tar -xzf [tar file]` (x = extract) (z = unzip (for tar.gz)) (f = choose file path)
`sudo mkdir -p /opt/apps/` This will only be needed on your first install
`sudo mv [extracted file] /opt/apps/` move your install to the application directory (specifically for tars).
`sudo ln -s /opt/apps/[extracted file]/[extracted file] /usr/local/bin/[extrated file]` link our tar install to our global install directory
`[application name]` check if we can now run the application

Now we also want this application searchable,
`sudo vim /usr/share/applications/[application name].desktop` create a new file

```
[Desktop Entry]
Type=Application
Name=[extracted file]
Icon=/opt/apps/[extracted file]/app/resources/app/assets/icon.png
Exec="/opt/apps/[extracted file]/[extracted file]"
Comment=[application name] Desktop App
Categories=Development;Code;


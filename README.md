## Installation

### Windows Installation

1. The following files should be placed somewhere on your PATH:
 * `notify-host-server.bat`
 * `notify-host-server/` (This must be in the same directory as `notify-host-server.bat`)
 * `notifu.exe` (This can be replaced with any other Windows notification system)

2. The scripts in the `vm` directory must be sent to your VM.
 * `notify-host` should be placed somewhere on your PATH (e.g. `/usr/local/bin`)
 * `notify.sh` should be included in your `.bashrc` file:
       `. /path/to/notify.sh`
   and you should re-source .bashrc from your command line:
       `. ~/.bashrc`

3. If you'd like to be able to start/stop the host's server using Powershell, copy the
`ps-notify-host` directory to your Powershell Modules directory (e.g. `%HOME%\Documents\WindowsPowerShell\Modules`).
Then add `Import-Module ps-notify-host` to the top of your `Microsoft.PowerShell_profile.ps1` file.

This does not automatically start the notify-host server when you start Powershell. To do that, simply run
`Start-NotifyHostServer`. This starts a background job that runs the server. To stop the server, run
`Stop-NotifyHostServer`.
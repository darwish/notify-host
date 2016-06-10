# Synopsis
A series of small scripts designed to allow a virtual machine to send alerts back to a host machine.

Many developers run their code in a development environment on a virtual machine. This has many advantages,
but one problem is that long-running tasks have no way of alerting the user on the host machine when they
have completed.

These scripts install a lightweight server on the host machine that listens for requests from the VM and
runs a notification program on the host to alert the user.

# Installation

## Windows Installation

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
```powershell
Start-NotifyHostServer
```
This starts a background job that runs the server.

To stop the server, run
```powershell
Stop-NotifyHostServer
```

# Usage
First, ensure that the server is running on the host machine. Installation instructions are provided for Powershell only:
```powershell
Start-NotifyHostServer
```

When performing long-running tasks on the virtual machine, wrap any command with the `notify` function:
```bash
notify mysql -e "select * from bigtable" > outfile
```

This will cause an alert to appear on the host when the query completes.

Messages can be sent directly to the host machine by running:
```bash
notify-host -m "Message" [-p "VM Says:"] [-t <info|warn|error>]
```
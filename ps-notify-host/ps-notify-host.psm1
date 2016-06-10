# All about the notify-host-server job
$script:job;

function Start-NotifyHostServer {
    $script:job = Start-Job -ScriptBlock { notify-host-server }
}

function Stop-NotifyHostServer {
    $script:job | Stop-Job
}
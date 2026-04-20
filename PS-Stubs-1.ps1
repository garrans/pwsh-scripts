param(
    [Parameter(Mandatory=$true)]
    [string]$Command
)

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    $scriptPath = $MyInvocation.MyCommand.Path
    $shellPath = (Get-Process -Id $PID).Path

    if (-not $shellPath) {
        $shellPath = "powershell.exe"
    }

    $escapedCommand = $Command.Replace('"', '`"')
    $argumentList = @(
        "-NoProfile"
        "-NoExit"
        "-ExecutionPolicy", "Bypass"
        "-File", "`"$scriptPath`""
        "-Command", "`"$escapedCommand`""
    )

    Start-Process -FilePath $shellPath -Verb RunAs -ArgumentList $argumentList | Out-Null
    exit 0
}

# Execute the command
Invoke-Expression $Command

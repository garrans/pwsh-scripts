# pwsh-scripts

Small utility PowerShell scripts.

## PS-Stubs-1.ps1

Runs a provided command and auto-elevates to Administrator if needed.

### Usage

```powershell
.\PS-Stubs-1.ps1 "ls"
```

If launched from a non-admin shell, it prompts for elevation, runs the command in an elevated session, and keeps the elevated shell open for additional commands.

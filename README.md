# PowerShell Scan
Herramienta en PowerShell que efectúa descubrimiento de host via "ping sweep" y realiza escaneo de puertos TCP.

## Uso
```powershell
# Ping sweep
powershellScan.ps1 -TypeScan PingSweep -Networks NETWORK [-TimeOut] [-ShowOnlyHostUp]
# Port scan
powershellScan.ps1 -TypeScan PortScan -Targets TARGET [-Protocol] [-Ports] [-TopPorts] [-TimeOut] [-ShowClosedPorts]
```

## Ejemplos de utilización
```powershell
# Ping sweep
.\powershellScan.ps1 -TypeScan PingSweep -Networks 10.0.0 -ShowOnlyHostUp
# Port scan
.\powershellScan.ps1 -TypeScan PortScan -Targets 10.0.0.1 -TopPorts 1000
.\powershellScan.ps1 -TypeScan PortScan -Targets 10.0.0.1, 10.0.0.2, 10.0.0.3 -Ports 21,22,23,25,80,110,139,443,445,3389 -ShowClosedPort
```
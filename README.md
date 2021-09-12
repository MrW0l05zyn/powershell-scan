# PowerShell Scan
Herramienta en PowerShell que efectúa descubrimiento de host via "ping sweep" y realiza escaneo de puertos TCP.

## Uso
```
powershellScan.ps1 [-Networks NETWORK] [-OnlyHostUp]
```

## Ejemplos de utilización
```
.\powershellScan.ps1
.\powershellScan.ps1 -Networks 10.0.0
.\powershellScan.ps1 -Networks 10.0.0, 172.16.0, 192.168.0 -OnlyHostUp
```

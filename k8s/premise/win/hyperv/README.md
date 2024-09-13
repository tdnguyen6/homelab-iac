default switch allow internat via NAT, restart ethernet adapter if can't connect

allow WSL and HyperV (reset on reboot)

```
Get-NetIPInterface | where {$_.InterfaceAlias -eq 'vEthernet (WSL (Hyper-v firewall))' -or $_.InterfaceAlias -eq 'vEthernet (Default Switch)'} | Set-NetIPInterface -Forwarding Enabled
```

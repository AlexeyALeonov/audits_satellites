# audits_satellites.ps1
Audits per satellite, Powershell version

1. Clone/download a [audits_satellites.ps1](./audits_satellites.ps1) to the preferred folder
2. Switch to there
3. Run the script
```
./audits_satellites.ps1
```

To specify the path to log file, you can use an optional parameter `-Path`:
```
./audits_satellites.ps1 -Path x:\storagenode\node.log
```

# audits_satellites.sh
Audits per satellite, bash version
1. Clone/download a [audits_satellites.sh](./audits_satellites.sh) to the preferred folder
2. Switch to there
3. Make the script executable:
```
chmod +x ./audits_satellites.sh
```
4. Run the script
```
./audits_satellites.sh
```

You can specify the path to the log as the first argument:
```
./audits_satellites.sh /mnt/storj/storagenode/node.log
```

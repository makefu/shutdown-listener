#!/usr/bin/env pwsh-preview
############################
#
# This is an example shutdown script for a windows system using winrm and remote powershell.
# Please ensure that winrm is enabled on the remote system.
#
###########################

##################
#   variables	##
##################
# Define clear text string for username and password
[string]$userName = 'Chris'
[string]$userPassword = 'judoka92'
[string]$hostname = '192.168.254.254'

# Convert to SecureString
[securestring]$secStringPassword = ConvertTo-SecureString $userPassword -AsPlainText -Force

# create PSCustom Object of Type PSCredential
[pscredential]$credObject = New-Object System.Management.Automation.PSCredential ($userName, $secStringPassword)

# connect to windows server and shutdown
Invoke-Command -ComputerName $hostname -Authentication Negotiate -Credential $credObject -ScriptBlock { Restart-Computer -Force }

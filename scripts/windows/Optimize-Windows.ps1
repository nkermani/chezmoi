# Désactive les animations de réduction/agrandissement
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0
# Accélère l'affichage des menus et focus
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 0
Write-Host "Optimisation terminée. Redémarrez votre session Windows pour l'effet immédiat."


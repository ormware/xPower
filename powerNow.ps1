#Invoke-WebRequest not complete html


#Open Edge + url
Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" '"https://www.energifyn.dk/kundeservice/kundeservice-el/faq-el/hvad-er-prisen-pa-el/"' 

#SendKeys
$wshell = New-Object -ComObject wscript.shell 


try {
    #Delete old file
    Remove-Item "C:\Users\$env:username\Documents\Elpris\Hvad er prisen på el_.html" -ErrorAction Stop
}
catch [System.Management.Automation.ItemNotFoundException] {
    echo "no such file"
}
catch {
    echo "SOME ERROR"
}

sleep 5
$wshell.SendKeys('^{s}')
sleep 2
$wshell.SendKeys('{ENTER}')
sleep 10
Stop-Process -Name "msedge"

[string[]]$content = Get-Content -Path "C:\Users\$env:username\Documents\Elpris\Hvad er prisen på el_.html"


for ($i = 0; $i -lt $content.Length; $i++) {

    if($content[$i] -match '<span data-v-29a6b5d4="" class="details-header__total">') {
        
        $content[$i].Substring($content[$i].IndexOf('<span data-v-29a6b5d4="" class="details-header__total">')+54,$content[$i].LastIndexOf('</span> <div data-v-29a6b5d4') - ($content[$i].IndexOf('<span data-v-29a6b5d4="" class="details-header__total">') + 53)) | Out-file C:\Users\$env:username\Documents\Elpris\pris.txt -force

    }
}

# Variables
$HtmlHeader =
@"
    <!DOCTYPE html>
    <html>
        <head>
            <style type="text/css">
                table{
                    border-collapse: collapse;
                }
                th, td{
                    border: 1px solid black;
                }
                th{
                    font-weight: bold;
                }
            </style>
        </head>
        <body>
            <table>
                <tr>
                    <th>DisplayName</th>
                    <th>DisplayVersion</th>
                    <th>Publisher</th>
                    <th>InstallDate</th>

"@

$softTemplate = '<tr><td>{0}</td><td>{1}</td><td>{2}</td><td>{3}</td></tr>';
$registry = Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
$registry64 =  Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*;
$HtmlFilePath = 'InstalledSoftware.html';

# Get data
$registry + $registry64| ForEach-Object{
       $HtmlHeader += $softTemplate -f $_.DisplayName, $_.DisplayVersion,$_.Publisher, $_.InstallDate
}
# HTML closed tags
$HtmlHeader +=
@"
            </table>
        </body>
    </html>
"@

# Execute
$HtmlHeader > $HtmlFilePath
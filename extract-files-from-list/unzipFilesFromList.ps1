#######################################################################################################################
#                                                   KONFIGURATION
#######################################################################################################################
# Pfad zur Datei mit der Dateiliste
$INPUT_FILE="input.txt"

# Pfad zur ZIP-Datei
$PATH_TO_ZIP = "C:\Users\Sascha Monville\powershell\archiv.zip"

# Ausgabepfad für die zu entpackenden Dateien
$OUTPUT_PATH = 'C:\Users\Sascha Monville\powershell'

# Soll am Ende der Explorer geöffnet werden? ($true oder $false)
$OPEN_EXPLORER=$false

#######################################################################################################################
#                                                   PROGRAMMCODE
#######################################################################################################################
# Dateiliste einlesen
[string[]]$FILE_LIST = Get-Content -Path $INPUT_FILE

# Überprüfen ob Ausgabeverzeichnis exitiert, sonst anlegen
$exists = Test-Path -Path $OUTPUT_PATH
if ($exists -eq $false)
{
  $null = New-Item -Path $OUTPUT_PATH -ItemType Directory -Force
}

# ZIP Funktionen importieren
Add-Type -AssemblyName System.IO.Compression.FileSystem

# ZIP-Datei zum Lesen öffnen
$ZIP = [System.IO.Compression.ZipFile]::OpenRead($PATH_TO_ZIP)

# Funktion um eine gesuchte Datei zu extrahieren
function findAndExtract {
  [CmdletBinding()]
	param(
		[Parameter()]
		[string] $Filter
	)
  try {
    # echo "Such in $OUTPUT_PATH\$FileName nach $Filter"

  $MATCH = $ZIP.Entries |  Where-Object { $_.FullName -like $Filter }
  if ("$MATCH" -ne "$Filter") {
    echo "$Filter nicht gefunden"
  } else {
    echo "$Filter gefunden und entpackt"
  }

  $ZIP.Entries | 
  Where-Object { $_.FullName -like $Filter } |
  ForEach-Object { 
    
      $FileName = $_.Name
      [System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$OUTPUT_PATH\$FileName", $true)
    }
    }
    catch {
      Write-Host $_
    }
    finally {
    }
}

foreach ($item in $FILE_LIST) {
  # echo $item
  findAndExtract -Filter "$item"
}

# ZIP-Datei wieder schliessen
$ZIP.Dispose()

# Explorer im Ausgabeverzeichnis öffnen
if ($OPEN_EXPLORER) {
  explorer $OUTPUT_PATH
}
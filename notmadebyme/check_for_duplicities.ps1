# Script is from User tukan / Skript ist von tukan  (https://stackoverflow.com/users/6059896/tukan)
# Found on / gefunden am 2022-02-11
# The current directory where the script is executed
$path = (Resolve-Path .\).Path

$hash_details = @{}
$duplicities = @{}    

# Remove unique record by size (different size = different hash)
# You can select only those you need with e.g. "*.jpg"
$file_names = Get-ChildItem -path $path -Recurse -Include "*.*" | ? {( ! $_.PSIsContainer)} | Group Length | ? {$_.Count -gt 1} | Select -Expand Group | Select FullName, Length 

# I'm using SHA256 due to SHA1 collisions found
$hash_details =  ForEach ($file in $file_names) {
                             Get-FileHash -Path $file.Fullname -Algorithm SHA256
                         }

# just counter for the Hash table key
$counter = 0
ForEach ($first_file_hash in $hash_details) {
    ForEach ($second_file_hash in $hash_details) {
        If (($first_file_hash.hash -eq $second_file_hash.hash) -and ($first_file_hash.path -ne $second_file_hash.path)) {
                $duplicities.add($counter, $second_file_hash)
                $counter += 1
        }
    }
}

##Throw output with duplicity files 
If ($duplicities.count -gt 0) { 
    #Write-Output $duplicities.values
    Write-Output "Duplicate files found:" $duplicities.values.Path
    $duplicities.values | Out-file -Encoding UTF8 duplicate_log.txt
} Else {
    Write-Output 'No duplicities found'
}

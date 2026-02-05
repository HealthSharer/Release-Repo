
param(
	[Parameter(Mandatory=$true)]
	[string]$credentials,
	[Parameter(Mandatory=$true)]
	[string]$repo,
	[Parameter(Mandatory=$true)]
	[string]$file
)

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "token $credentials")
$releases = "https://api.github.com/repos/$repo/releases"

Write-Host "Determining latest release for $repo, looking for asset $file"
$id = ((Invoke-WebRequest $releases -Headers $headers | ConvertFrom-Json)[0].assets | Where-Object { $_.name -eq $file })[0].id

if (-not $id) {
	Write-Error "Asset $file not found in the latest release of $repo."
	exit 1
}

$download = "https://" + $credentials + ":@api.github.com/repos/$repo/releases/assets/$id"

Write-Host "Downloading latest release asset $file (id: $id)"
$headers["Accept"] = "application/octet-stream"
Invoke-WebRequest -Uri $download -Headers $headers -OutFile $file
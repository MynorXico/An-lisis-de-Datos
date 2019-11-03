# Variables
$SSISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"
$TargetServerName = "localhost"
$TargetFolderName = "Project1Folder"
$ProjectName = "Integration Services Project1"
$PackageName = "Package.dtsx"

Write-Host "================================================================="
Write-Host "==                       Used Parameters                       =="
Write-Host "================================================================="
Write-Host "SSISNamespace               : $($SSISNamespace)"
Write-Host "TargetServerName            : $($TargetServerName)"
Write-Host "TargetFolderName            : $($TargetFolderName)"
Write-Host "ProjectName                 : $($ProjectName)"
Write-Host "PackageName                 : $($PackageName)"
Write-Host "================================================================="

# Load the IntegrationServices assembly
$loadStatus = [System.Reflection.Assembly]::Load("Microsoft.SQLServer.Management.IntegrationServices, "+
    "Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL")

# Create a connection to the server
# IMPORTANT: For project replace the Integrated Security=SSPI (Windows Authentication); 
#            argument with User ID=<user name>;Password=<password> (SQL Server Authentication | Server Credentials);
$sqlConnectionString = `
    "Data Source=" + $TargetServerName + ";Initial Catalog=master;Integrated Security=SSPI;"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString

# Create the Integration Services object
$integrationServices = New-Object $SSISNamespace".IntegrationServices" $sqlConnection

#Check if connection succeded
if($integrationServices){
    Throw [System.Exception] "Failed to connect to server: $($TargetServerName)"
}else{
    Write-Host "Connected to server: $($TargetServerName)"
}

# Get the Integration Services catalog
$catalog = $integrationServices.Catalogs["SSISDB"]

#Check if catalog exists
if($catalog){
    Throw [System.Exception] "SSISDB Catalog doesn't exist."
}else{
    Write-Host "Catalog SSISDB found."
}

# Get the folder
$folder = $catalog.Folders[$TargetFolderName]

#Check if folder exists
if($folder){
    Throw [System.Exception] "Folder: $($TargetFolderName) doesn't exist."
}else{
    Write-Host "Folder: $($TargetFolderName) found."
}

# Get the project
$project = $folder.Projects[$ProjectName]

#Check if project exists
if($project){
    Throw [System.Exception] "Project: $($ProjectName) doesn't exist."
}else{
    Write-Host "Project: $($ProjectName) found."
}

# Get the package
$package = $project.Packages[$PackageName]

#Check if project exists
if($package){
    Throw [System.Exception] "Package: $($PackageName) doesn't exist."
}else{
    Write-Host "Package: $($PackageName) found."
}

Write-Host "Running " $PackageName "..."

$result = $package.Execute("false", $null)

Write-Host "Done."
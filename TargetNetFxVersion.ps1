#check out the comments at the end of the function defition to understand the usage

function CheckManagedTarget($Assembly_Path)
{
	#nothing gets printed if the passed in assembly is not .NET Framework targeted (so it could be 
	#targeted to .NET Core or be a native assembly or some other type of file
	
	#Also, .NET Framework assemblies shipped with the Framework follow a bit different attribute for setting the version, so their name gets printed but not the target version
	
    $Framework_target = ""

        try
        {

            $temp = ([Reflection.Assembly]::LoadFrom($Assembly_Path)).GetCustomAttributes($false)
            $Framework_target = $temp | where { $_.TypeId.Name -eq "TargetFrameworkAttribute" } | Select-Object -ExpandProperty FrameworkDisplayName
            
			Write-Host $Assembly_Path.Split("\")[-1]," -- " $Framework_target
        }
        catch
        {
            #ignore the exception
        }

}

<#---- Uncomment below, if you have to lookup the .NET Framework target version of all the custom managed assembly in a Directory------

#dirPath = "<set dir path here>"
$items = Get-ChildItem -Path $dirPath

write-host "`r`n", "-------------------------------------------"
foreach($item in $items)
{
    CheckManagedTarget($item.FullName)
}

#>

<#------Uncomment below, if you only have to lookup the .NET Framework Target version of a single managed assembly -----------------

$Assembly_Path = <set full path to assembly here>
CheckManagedTarget($Assembly_Path)

#>



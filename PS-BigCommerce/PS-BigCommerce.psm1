# Set PowerShell to require TLS v1.2, otherwise BigCommerce may deny the request
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Get-BCProduct
{
    <#
    .Synopsis
    Short description
    .DESCRIPTION
    Long description
    .EXAMPLE
    Example of how to use this cmdlet
    .EXAMPLE
    Another example of how to use this cmdlet
    #>
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Store URL including your unique store hash, I.E.: https://api.bigcommerce.com/stores/{store_hash}/v3/
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=0)]
        [System.Uri]
        $APIPath,

        # Client-ID as username, Access Token as password.
        [PSCredential]
        $Credential
    )

    Begin
    {
    }
    Process
    {
        Invoke-RestMethod -Uri "$($APIPath)catalog/products" -ContentType "application/json" -Method Get -Headers @{
            "Accept" = "application/json"
            "X-Auth-Client" = $Credential.Username
            "X-Auth-Token" = $Credential.GetNetworkCredential().Password
        }
    }
    End
    {
    }
}
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
        # Product SKU
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true, Position=0)]
        [string[]]
        $SKU,

        # Store URL including your unique store hash, I.E.: https://api.bigcommerce.com/stores/{store_hash}/v3/
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=1)]
        [System.Uri]
        $APIPath,

        # Client-ID as username, Access Token as password.
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=2)]
        [PSCredential]
        $Credential
    )

    Begin
    {
        $URI = "$($APIPath)catalog/products?"

        if ($SKU) {
            $URI += "sku=$($SKU)"
        }
    }
    Process
    {
        return (Invoke-RestMethod -Uri $URI -ContentType "application/json" -Method Get -Headers @{
            "Accept" = "application/json"
            "X-Auth-Client" = $Credential.Username
            "X-Auth-Token" = $Credential.GetNetworkCredential().Password
        }).data
    }
    End
    {
    }
}

function Update-BCProduct
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
        # Product SKU
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true, Position=0)]
        [string
        $ID,

        # Store URL including your unique store hash, I.E.: https://api.bigcommerce.com/stores/{store_hash}/v3/
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=1)]
        [System.Uri]
        $APIPath,

        # Client-ID as username, Access Token as password.
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=2)]
        [PSCredential]
        $Credential,

        [string]
        $Name,

        [string]
        $SKU,

        [float]
        $Weight,

        [float]
        $Width,

        [float]
        $Height,

        [float]
        $Depth
    )

    Begin
    {
        $URI = "$($APIPath)catalog/products/$($ID)"
    }
    Process
    {
        $body = @{}

        if ($Name) {$body.Add(Name, $Name)}
        if ($SKU) {$body.Add(SKU, $SKU)}
        if ($Weight) {$body.Add(Weight, $Weight)}
        if ($Width) {$body.Add(Width, $Width)}
        if ($Height) {$body.Add(Height, $Height)}
        if ($Depth) {$body.Add(Depth, $Depth)}

        Invoke-RestMethod -Uri $URI -ContentType "application/json" -Method Put -Headers @{
            "Accept" = "application/json"
            "X-Auth-Client" = $Credential.Username
            "X-Auth-Token" = $Credential.GetNetworkCredential().Password
        }
    }
    End
    {
    }
}
function Edit-AleroGroup {
    [CmdletBinding(
        SupportsShouldProcess, 
        ConfirmImpact='Low'
    )]
    [OutputType([string])]
    param (
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName,
            HelpMessage='Token to authenticate to Alero.'
        )]
        [System.Security.SecureString]$Authn,

        [Parameter(
            Mandatory,
            HelpMessage='The unique ID of the AleroLDAP group.'
        )]
        [string]$GroupId,

        [Parameter(
            Mandatory,
            HelpMessage='The description of the AleroLDAP group'
        )]
        [string]$Description
    )
    
    begin {
        
    }
    
    process {
        $restBody = @{
            'Uri' = "https://api.alero.io/v2-edge/groups/$GroupId"
            'Body' = $Description
            'ContentType' = 'application/json'
            'Method' = 'Put'
            'Authentication' = 'Bearer'
            'Token' = $Authn
        }
        if ($PSCmdlet.ShouldProcess("GroupId: $GroupId", "Change description")) {
            $result = Invoke-RestMethod @restBody            
        }
    }
    
    end {
        Write-Output -InputObject $result
    }
}
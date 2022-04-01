class СheckingResult {
    [string]$What 
    [datetime]$When
    [bool]$Result

    СheckingResult([string]$Path){
        $this.What = $Path
        $this.When = [datetime]::Now.ToString('yyyy-MM-dd hh:mm:ss')
        $this.Result = Test-Path $Path
    }

    СheckingResult(){}
}

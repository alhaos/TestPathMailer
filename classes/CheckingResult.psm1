class CheckingResult {
    [string]$What 
    [datetime]$When
    [bool]$Result

    CheckingResult([string]$Path){
        $this.What = $Path
        $this.When = [datetime]::Now.ToString('yyyy-MM-dd hh:mm:ss')
        $this.Result = Test-Path $Path
    }

    CheckingResult(){}
}

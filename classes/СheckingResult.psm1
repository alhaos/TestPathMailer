class СheckingResult {
    [string]$What 
    [string]$When
    [bool]$Result

    СheckingResult([string]$Path){
        $this.What = $Path
        $this.When = [datetime]::Now
        $this.Result = Test-Path $Path
    }
}
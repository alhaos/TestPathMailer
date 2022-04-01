using module .\CheckingResult.psm1
using namespace System.Data.SQLite

Set-StrictMode -Version 'latest'

class DatabaseManager {

    $Conn = [SQLiteConnection]::new("Data Source=.\lib\database.db")

    DatabaseManager () {
        $this.Conn.Open()
        try {
            $Comm = $this.Conn.CreateCommand()
            $Comm.CommandText = "delete from CHECKING_RESULTS where DT < date('now','-90 day')"
            #$Comm.ExecuteNonQuery()
        }
        finally {
            $this.Conn.Close()
        }
    }

    Push ([CheckingResult]$CheckingResult) {

        $this.Conn.Open()
        try {
            $Comm = $this.Conn.CreateCommand()
            $Comm.CommandText = 'INSERT INTO CHECKING_RESULTS (PATH, DT, RESULT) VALUES (@PATH, @DT, @RESULT)'
            $Comm.Parameters.AddWithValue('@PATH', $CheckingResult.What)
            $Comm.Parameters.AddWithValue('@DT', $CheckingResult.When.ToString('yyyy-MM-dd hh:mm:ss'))
            $Comm.Parameters.AddWithValue('@RESULT', $CheckingResult.Result)
            $Comm.ExecuteNonQuery()
        }
        finally {
            $this.Conn.Close()
        }
    }

    [CheckingResult] GetLast ([string]$Path){

        $CheckingResult = [CheckingResult]::new()
        
        $this.Conn.Open()
        
        try {
            $Comm = $this.Conn.CreateCommand()
            $Comm.CommandText = 'select PATH, DT, RESULT from CHECKING_RESULTS where PATH = @PATH order by dt desc limit 1'
            $Comm.Parameters.AddWithValue('@PATH', $Path)
            $DataReader = $Comm.ExecuteReader()
            while ($DataReader.Read()){
                $CheckingResult.What = $DataReader['PATH']
                $CheckingResult.When = $DataReader.GetDatetime(1)
                $CheckingResult.Result = $DataReader['RESULT'] -eq 1 ? $true : $false
            }
        }
        finally {
            $this.Conn.Close()
        }

        return $CheckingResult
    }
}
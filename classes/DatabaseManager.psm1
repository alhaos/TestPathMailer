using module .\СheckingResult.psm1
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

    Push ([СheckingResult]$СheckingResult) {

        $this.Conn.Open()
        try {
            $Comm = $this.Conn.CreateCommand()
            $Comm.CommandText = 'INSERT INTO CHECKING_RESULTS (PATH, DT, RESULT) VALUES (@PATH, @DT, @RESULT)'
            $Comm.Parameters.AddWithValue('@PATH', $СheckingResult.What)
            $Comm.Parameters.AddWithValue('@DT', $СheckingResult.When)
            $Comm.Parameters.AddWithValue('@RESULT', $СheckingResult.Result)
            $Comm.ExecuteNonQuery()
        }
        finally {
            $this.Conn.Close()
        }
    }

    [СheckingResult] GetLast ([string]$Path){

        $СheckingResult = [СheckingResult]::new()
        
        $this.Conn.Open()
        
        try {
            $Comm = $this.Conn.CreateCommand()
            $Comm.CommandText = 'select PATH, DT, RESULT from CHECKING_RESULTS where PATH = @PATH order by dt desc limit 1'
            $Comm.Parameters.AddWithValue('@PATH', $Path)
            $DataReader = $Comm.ExecuteReader()
            while ($DataReader.Read()){
                $СheckingResult.What = $DataReader['PATH']
                $СheckingResult.When = $DataReader['DT']
                $СheckingResult.Result = $DataReader['RESULT'] -eq 1 ? $true : $false
            }
        }
        finally {
            $this.Conn.Close()
        }

        return $СheckingResult
    }
}
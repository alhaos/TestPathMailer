<# using assembly ..\lib\System.Data.SQLite.dll 

using namespace System.Data.Sqlite
using namespace System.Data

class DatabaseManager {

    static GetLastValue () {
        $datatable = [DataTable]::new()

        $ErrorActionPreference = 'stop'
        $conn = [SQLiteConnection]::new("Data Source=C:\repositories\pwsh\sqlLite\lib\database.db")
        $conn.Open()
        $comm = $conn.CreateCommand()

        $comm.CommandText = 'select FILENAME, QSS_UPDATE_DATETIME from FILE'
        $datatable.Load($comm.ExecuteReader())
        $conn.Close()

        $newRow = $datatable.NewRow()

        $newRow['Filename'] = 'changelog'
        $newRow['qss_update_datetime'] = [datetime]::Now

        $datatable.Rows.Add($newRow)

        for ($i = 0; $i -lt $datatable.Rows.Count; $i++) {
    
        
        }

        $datatable.Rows[0].Delete()
        $datatable
        $datatable.AcceptChanges()

        $datatable
    }
}

 #>
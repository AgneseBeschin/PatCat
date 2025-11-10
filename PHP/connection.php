<?php
class Database
{
    private const HOST      = "127.0.0.1";
    private const PASSWORD  = "root";
    private const USERNAME  = "root";
    private const DB_NAME   = "progettotec";

    private $connection;

    // initiate db connection
    public function connect()
    {
        $this->connection = mysqli_connect(Database::HOST, Database::USERNAME, Database::PASSWORD, Database::DB_NAME);
        if(mysqli_connect_errno())
        {
            echo "Errore di connessione : " . mysqli_connect_error();
            return false;
        }
        return true;
    }

    // change_record function is used for : update, delete, insert
    public function change_record($query)
    {
        $response = mysqli_query($this->connection,$query);

        if(!$response)
        {
            echo "Change record error : " . mysqli_error($this->connection);
            return false;
        }

        $response->free();
        return $arr;
    }

    public function delete($query)
    {
        return $this->change_record($query);
    }

    public function insert($query)
    {
        return $this->change_record($query);
    }

    public function select($query)
    {
        $response = mysqli_query($this->connection,$query);

        if(!$response)
        {
            echo "Error select query : " . mysqli_error($this->connection);
            return false;
        }
        
        // results
        $arr = array();

        while($row = mysqli_fetch_assoc($response))
        {
            array_push($arr,$row);
        }

        $response->free();
        return $arr;
    }

    public function close()
    {
        mysqli_close($this->connection);
    }
}
?>
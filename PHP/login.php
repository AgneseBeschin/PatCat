<?php  
    session_start();
    require_once("connection.php");
    
    if(isset($_SESSION["user"]))
    {
        header('Location: area_personale.php');
        exit();
    }

    //Controllo dati lato server + costruzione error message

    /*$db = new Database();
    if($db->connect())
    {
        $hash  = hash("sha256", $_POST["password"], false); 
        $email = $_POST["email"];

        $query = "SELECT Username,Stato,Livello,Punti FROM Utente WHERE Email='$email' AND Pass='$hash'";

        $r = $db->select($query);
        if(count($r) > 0)
        {
            $x = array
            (
                'Username' =>  $r[0]["Username"],
                'Stato' =>  $r[0]["Stato"],
                'Livello' =>  $r[0]["Livello"],
                'Punti' =>  $r[0]["Punti"]
            );

            $_SESSION["user"] = $x;
            header('Location: area_personale.php');
        }

        $db->close();
        exit();
    }*/


    // Restituisce area_personale in assenza di controlli lato JS, ancora da fare.
    header('Location: area_personale.php');
?>
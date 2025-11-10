<?php
    session_start();
    require_once("buildpage.php");
    $header = file_get_contents("..\Views\Headers\area_personale.html");


    $crumbs = '
        <a href="../index.php">Home</a> >> Area personale
    ';

    $content = 
    '
        <div>
            <form action="login.php" method="post" id="form_login">
                <label id="lb_email" for="lb_email">E-mail</label>
                <input id="lb_email" name="email" type="text" placeholder="Inserisci la tua e-mail" aria-labelledby="lb_email">
                <span class="no_error" id="error_email"></span>

                <label id="lb_psw" for="lb_psw">Password</label>
                <input id="lb_psw" type="password" name="password" placeholder="Inserisci la tua password" aria-labelledby="lb_psw">
                <span class="no_error" id="error_psw"></span>

                <input type="submit" value="Login">
            </form>
            <p> Nuovo utente? <a href="registrati.php">Registrati</a> </p>
        </div>
    
    ';

    if(isset($_SESSION["user"])) // change to control panel if a user is logged in.
    {
        // check if user is normal or admin
        //if($_SESSION["type"] == "Admin" || $_SESSION["type"] == "User")

        $content = 
        '     
        <div class="panel_content">
            <ul>
                <li>
                    <a href="" id="">I miei post</a>         
                </li>

                <li>
                    <a href="" id="">Aggiungi post</a>         
                </li>

                <li>
                    <a href="" id="">Modifica Password</a>         
                </li>

                <li>
                    <a href="" id="">Cancella account</a>         
                </li>

                <li>
                    <a href="logout.php" lang="en" id="logout">logout</a>         
                </li>

                <li>
                    <a href="" id="">LL</a>         
                </li>

            </ul>
        </div>
        ';
    }
    
    echo PageBuilder($crumbs,$content,$header);
?>
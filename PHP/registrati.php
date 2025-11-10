<?php 
    require_once("buildpage.php");
    
    $root = $_SERVER["DOCUMENT_ROOT"];

    $header = file_get_contents($root."\Views\Headers\\registrati.html");

    $crumbs = '
        <a href="../index.php">Home</a> >> Registrazione account
    ';

    $content = 
    '
        <div>
            <form action="#" method="post" id="form_registrazione">
                <label id="lb_user" for="lb_user">Username</label>
                <input id="lb_user" name="username" type="text" placeholder="Inserisci il tuo username" aria-labelledby="lb_user">
                <span class="no_error" id="error_username"></span>

                <label id="lb_email" for="lb_email">E-mail</label>
                <input id="lb_email" name="email" type="text" placeholder="Inserisci la tua e-mail" aria-labelledby="lb_email">
                <span class="no_error" id="error_email"></span>

                <label id="lb_psw" for="lb_psw">Password</label>
                <input id="lb_psw" type="password" name="password" placeholder="Inserisci la tua password" aria-labelledby="lb_psw">
                <span class="no_error" id="error_psw"></span>

                <input type="submit" value="Registrami" name="submit">
            </form>
            <p> Hai già un account? <a href="login.php">Login</a> </p>
        </div>    
    ';
    
    echo PageBuilder($crumbs,$content,$header);
?>
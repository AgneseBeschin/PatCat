<?php 
    require_once("buildpage.php");
    $root = $_SERVER["DOCUMENT_ROOT"];
    $header = file_get_contents($root."\Views\Headers\contacts.html");
     
    $crumbs = '
        <span>Contattaci</span>
    ';

    $content = 
    '
        <div id="contact_dform">
            <form id="form_contattaci">
                <label id="lb_nome" for="lb_name">Nome</label>
                <input id="lb_name" type="text" placeholder="Inserisci il tuo nome" aria-labelledby="lb_nome">
                <span class="no_error" id="error_name"></span>

                <label id="lb_cnome" for="lb_cname">Cognome</label>
                <input id="lb_cname" type="text" placeholder="Inserisci il tuo cognome" aria-labelledby="lb_cnome">
                <span class="no_error" id="error_cname"></span>

                <label id="lb_email" for="lb_email">E-mail</label>
                <input id="lb_email" type="text" placeholder="Inserisci la tua e-mail" aria-labelledby="lb_email">
                <span class="no_error" id="error_email"></span>

                <label id="lb_msg" for="lb_msg">Messaggio</label>
                <textarea id="lb_msg" placeholder="Salve, vorrei richiedere informazioni riguardo a ..." aria-labelledby="lb_msg" maxlength="1000"></textarea>
                <span class="no_error" id="error_msg"></span>

                <input type="button" value="Invia messaggio" onclick="email_send()">
            </form>
        </div>
    
    ';

    echo PageBuilder($crumbs,$content,$header);
?>
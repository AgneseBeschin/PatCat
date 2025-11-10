<?php
    require_once("buildpage.php");

    $header = file_get_contents("..\Views\Headers\chisiamo.html");

    $crumbs = '
        Chi siamo
    ';

    $content = 
    '
        <div>
            PERSONE
        </div>
    
    ';

    echo PageBuilder($crumbs,$content,$header);
?>
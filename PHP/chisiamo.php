<?php
    require_once("buildpage.php");
    $root = $_SERVER["DOCUMENT_ROOT"];
    $header = file_get_contents($root."\Views\Headers\chisiamo.html");

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
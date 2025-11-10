<?php
    require_once("PHP\buildpage.php");

    $header = file_get_contents("Views\Headers\index.html");

    $crumbs = '
        <span lang="en">Home</span>
    ';

    $content = 
    '
        <div>
            <p>TESTO 1</p>
        </div>

        <div>
            <p>TESTO 2</p>
        </div>
    ';

    echo PageBuilder($crumbs,$content,$header);
?>
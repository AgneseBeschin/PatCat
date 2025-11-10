<?php
function PageBuilder($crumbs,$content,$header)
{
    $root = $_SERVER["DOCUMENT_ROOT"];

    $page = file_get_contents($root."\Views\main_layout.html");
    $footer = file_get_contents($root."\Views\\footer.html");

    
    $page = str_replace("{{header}}",$header,$page);
    $page = str_replace("{{footer}}",$footer,$page);
    $page = str_replace("{{main_content}}",$content,$page);
    $page = str_replace("{{crumb}}",$crumbs,$page);

    $page = str_replace("{{css}}","/styles/style.css",$page);
    $page = str_replace("{{js}}","/JS/script.js",$page);
    return $page;
}
?>
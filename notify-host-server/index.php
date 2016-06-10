<?php

$message = isset($_GET['msg']) ? $_GET['msg'] : null;
$prompt = isset($_GET['prompt']) ? $_GET['prompt'] : 'VM Says:';
$type = isset($_GET['type']) ? $_GET['type'] : 'info';

if ($message) {
    $cleanMessage = escapeshellarg($message);
    $cleanPrompt = escapeshellarg($prompt);
    $cleanType = escapeshellarg($type);

    `notifu /m $cleanMessage /p $cleanPrompt /t $cleanType`;
}

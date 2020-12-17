<?php
header('Access-Control-Allow-Origin: ' . $_SERVER['SERVER_NAME']);

// Replace with your own subscription key and service region (e.g., "westus").
$subscriptionKey = '197c1a7bc63c41a1931328e15925d597';
$region = 'southeastasia';

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'https://' . $region . '.api.cognitive.microsoft.com/sts/v1.0/issueToken');
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, '{}');
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'Ocp-Apim-Subscription-Key: ' . $subscriptionKey)); 
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
echo curl_exec($ch);
?>
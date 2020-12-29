<?php
declare(strict_types=1);

$cfg['blowfish_secret'] = '';

$i = 1;

$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['host'] = 'mysql';
$cfg['Servers'][$i]['port'] = "3306";
$cfg['Servers'][$i]['user'] = "wordpress";
$cfg['Servers'][$i]['password'] = "password";
$cfg['Servers'][$i]['compress'] = false;

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
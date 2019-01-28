<?php

    require_once(dirname(__FILE__) . '/DbConnect.class.php');
    require_once(dirname(__FILE__) . '/DnsValidation.class.php');

    $connection = new DbConnect();
    // $connection->updateAnyColumn();
    // return 0;

    $domains = $connection->getDomains();
    echo "$ ===== domains BEFOR" . PHP_EOL; var_dump($domains);

    $dnsValidation = new DnsValidation($domains);
    $domains = $dnsValidation->run();
    switch ($domains) {
        case -1:
            echo "There was a problem connecting to marker domains DNSs." . PHP_EOL;
            echo "The validation process has been canceled." . PHP_EOL;
            break;
        case 0:
            echo "No domain has changed its status." . PHP_EOL;
            break;

        default:
            if ($connection->updateDomains($domains))
                echo "Domains updated." . PHP_EOL;
            else
                echo "There was a problem with an update." . PHP_EOL;
            echo "$ ===== domains AFTER" . PHP_EOL; var_dump($domains);
            break;
    }

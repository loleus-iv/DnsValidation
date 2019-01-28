<?php

class DbConnect
{
    private $connection = false;

    public function __construct()
    {
        require('config.inc.php');
        $dsn = 'pgsql:host=' . DBHOST . ';port=' . PORT . ';dbname=' . DBNAME . ';';
        try {
            $this->connection = new PDO($dsn, DBUSER, DBPASS, [
                // Set PDO to fire PDOExceptions on errors
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            ]);
        } catch (PDOException $e) {
            echo "Some sort of error has occurred! Here are the details:" . PHP_EOL;
            echo $e->getMessage();
        }
    }

    public function getDomains()
    {
        if ($this->connection) {
            $sql = 'SELECT *
                    FROM dns_domeny';
            return $this->connection->query($sql)->fetchAll(PDO::FETCH_ASSOC);
        }
        else return false;
    }

    public function updateDomains($records)
    {
        if ($this->connection) {
            $sql = "UPDATE dns_domeny
                    SET __soa_not_valid = :__soa_not_valid
                    WHERE dnsdid = :dnsdid";
            if ($sth = $this->connection->prepare($sql)) {
                $sth->bindParam(':dnsdid', $dnsdid, PDO::PARAM_INT);
                $sth->bindParam(':__soa_not_valid', $soa_not_valid, PDO::PARAM_STR | PDO::PARAM_NULL);

                foreach ($records as $record) {
                    $dnsdid = $record['dnsdid'];
                    $soa_not_valid = $record['__soa_not_valid'];
                    if (!$sth->execute()) echo "There was a problem with UPDATE record with 'dnsdid' = $dnsdid" . PHP_EOL;
                }
                return true;
            }
        }
        return false;
    }

    public function updateAnyColumn(){
    /****
        * funkcja na potrzeby testów
        */
        $records = $this->getDomains();

        if ($this->connection) {
            $sql = "UPDATE dns_domeny
                    SET __soa_not_valid = :__soa_not_valid
                    WHERE dnsdid = :dnsdid";
            $sth = $this->connection->prepare($sql);
            $sth->bindParam(':dnsdid', $dnsdid, PDO::PARAM_INT);
            $sth->bindParam(':__soa_not_valid', $soa_not_valid, PDO::PARAM_STR | PDO::PARAM_NULL);

            foreach ($records as $record) {
                $dnsdid = $record['dnsdid'];
                $soa_not_valid = null;

                if (!$sth->execute()) echo "There was a problem with UPDATE record did = $dnsdid" . PHP_EOL;
            }
        }
        else return false;
    }

} // end class DbConnect

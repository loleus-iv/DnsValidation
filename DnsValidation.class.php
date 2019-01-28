<?php

class DnsValidation
{
    const VALID_DNS = 'ns1.example.pl';
    private $markerDomains = array(
        'example.pl',
        'example2.pl',
    );
    private $domains;

    public function __construct($domains)
    {
        $this->domains = $domains;
    }

    private function checkDns()
    {
        foreach ($this->markerDomains as $domain)
            if (!dns_check_record($domain)) return false;
        return true;
    }

    public function run()
    {
    /****
        * Zwraca:
        * -1 gdy DNS przynajmniej jednej domeny markerowej nie odpowiada
        * 0 gdy brak rekordów do aktualizacji
        * w pozostałych przypadkach tablicę domen do aktualizacji bazy danych
        */
        $results = array();
        if ($this->checkDns() === false) return -1;

        foreach ($this->domains as $key => $domain) {
            $soaRecord = current(dns_get_record($domain['nazwa'],DNS_SOA));
            echo 'DEBUG $soaRecord at line ' . __LINE__ . PHP_EOL; var_dump($soaRecord);

            if ($soaRecord['mname'] == self::VALID_DNS) {
                if ($domain['__soa_not_valid'] != null) {
                    $domain['__soa_not_valid'] = null;
                    $results[$key] = $domain;
                }
            }
            elseif ($domain['__soa_not_valid'] == null) {
                $domain['__soa_not_valid'] = date('Y-m-d H:i:s', time());
                $results[$key] = $domain;
            }
        }
        if (count($results) > 0) return $results;
        else return 0;
    }
}

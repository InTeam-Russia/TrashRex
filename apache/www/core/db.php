<?php

namespace core;
use \core\singleton;

class db
{
    use singleton;
    public \PDO $pdo;
    public function __construct() {
        $conStr = sprintf(
            "pgsql:host=%s;port=%d;dbname=%s;user=%s;password=%s",
            '10.1.0.100',
            '5432',
            'logistic',
            'postgres',
            'postgres'
        );

        $this->pdo = new \PDO($conStr);
        $this->pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
    }

    public function bindFilters(string $sql, array $filters, array $filtersColumns, array $binds, bool $pagination, int $page = 1, int $perPage = 25) : \PDOStatement {
        if(!empty($filters)) {
            $sql .= ' WHERE';
        }
        $filtersCount = count($filters);
        foreach ($filtersColumns as $filter => $column) {
            if(isset($filters[$filter])) {
                $sql .= $column;
                --$filtersCount;
                if($filtersCount > 0) {
                    $sql .= ' AND';
                } else {
                    break;
                }
            }
        }
        if($pagination) {
            $start = ($page - 1) * $perPage;
            $sql .= ' LIMIT ' . $perPage . ' OFFSET ' . $start;
        }
        $sth = $this->pdo->prepare($sql);
        if($sth === false) {
            throw new \Exception("Не могу скомпилировать поисковый запрос");
        }
        foreach($binds as $bind => $type) {
            if(isset($filters[$bind]) && !is_null($filters[$bind])) {
                if($type == 'STR_FRAGMENT') {
                    $sth->bindValue(':name', '%' . str_replace('%', '\%', $filters['name']) . '%');
                } else {
                    $sth->bindValue(':' . $bind, $filters[$bind], $type);
                }
            }
        }
        if(!$sth->execute()) {
            throw new \Exception("Не могу выполнить поиск");
        }
        return $sth;
    }
}
# Class: openfire
#
# This module manages openfire
#
# Requires:
#   class apache
#   class mysql::server
#
# Notes:
# openfire_mysql.sql taken from rpm in /opt/openfire/resources/database/
#
# Sample Usage: include openfire
#
class openfire {

    include apache
    include mysql::server

    $openfireDB = "openfire"

    package { "openfire": }

    # setup database 
    mysql::do {
        "openfire_db_create":
            source  => "puppet:///modules/openfire/openfire.sql";
        "openfire_db_setup":
            require => Mysql::Do["openfire_db_create"],
            database => "$openfireDB",
            source  => "puppet:///modules/openfire/openfire_mysql.sql";
    } # mysql::do

    file { "/var/log/openfire":
        require => Package["openfire"],
        mode    => 700,
        ensure  => link,
        target  => "/opt/openfire/logs",
    } # file

    service { "openfire":
        enable  => true,
        require => Package["openfire"], 
        ensure => running,
    } # service
} # class openfire

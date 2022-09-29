#!/usr/bin/expect

set timeout 5

set host [lindex $argv 0]
set port [lindex $argv 1]
set login [lindex $argv 2]
set password [lindex $argv 3]

spawn telnet $host $port

expect "login: "
send "$login\r"

expect "password: "
send "$password\r"

interact

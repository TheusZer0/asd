#!/usr/bin/expect -f


        set timeout 20
        set IPaddress [lindex $argv 0]
        set Username "extra"
        set Password "GGLextra10"
        set enablepassword "NETSistemas10"
        set Directory /home/gaspar/logs


        log_file -a $Directory/session_$IPaddress.log
        send_log "### /START-SSH-SESSION/ IP: $IPaddress @ [exec date] ###\r"
        
        set fd [open $Directory/error.txt "a"]


        spawn telnet$IPaddress

        expect "*username: "
        send "$Username\r"
        expect "*assword: "
        send "$Password\r"
        expect {
            -re ">" {}
            timeout {puts $fd $IPaddress; close $fd; exit 1}
        }
        send "en\r"
        expect "*assword: "
        send "$enablepassword\r"
        expect {
            -re "#" {}
            timeout {puts $fd $IPaddress; close $fd; exit 1}
        }
        send "conf t\r"
        expect "(config)#"
        send "no ip route 0.0.0.0 0.0.0.0 10.227.224.1\r"
        expect "(config)#"
        send "ip route 0.0.0.0 0.0.0.0 10.227.224.3\r"
        expect "(config)#"
        send "end\r"
        expect "#"
        send "wr mem\r"
        expect "#"
        send "disable\r"
        expect ">"
        send "exit\r"
        sleep 1
        send_log "\r### /END-SSH-SESSION/ IP: $IPaddress @ [exec date] ###\r"
        
        close $fd
exit

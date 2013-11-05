#!/usr/bin/expect
proc addfield {filename fieldname} {
    puts "Adding field $fieldname to $filename"
    exec perl -i -p -e "s/^\}\$/String $fieldname\\n\}\\n/" $filename 
}

exec rm -rf dcreloadingapp
spawn bash --norc --noprofile
expect "$ "
send "grails create-app dcreloadingapp\r"
expect "$ "
send "cd dcreloadingapp\r"
expect "$ "
send "grails\r"
expect "grails>"
send "run-app\r"
expect "grails>"
sleep 10
send "create-domain-class A\r"
sleep 1
expect "grails>"
send "create-scaffold-controller dcreloadingapp.A\r"
sleep 1
expect "grails>"
send "\r"
sleep 10
addfield "dcreloadingapp/grails-app/domain/dcreloadingapp/A.groovy" "name"
sleep 5
for {set i 0} {$i < 10} {incr i} {
    addfield "dcreloadingapp/grails-app/domain/dcreloadingapp/A.groovy" "field$i"    
    sleep 5
}
send "exit\r"
expect "$ "
exit

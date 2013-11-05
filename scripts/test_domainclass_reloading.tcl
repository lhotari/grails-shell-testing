#!/usr/bin/expect
set timeout 60

proc addfield {filename fieldname} {
    puts "Adding field $fieldname to $filename"
    exec perl -i -p -e "s/^\}\$/String $fieldname\\n\}\\n/" $filename 
}

exec rm -rf dcreloadingapp
spawn bash --norc --noprofile
expect "$ "
send "grails -plain-output create-app dcreloadingapp\r"
expect "$ "
send "cd dcreloadingapp\r"
expect "$ "
send "grails -plain-output\r"
expect "grails>"
send "run-app\r"
expect "grails>"
#sleep 10
send "create-domain-class A\r"
expect "grails>"
send "create-scaffold-controller dcreloadingapp.A\r"
expect "grails>"
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

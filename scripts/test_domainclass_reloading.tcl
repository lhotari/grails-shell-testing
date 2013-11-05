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
send "create-domain-class A\r"
expect "grails>"
send "create-scaffold-controller dcreloadingapp.A\r"
expect "grails>"
set timeout 10
expect "\n"
addfield "dcreloadingapp/grails-app/domain/dcreloadingapp/A.groovy" "name"
expect "\n"
for {set i 0} {$i < 10} {incr i} {
    addfield "dcreloadingapp/grails-app/domain/dcreloadingapp/A.groovy" "field$i"    
    expect "\n"
}
send "exit\r"
expect "$ "
exit

#!/usr/bin/expect
set timeout 60

proc updateplugin {filename pluginname version} {
    exec perl -i -p -e "s/(\[\'\"\]:$pluginname:)\[^'\"\]+(\[\'\"\])/\$\{1\}$version\$\{2\}/" $filename
}
proc addfield {filename fieldname} {
    puts "Adding field $fieldname to $filename"
    exec perl -i -p -e "s/^\}\$/String $fieldname\\n\}\\n/" $filename 
}

exec rm -rf dcreloadingapp
spawn bash --norc --noprofile
expect "$ "
send "grails -plain-output create-app dcreloadingapp\r"
expect "$ "
updateplugin "dcreloadingapp/grails-app/conf/BuildConfig.groovy" "hibernate" {3.6.10.3-SNAPSHOT}
send "cd dcreloadingapp\r"
expect "$ "
send "grails $argv -plain-output\r"
expect "grails>"
send "run-app\r"
expect "grails>"
sleep 15
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

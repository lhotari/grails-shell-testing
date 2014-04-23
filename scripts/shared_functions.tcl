proc updateplugin {filename pluginname version} {
    exec perl -i -p -e "s/(\[\'\"\]:$pluginname:)\[^'\"\]+(\[\'\"\])/\$\{1\}$version\$\{2\}/" $filename
}

proc addfield {filename fieldname} {
    while { [file exists $filename] != 1} {
        puts "Waiting for $filename to be created"  
        after 1000
    }
    puts "Adding field $fieldname to $filename"
    exec perl -i -p -e "s/^\}\$/String $fieldname\\n\}\\n/" $filename 
}
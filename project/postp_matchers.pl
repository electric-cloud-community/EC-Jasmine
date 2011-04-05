use ElectricCommander;

push(
    @::gMatchers,
    {
        id      => "TaskError",
        pattern => q{Don\'t know how to build task(.+)},
        action  => q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "An error occurred: Could not build task $1 ";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
    },
    {
        id      => "FileError",
        pattern => q{(.+)\(LoadError\)},
        action  => q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "An error occurred: $1 ";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
    },
    {
        id      => "FileNotFound",
        pattern => q{(.+)\(looking for: (.+)\)},
        action  => q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "An error occurred: $1 '$2'";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
    },
    {
        id      => "LoadError",
        pattern => q{no such file to load (.+)},
        action  => q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "An error occurred: no such file to load $1";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
    },
    {
        id      => "errorDesc",
        pattern => q{(.+)for main\:Object},
        action  => q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "An error occurred: $1 ";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
    },
    {
        id      => "DirectoryPath",
        pattern => q{\(in (.+)\)},
        action  => q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "Rake executed in path : $1";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
    },
);


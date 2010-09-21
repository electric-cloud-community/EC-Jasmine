use warnings;
use strict; 
$|=1;

use ElectricCommander;

use constant SELENIUM_MODE => 'selenium';
use constant DEFAULT_MODE => 'default';

$::gRakefile = "$[rakefile]";
$::gType = "$[type]";
$::gAdditionalCommands = q($[additionalcommands]);
$::gWorkingDir = "$[workingdir]";

########################################################################
# main - contains the whole process to be done by the plugin, it builds 
#        the command line, sets the properties and the working directory
#
# Arguments:
#   -none
#
# Returns:
#   -nothing
#
########################################################################
sub main() {
    
    # create args array
    my @args = ();
    
    #properties' map
    my %props;
    
    #executable to use
    my $executable = 'rake';
    
    #insert program to invoke
    push(@args, $executable);
    
    if($::gAdditionalCommands  && $::gAdditionalCommands  ne '') {
        foreach my $command (split(' +', $::gAdditionalCommands)) {
	    	push(@args, $command);
		}
    }

    if($::gRakefile && $::gRakefile ne '') {
        push(@args, '-f "' . $::gRakefile . '"');
    }

    if($::gType && $::gType ne '') {
     
        if($::gType eq DEFAULT_MODE){
            push(@args, 'jasmine');
        }elsif($::gType eq SELENIUM_MODE){
            push(@args, 'jasmine:ci');
        }
     
    }else{
        push(@args, 'jasmine');
    }

    #register a report link if necessary
    #registerReports();

    #generate the command to execute in console
    $props{'commandLine'} = createCommandLine(\@args);
    $props{'workingdir'} = $::gWorkingDir;
    
    setProperties(\%props);
    
}

########################################################################
# createCommandLine - creates the command line for the invocation
# of the program to be executed.
#
# Arguments:
#   -arr: array containing the command name and the arguments entered by 
#         the user in the UI
#
# Returns:
#   -the command line to be executed by the plugin
#
########################################################################
sub createCommandLine($) {

  	my ($arr) = @_;

    my $commandName = @$arr[0];

    my $command = $commandName;

    shift(@$arr);

	foreach my $elem (@$arr) {
        $command .= " $elem";
    }

    return $command;
    
}

########################################################################
# setProperties - set a group of properties into the Electric Commander
#
# Arguments:
#   -propHash: hash containing the ID and the value of the properties 
#              to be written into the Electric Commander
#
# Returns:
#   -nothing
#
########################################################################
sub setProperties($) {

    my ($propHash) = @_;

    # get an EC object
    my $ec = new ElectricCommander();
    $ec->abortOnError(0);

    foreach my $key (keys % $propHash) {
        my $val = $propHash->{$key};
        $ec->setProperty("/myCall/$key", $val);
    }
}

########################################################################
# registerReports - creates a link for registering the generated report
# in the job step detail
#
# Arguments:
#   -none
#
# Returns:
#   -nothing
#
########################################################################
sub registerReports(){
 
    # get an EC object
    my $ec = new ElectricCommander();
    $ec->abortOnError(0);
 
    $ec->setProperty("/myJob/artifactsDirectory", "");
    
    my $fileName = '';
    my $fileIndex = rindex($::gResultFile, '/');
    
    if($fileIndex == -1){
     
       $fileIndex = (rindex($::gResultFile, '\\'));
     
    }
    
    if($fileIndex == -1){
     
       $fileName = $::gResultFile;
     
    }else{
     
       $fileName = substr($::gResultFile, $fileIndex+1, length($::gResultFile)-$fileIndex);
     
    }
    
    $ec->setProperty("/myJob/report-urls/Jasmine Test Results", 
          "jobSteps/$[jobStepId]/" . $fileName);

}

main();


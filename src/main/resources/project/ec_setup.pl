my %runJasmine = (
    label       => "Jasmine - Run Jasmine",
    procedure   => "runJasmine",
    description => "Runs Jasmine",
    category    => "Test"
);

$batch->deleteProperty("/server/ec_customEditors/pickerStep/Jasmine - runJasmine");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/Jasmine - Run Jasmine");

@::createStepPickerSteps = (\%runJasmine);
if ($promoteAction eq 'promote') {

    # The plugin is being promoted, create a property reference 
    #in the server's property sheet
    $batch->setProperty('/server/ec_customEditors/pluginStep/jasmine', {
        description => "Integrates Jasmine test framework into Electric Commander",
        value => '$[/plugins/@PLUGIN_KEY@-@PLUGIN_VERSION@/project/jasmine_forms/wizardCustomEditor]'
    });
    
} elsif ($promoteAction eq 'demote') {
    $batch->deleteProperty("/server/ec_customEditors/pluginStep/jasmine");
}

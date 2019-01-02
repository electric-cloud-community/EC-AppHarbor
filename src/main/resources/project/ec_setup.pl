
# Data that drives the create step picker registration for this plugin.
my %ListApplications = (
                        label       => "AppHarbor - ListApplications",
                        procedure   => "ListApplications",
                        description => "Allows to list all applications associated with the authorized AppHarbor account, or just one specific application",
                        category    => "Deployment"
                       );
                       
my %CreateApplication = (
                        label       => "AppHarbor - CreateApplication",
                        procedure   => "CreateApplication",
                        description => "Allows to create an AppHarbor application",
                        category    => "Deployment"
                       );

my %EditApplication = (
                        label       => "AppHarbor - EditApplication",
                        procedure   => "EditApplication",
                        description => "Allows to edit an existing AppHarbor application",
                        category    => "Deployment"
                       );                       
my %RemoveApplication = (
                        label       => "AppHarbor - RemoveApplication",
                        procedure   => "RemoveApplication",
                        description => "Allows to remove an existing AppHarbor application",
                        category    => "Deployment"
                       );
                       
my %ListErrors = (
                         label       => "AppHarbor - ListErrors",
                         procedure   => "ListErrors",
                         description => "Allows to retrieve information about the unhandled exception logs for an application",
                         category    => "Deployment"
                        );

my %ListCollaborator = (
                          label       => "AppHarbor - ListCollaborator",
                          procedure   => "ListCollaborator",
                          description => "Allows to retrieve information about the collaborators for an application",
                          category    => "Deployment"
                         );
my %CreateCollaborator = (
                        label       => "AppHarbor - CreateCollaborator",
                        procedure   => "CreateCollaborator",
                        description => "Allows to create a collaborator for an application",
                        category    => "Deployment"
                       );
                       
my %EditCollaborator = (
                        label       => "AppHarbor - EditCollaborator",
                        procedure   => "EditCollaborator",
                        description => "Allows to edit an existing collaborator for an application",
                        category    => "Deployment"
                       );
                       
my %RemoveCollaborator = (
                        label       => "AppHarbor - RemoveCollaborator",
                        procedure   => "RemoveCollaborator",
                        description => "Allows to remove an existing collaborator from an application",
                        category    => "Deployment"
                       );

my %ListConfiguration = (
                           label       => "AppHarbor - ListConfiguration",
                           procedure   => "ListConfiguration",
                           description => "Allows to retrieve information about the user-created environment settings for an application. The options are: List Configuration Variables and Get Configuration Variable Detail",
                           category    => "Deployment"
                          );
                          
my %CreateConfigurationVariable = (
                           label       => "AppHarbor - CreateConfigurationVariable",
                           procedure   => "CreateConfigurationVariable",
                           description => "Allows to create a configuration variable for an application",
                           category    => "Deployment"
                          );
my %EditConfigurationVariable = (
                           label       => "AppHarbor - EditConfigurationVariable",
                           procedure   => "EditConfigurationVariable",
                           description => "Allows to edit a configuration variable for an application",
                           category    => "Deployment"
                          );
my %RemoveConfigurationVariable = (
                           label       => "AppHarbor - RemoveConfigurationVariable",
                           procedure   => "RemoveConfigurationVariable",
                           description => "Allows to remove a configuration variable from an application",
                           category    => "Deployment"
                          );

my %ListHostNames = (
                         label       => "AppHarbor - ListHostNames",
                         procedure   => "ListHostNames",
                         description => "Allows to retrieve information about the host names of an application. The options are: List Hostnames and Get Hostname Detail",
                         category    => "Deployment"
                        );
my %CreateHostName = (
                         label       => "AppHarbor - CreateHostName",
                         procedure   => "CreateHostName",
                         description => "Allow the user to create a custom host name and associate it with an application",
                         category    => "Deployment"
                        );

my %DeleteHostName = (
                         label       => "AppHarbor - DeleteHostName",
                         procedure   => "DeleteHostName",
                         description => "Allow the user to delete a host name from a given application",
                         category    => "Deployment"
                        );

my %ListServiceHooks = (
                         label       => "AppHarbor - ListServiceHooks",
                         procedure   => "ListServiceHooks",
                         description => "Used to view and remove the service hooks associated with an AppHarbor application",
                         category    => "Deployment"
                        );
my %CreateServiceHook = (
                         label       => "AppHarbor - CreateServiceHook",
                         procedure   => "CreateServiceHook",
                         description => "Allow the user to create service hooks and associate them with an AppHarbor application",
                         category    => "Deployment"
                        );
my %RemoveServiceHook = (
                         label       => "AppHarbor - RemoveServiceHook",
                         procedure   => "RemoveServiceHook",
                         description => "Allow the user to remove service hooks",
                         category    => "Deployment"
                        );

my %BuildsActions = (
                          label       => "AppHarbor - BuildsActions",
                          procedure   => "BuildsActions",
                          description => "Allow the user to retrieve information about the build history for an application. This procedure will permit the viewing the test history associated with the authorized AppHarbor account",
                          category    => "Deployment"
                         );
my %Deploy = (
                         label       => "AppHarbor - Deploy",
                         procedure   => "Deploy",
                         description => "Allow the user to deploy an application",
                         category    => "Deployment"
                        );
my %RetrieveToken = (
                         label       => "AppHarbor - RetrieveToken",
                         procedure   => "RetrieveToken",
                         description => "Allows the user to create a Configuration with the valid token, by providing the username and password",
                         category    => "Deployment"
                        );


$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - ListApplications");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - ListErrors");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - ListCollaborator");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - ListConfiguration");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - ListHostNames");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - ListServiceHooks");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - BuildsActions");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - CreateApplication");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - EditApplication");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - RemoveApplication");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - CreateCollaborator");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - EditCollaborator");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - RemoveCollaborator");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - CreateConfigurationVariable");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - EditConfigurationVariable");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - RemoveConfigurationVariable");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - CreateHostName");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - DeleteHostName");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - CreateServiceHook");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - RemoveServiceHook");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - Deploy");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/AppHarbor - RetrieveToken");

@::createStepPickerSteps = (\%ListApplications, \%ListErrors, \%ListCollaborator, \%ListConfiguration, \%ListHostNames, \%ListServiceHooks, \%BuildsActions, \%CreateApplication, \%EditApplication,\%RemoveApplication, \%CreateCollaborator, \%EditCollaborator, \%RemoveCollaborator, \%CreateConfigurationVariable, \%EditConfigurationVariable, \%RemoveConfigurationVariable, \%CreateHostName, \%DeleteHostName, \%CreateServiceHook, \%RemoveServiceHook, \%Deploy, \%RetrieveToken);


my $pluginName = "@PLUGIN_NAME@";
if ($upgradeAction eq 'upgrade') {
    my $query   = $commander->newBatch();
    my $newcfg  = $query->getProperty("/plugins/$pluginName/project/AppHarbor_cfgs");
    my $oldcfgs = $query->getProperty("/plugins/$otherPluginName/project/AppHarbor_cfgs");

    local $self->{abortOnError} = 0;
    $query->submit();

    # if new plugin does not already have cfgs
    if ($query->findvalue($newcfg, "code") eq "NoSuchProperty") {

        # if old cfg has some cfgs to copy
        if ($query->findvalue($oldcfgs, "code") ne "NoSuchProperty") {
            $batch->clone(
                          {
                            path      => "/plugins/$otherPluginName/project/AppHarbor_cfgs",
                            cloneName => "/plugins/$pluginName/project/AppHarbor_cfgs"
                          }
                         );
        }
    }
}

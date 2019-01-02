@files = (
    ######################################################################################
    #                                   GENERIC PROPS                                    #
    ######################################################################################
    ['//property[propertyName="ec_setup"]/value',       'ec_setup.pl'],
    ['//property[propertyName="AppHarbor"]/value',      'lib/AppHarbor.pl'],
    ['//property[propertyName="postp_matchers"]/value', 'postp_matchers.pl'],
    ######################################################################################
    #                                    STEP PROPS                                      #
    ######################################################################################
    ['//step[stepName="ListApplications"]/command',     'steps/list_applications.pl'],
    ['//step[stepName="CreateApplication"]/command',    'steps/create_application.pl'],
    ['//step[stepName="EditApplication"]/command',      'steps/edit_application.pl'],
    ['//step[stepName="RemoveApplication"]/command',    'steps/remove_application.pl'],
    ['//step[stepName="CreateCollaborator"]/command',   'steps/create_collaborator.pl'],
    ['//step[stepName="EditCollaborator"]/command',     'steps/edit_collaborator.pl'],
    ['//step[stepName="RemoveCollaborator"]/command',   'steps/remove_collaborator.pl'],
    ['//step[stepName="CreateConfigurationVariable"]/command',     'steps/create_config_var.pl'],
    ['//step[stepName="EditConfigurationVariable"]/command',       'steps/edit_config_var.pl'],
    ['//step[stepName="RemoveConfigurationVariable"]/command',     'steps/remove_config_var.pl'],
    ['//step[stepName="CreateHostName"]/command',       'steps/create_host_name.pl'],
    ['//step[stepName="DeleteHostName"]/command',       'steps/delete_host_name.pl'],
    ['//step[stepName="CreateServiceHook"]/command',    'steps/create_service_hook.pl'],
    ['//step[stepName="RemoveServiceHook"]/command',    'steps/remove_service_hook.pl'],
    ['//step[stepName="Deploy"]/command',               'steps/deploy.pl'],
    ['//step[stepName="ListErrors"]/command',       'steps/list_errors.pl'],
    ['//step[stepName="ListCollaborator"]/command', 'steps/list_collaborator.pl'],
    ['//step[stepName="ListConfiguration"]/command','steps/list_configuration.pl'],
    ['//step[stepName="ListHostNames"]/command',    'steps/list_host_names.pl'],
    ['//step[stepName="ListServiceHooks"]/command', 'steps/list_service_hooks.pl'],
    ['//step[stepName="BuildsActions"]/command',    'steps/builds_actions.pl'],
    ['//step[stepName="RetrieveToken"]/command',    'steps/retrieve_token.pl'],

    ######################################################################################
    #                                      SECURITY                                      #
    ######################################################################################
    ['//property[propertyName="ui_forms"]/propertySheet/property[propertyName="@PLUGIN_KEY@ - AppHarborCreateConfigForm"]/value', 'forms/configuration/AppHarborCreateConfigForm.xml'],
    ['//property[propertyName="ui_forms"]/propertySheet/property[propertyName="@PLUGIN_KEY@ - AppHarborEditConfigForm"]/value',   'forms/configuration/AppHarborEditConfigForm.xml'],
    ['//procedure[procedureName="CreateConfiguration"]/step[stepName="CreateConfiguration"]/command',                             'conf/createcfg.pl'],    
    ['//procedure[procedureName="DeleteConfiguration"]/step[stepName="DeleteConfiguration"]/command',                             'conf/deletecfg.pl'],
    ######################################################################################
    #                                     XML FORMS                                      #
    ######################################################################################    
    ['//procedure[procedureName="CreateApplication"]/propertySheet/property[propertyName="ec_parameterForm"]/value',            'forms/CreateApplicationForm.xml'],
    ['//procedure[procedureName="EditApplication"]/propertySheet/property[propertyName="ec_parameterForm"]/value',              'forms/EditApplicationForm.xml'],
    ['//procedure[procedureName="RemoveApplication"]/propertySheet/property[propertyName="ec_parameterForm"]/value',            'forms/RemoveApplicationForm.xml'],
    ['//procedure[procedureName="CreateCollaborator"]/propertySheet/property[propertyName="ec_parameterForm"]/value',           'forms/CreateCollaboratorForm.xml'],
    ['//procedure[procedureName="EditCollaborator"]/propertySheet/property[propertyName="ec_parameterForm"]/value',             'forms/EditCollaboratorForm.xml'],
    ['//procedure[procedureName="RemoveCollaborator"]/propertySheet/property[propertyName="ec_parameterForm"]/value',           'forms/RemoveCollaboratorForm.xml'],
    ['//procedure[procedureName="CreateConfigurationVariable"]/propertySheet/property[propertyName="ec_parameterForm"]/value',  'forms/CreateConfigVarForm.xml'],
    ['//procedure[procedureName="EditConfigurationVariable"]/propertySheet/property[propertyName="ec_parameterForm"]/value',    'forms/EditConfigVarForm.xml'],
    ['//procedure[procedureName="RemoveConfigurationVariable"]/propertySheet/property[propertyName="ec_parameterForm"]/value',  'forms/RemoveConfigVarForm.xml'],
    ['//procedure[procedureName="CreateHostName"]/propertySheet/property[propertyName="ec_parameterForm"]/value',               'forms/CreateHostNameForm.xml'],
    ['//procedure[procedureName="DeleteHostName"]/propertySheet/property[propertyName="ec_parameterForm"]/value',               'forms/DeleteHostNameForm.xml'],
    ['//procedure[procedureName="CreateServiceHook"]/propertySheet/property[propertyName="ec_parameterForm"]/value',            'forms/CreateServiceHookForm.xml'],
    ['//procedure[procedureName="RemoveServiceHook"]/propertySheet/property[propertyName="ec_parameterForm"]/value',            'forms/RemoveServiceHookForm.xml'],
    ['//procedure[procedureName="Deploy"]/propertySheet/property[propertyName="ec_parameterForm"]/value',                       'forms/DeployForm.xml'],
    ['//procedure[procedureName="RetrieveToken"]/propertySheet/property[propertyName="ec_parameterForm"]/value',                'forms/RetrieveTokenForm.xml'],
);

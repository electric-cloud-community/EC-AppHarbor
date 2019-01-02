# -------------------------------------------------------------------------
# Package
#    AppHarbor.pl
#
# Dependencies
#    -none
#
# Purpose
#    Perl script to integrate AppHarbor functionality
#
# Date
#    06/08/2012
#
# Engineer
#    Bryan Barrantes
#
# Copyright (c) 2012 Electric Cloud, Inc.
# All rights reserved
# -------------------------------------------------------------------------

# -------------------------------------------------------------------------
# Includes
# -------------------------------------------------------------------------
use strict;
use warnings;
use ElectricCommander;
use ElectricCommander::PropDB;
use lib "$ENV{COMMANDER_PLUGINS}/@PLUGIN_NAME@/agent/lib";
use LWP 5.825;    #5.831;#6.02;
use LWP::Simple;
use JSON;

use constant PATH_TO_CLIENT => qq{$ENV{COMMANDER_PLUGINS}\\@PLUGIN_NAME@\\console\\tokenapp.exe};

local $| = 1;

########################################################################
=head2 list_applications
 
  Title    : list_applications
  Usage    : list_applications("ConfigName","Action","AppName","AddOnName");
  Function : Method with parameters
  Returns  : none
  Args     : named arguments:
           : -ConfigName    => name of the configuration
           : -Action        => action to perform
           : -AppName       => name of the application
           : -AddOnName     => name of the add-on
           :
=cut
########################################################################
sub list_applications {
    my ($ConfigName,$Action,$AppSlug) = @_;
    
    my $empty   = q{};
    my $PathURL = $empty;
    my $Content = $empty;
    my $RequestType = $empty;
    
    if($ConfigName eq $empty) {
        $ec->setProperty("outcome", "error");
        print "Error: Invalid Configuration\n"; exit;
    }
    if($Action eq "get" and $AppSlug eq $empty) {
        $ec->setProperty("outcome", "error");
        print "Error: Application Slug cannot be empty\n"; exit;
    }

    if ($Action eq "list") {
        $PathURL = qq{applications};
        $RequestType = qq{GET};
    } else {#get
        $PathURL = qq{applications/$AppSlug};
        $RequestType = qq{GET};
    }
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}


sub create_application{
    my ($ConfigName,$Name,$Region) = @_;    
    my $empty   = q{};
    my $PathURL = qq{applications};
    my $RequestType = qq{POST};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($Name eq $empty) or ($Region eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    $Content = qq{{
    "name" : "$Name",
    "region_identifier" : "amazon-web-services::$Region"
}};   
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);    
}

sub edit_application{
    my ($ConfigName,$AppSlug,$Name) = @_;    
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug};
    my $RequestType = qq{PUT};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($Name eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    $Content = qq{{
    "name" : "$Name"
}};   
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);    
}

sub remove_application{
    my ($ConfigName,$AppSlug) = @_;    
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug};
    my $RequestType = qq{DELETE};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);  
}

########################################################################
=head2 list_errors
 
  Title    : list_errors
  Usage    : list_errors("ConfigName","Action","AppName","NewAppName","Stack","NewAppOwner");
  Function : Method with parameters
  Returns  : none
  Args     : named arguments:
           : -ConfigName    => name of the configuration
           : -Action        => action to perform
           : -AppName       => name of the application
           : -NewAppName    => new name for the application
           : -Stack         => stack for the application
           : -NewAppOwner   => new owner of the application
           :
=cut
########################################################################
sub list_errors {
    my ($ConfigName, $Action, $AppSlug, $Error) = @_;
    my $empty   = q{};
    my $PathURL = $empty;
    my $Content = $empty;
    my $RequestType = qq{GET};
    
    if(($ConfigName eq $empty) or ($Action eq $empty) or ($AppSlug eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    if($Action eq "get" and $Error eq $empty) {
        $ec->setProperty("outcome", "error");
        print "Error: Error ID cannot be empty\n"; exit;
    }

    if ($Action eq "list") {
        $PathURL = qq{applications/$AppSlug/errors};        
    } else {#get
        $PathURL = qq{applications/$AppSlug/errors/$Error};        
    }
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

########################################################################
=head2 list_collaborator
 
  Title    : list_collaborator
  Usage    : list_collaborator("ConfigName","Action","AppName","EmailAccount");
  Function : Method with parameters
  Returns  : none
  Args     : named arguments:
           : -ConfigName    => name of the configuration
           : -Action        => action to perform
           : -AppName       => name of the application
           : -EmailAccount  => Email account
           :
=cut
########################################################################
sub list_collaborator {
    my ($ConfigName, $Action, $AppSlug, $Collaborator) = @_;
    my $empty   = q{};
    my $PathURL = $empty;
    my $Content = $empty;
    my $RequestType = qq{GET};
    
    if(($ConfigName eq $empty) or ($Action eq $empty) or ($AppSlug eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    if($Action eq "get" and $Collaborator eq $empty) {
        $ec->setProperty("outcome", "error");
        print "Error: Collaborator ID cannot be empty\n"; exit;
    }

    if ($Action eq "list") {
        $PathURL = qq{applications/$AppSlug/collaborators};        
    } else {#get
        $PathURL = qq{applications/$AppSlug/collaborators/$Collaborator};        
    }
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}


sub create_collaborator{
    my ($ConfigName,$AppSlug,$Email, $Role) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/collaborators};
    my $RequestType = qq{POST};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($Email eq $empty) or ($Role eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    $Content = qq{{
    "collaboratorEmail" : "$Email",
    "role" : "$Role"
}};   
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub edit_collaborator{
    my ($ConfigName,$AppSlug,$Collaborator, $Role) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/collaborators/$Collaborator};
    my $RequestType = qq{PUT};
    my $Content = $empty;
        
    #Validate parameters
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($Collaborator eq $empty) or ($Role eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    $Content = qq{{
    "role" : "$Role"
}};   
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub remove_collaborator{
    my ($ConfigName,$AppSlug,$Collaborator) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/collaborators/$Collaborator};
    my $RequestType = qq{DELETE};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($Collaborator eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

########################################################################

=head2 list_configuration
 
  Title    : list_configuration
  Usage    : list_configuration("ConfigName","Action","AppName","Body","Key");
  Function : Method with parameters
  Returns  : none
  Args     : named arguments:
           : -ConfigName    => name of the configuration
           : -Action        => action to perform
           : -AppName       => name of the application
           : -Body          => new config vars, as a JSON hash
           : -Key           => name of the config var to remove
           :
=cut

########################################################################
sub list_configuration {
    my ($ConfigName, $Action, $AppSlug, $ConfigVar) = @_;
    my $empty   = q{};
    my $PathURL = $empty;
    my $Content = $empty;
    my $RequestType = qq{GET};
    
    if(($ConfigName eq $empty) or ($Action eq $empty) or ($AppSlug eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    if($Action eq "get" and $ConfigVar eq $empty) {
        $ec->setProperty("outcome", "error");
        print "Error: Configuration Variable cannot be empty\n"; exit;
    }

    if ($Action eq "list") {
        $PathURL = qq{applications/$AppSlug/configurationvariables};        
    } else {#get
        $PathURL = qq{applications/$AppSlug/configurationvariables/$ConfigVar};        
    }
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub create_config_var{
    my ($ConfigName,$AppSlug,$Name, $Value) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/configurationvariables};
    my $RequestType = qq{POST};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($Name eq $empty) or ($Value eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    $Content = qq{{
    "key" : "$Name",
    "value" : "$Value"
}};   
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub edit_config_var{
    my ($ConfigName,$AppSlug,$ConfigVar,$Name, $Value) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/configurationvariables/$ConfigVar};
    my $RequestType = qq{PUT};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($ConfigVar eq $empty) or ($Name eq $empty) or ($Value eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    $Content = qq{{
    "key" : "$Name",
    "value" : "$Value"
}};   
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub remove_config_var{
    my ($ConfigName,$AppSlug,$ConfigVar) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/configurationvariables/$ConfigVar};
    my $RequestType = qq{DELETE};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($ConfigVar eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}



########################################################################

=head2 list_host_names
 
  Title    : list_host_names
  Usage    : list_host_names("Application Path");
  Function : Deploy a AppHarbor application using Git
  Returns  : nothing
  Args     : named arguments:
           : -AppPath => Local path to AppHarbor application
           : -Branch  => Branch for deploy
           :    
=cut

########################################################################
sub list_host_names {
    my ($ConfigName,$Action,$AppSlug,$Hostname) = @_;
    my $empty   = q{};
    my $PathURL = $empty;
    my $Content = $empty;
    my $RequestType = qq{GET};
    
    if(($ConfigName eq $empty) or ($Action eq $empty) or ($AppSlug eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    if($Action eq "get" and $Hostname eq $empty) {
        $ec->setProperty("outcome", "error");
        print "Error: Host name cannot be empty\n"; exit;
    }

    if ($Action eq "list") {
        $PathURL = qq{applications/$AppSlug/hostnames};
    } else {#get
        $PathURL = qq{applications/$AppSlug/hostnames/$Hostname};
    }
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub create_host_name{
    my ($ConfigName,$AppSlug,$Hostname) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/hostnames};
    my $RequestType = qq{POST};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($Hostname eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    $Content = qq{{
    "value" : "$Hostname"
}};   
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub delete_host_name{
    my ($ConfigName,$AppSlug,$Hostname) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/hostnames/$Hostname};
    my $RequestType = qq{DELETE};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($Hostname eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

########################################################################

=head2 list_service_hooks
 
  Title    : list_service_hooks
  Usage    : list_service_hooks("ConfigName","Action","AppName","ProcessName","ProcessType","Quantity");
  Function : Method with parameters
  Returns  : none
  Args     : named arguments:
           : -ConfigName    => name of the configuration
           : -Action        => action to perform
           : -AppName       => name of the application
           : -ProcessName   => name of the process
           : -ProcessType   => type of the process
           : -Quantity      => quantity of processes to scale
           :
=cut

########################################################################
sub list_service_hooks {
    my ($ConfigName, $Action, $AppSlug, $ServiceHook) = @_;
    my $empty   = q{};
    my $PathURL = $empty;
    my $Content = $empty;
    my $RequestType = qq{GET};
    
    if(($ConfigName eq $empty) or ($Action eq $empty) or ($AppSlug eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    if($Action eq "get" and $ServiceHook eq $empty) {
        $ec->setProperty("outcome", "error");
        print "Error: Service Hook cannot be empty\n"; exit;
    }

    if ($Action eq "list") {
        $PathURL = qq{applications/$AppSlug/servicehooks};
    } else {#get
        $PathURL = qq{applications/$AppSlug/servicehooks/$ServiceHook};
    }
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub create_service_hook{
    my ($ConfigName, $AppSlug, $URL) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/servicehooks};
    my $RequestType = qq{POST};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($URL eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    $Content = qq{{
    "url" : "$URL"
}};   
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub remove_service_hook{
    my ($ConfigName, $AppSlug, $ServiceHook) = @_;
    my $empty   = q{};
    my $PathURL = qq{applications/$AppSlug/servicehooks/$ServiceHook};
    my $RequestType = qq{DELETE};
    my $Content = $empty;
    
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($ServiceHook eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

########################################################################

=head2 build_actions
 
  Title    : build_actions
  Usage    : build_actions("ConfigName","Action","AppName","Release");
  Function : Method with parameters
  Returns  : none
  Args     : named arguments:
           : -ConfigName    => name of the configuration
           : -Action        => action to perform
           : -AppName       => name of the application
           : -Release       => name of the release
           :
=cut

########################################################################
sub build_actions {
    my ($ConfigName, $Action, $AppSlug, $Build, $Test) = @_;
    my $empty   = q{};
    my $PathURL = $empty;
    my $Content = $empty;
    my $RequestType = qq{GET};
    
    if(($ConfigName eq $empty) or ($Action eq $empty) or ($AppSlug eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }    
    
    if ($Action eq "listbuild") {
        $PathURL = qq{applications/$AppSlug/builds};
    } elsif($Action eq "getbuild") {
        if($Build eq $empty) {
            $ec->setProperty("outcome", "error");
            print "Error: Build cannot be empty\n"; exit;
        } else {
            $PathURL = qq{applications/$AppSlug/builds/$Build};
        }
    } elsif($Action eq "listtest") {
        if($Build eq $empty) {
            $ec->setProperty("outcome", "error");
            print "Error: Build cannot be empty\n"; exit;
        } else {
            $PathURL = qq{applications/$AppSlug/builds/$Build/tests};
        }
    } else { #gettest
        if(($Test eq $empty) or ($Build eq $empty)) {
            $ec->setProperty("outcome", "error");
            print "Error: Build and Test identifiers cannot be empty\n"; exit;
        } else {
            $PathURL = qq{applications/$AppSlug/builds/$Build/tests/$Test};
        }        
    }
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

sub deploy {
    my ($ConfigName,$AppSlug,$Build) = @_;
    my $empty   = q{};
    my $PathURL = qq{/applications/$AppSlug/builds/$Build/deploy};
    my $RequestType = qq{POST};
    my $Content = $empty;
        
    #Validate parameters
    if(($ConfigName eq $empty) or ($AppSlug eq $empty) or ($Build eq $empty)) {
        $ec->setProperty("outcome", "error");
        print "Error: Some required parameters are missing\n"; exit;
    }
    
    appharbor_api_request($ConfigName,$PathURL,$RequestType,$Content);
}

########################################################################
=head2 appharbor_api_request
 
  Title    : appharbor_api_request
  Usage    : appharbor_api_request("Content");
  Function : Makes the request to AppHarbor API
  Returns  : none
  Args     : named arguments:
           : -Content    => request content, encapsulating all the parameters
           :
=cut
########################################################################
sub appharbor_api_request {
    my ($ConfigName,$PathURL,$RequestType,$Content) = @_;

    my $browser    = LWP::UserAgent->new;
    my $url        = URI->new("https://appharbor.com/".$PathURL);
    my $whitespace = q{ };
    my $empty      = q{};
    my $size       = 0;
    my $req;
    my $apiKey     = qq{};

    my %configuration = get_configuration($ConfigName);
    if (%configuration) {
        if ($configuration{'token'} && $configuration{'token'} ne "") {
            $apiKey = $configuration{'token'};
        }
        else {
            $ec->setProperty("outcome", "error");
            print "Error: API token cannot be empty\n";
            exit;
        }
    }

    #Request Type
    if($RequestType eq "POST"){
        $req = HTTP::Request->new(POST => $url);
        $req->content_type("application/json");
    } elsif ($RequestType eq "GET"){
        $req = HTTP::Request->new(GET => $url);
    } elsif ($RequestType eq "PUT"){
        $req = HTTP::Request->new(PUT => $url);
    } else { #DELETE
        $req = HTTP::Request->new(DELETE => $url);
    }
    #Stamdard Headers
    $req->header( "Accept" => "application/json" );
    $req->header( "Authorization" => "BEARER $apiKey" ); # Authorization: BEARER <access_token>
    
    #Set request content
    if($Content and ($Content ne $empty)){
        $req->content($Content);
    }

    print "Creating Request...\n";

    # Print Request Parameters
    print "> Request:\n" . $req->as_string;

    # Perform Request
    print "Sending Request to AppHarbor...\n";
    my $response = $browser->request($req);

    # Check for errors
    print "----------------------------------------------------------------------------------------------------\n";
    print "Response Received.\nChecking for errors...\n";
    if ($response->is_error) {
        $ec->setProperty("outcome", "error");
        if ($response->status_line ne $empty) { print "\nStatus: " . $response->status_line . "\n"; }
        print("Error: The server was unable to fulfil the request.\nPlease check your parameters.");
        return;
    }
    print "Proceed to print response.\n";

    # Print Response
    print "> Response\n";
    my @res = split("\n", $response->as_string);
    my $format = $empty;
    $size = @res;
    my $response_line = shift(@res);
    while (($size > 1) and ($response_line !~ m/(^{).*|(^\[).*|(^<).*/ixsmg)) {
        if ($response_line =~ m/Content-Type:\s(.*)\/([A-Za-z0-9-.]*)/ixsmg) { $format = $2; }
        print $response_line. "\n";
        $response_line = shift(@res);
        $size--;
    }
    my $response_body = $response->content();

    # Response Format Validation
    if ($format eq "json" or $format eq "javascript") {
        my $json        = JSON->new->allow_nonref;
        my $perl_scalar = $json->decode($response_body);
        print $json->pretty->encode($perl_scalar);
    }
    else {
        print $response_body;
    }
    return;
}

sub retrieve_token {
    my ($ConfigName, $UserName,$Password) = @_;
    my $path = PATH_TO_CLIENT;
    $path =~ s/\//\\/g;
    my $cmd = qq{"$path" $UserName $Password};
    my $result = qx{$cmd};
    
    my $token = $result;
    $result=~ m/Token:\s(.*)/ixsmg;
    $token = $1;
    print "Token: $token\n";
    my $xpath = $ec->runProcedure("@PLUGIN_NAME@", 
        { procedureName => "CreateConfiguration",
          pollInterval  => '0.2',
          timeout       => 1200,
          actualParameter => [ 
            { actualParameterName => 'config', value => $ConfigName }, 
            { actualParameterName => 'token', value => $token },
          ],
        });
    my $status = $xpath->findvalue("//status");
    if($status eq 'completed') {
        print "Configuration '".$ConfigName."' succesfully created.\n";
    } else {
        $ec->setProperty("outcome", "error");        
        print("Error: Unable to create the configuration with the provided parameters.");exit;
    }
}

########################################################################
=head2 get_configuration
 
  Title    : get_configuration
  Usage    : get_configuration("Configuration name");
  Function : get the information of the configuration given 
  Returns  : hash containing the configuration information
  Args     : named arguments:
           : -configName => name of the configuration to retrieve
           :
=cut

########################################################################
sub get_configuration {
    my ($configName) = @_;

    my $ec = new ElectricCommander();

    my %config;

    my $pluginConfigs = new ElectricCommander::PropDB($ec, "/projects/@PLUGIN_KEY@-@PLUGIN_VERSION@/AppHarbor_cfgs");

    my %row = $pluginConfigs->getRow($configName);

    # Check if configuration exists
    unless (keys(%row)) {
        print qq{Credential "$configName" does not exist};
        return 1;
    }

    foreach my $c (keys %row) {

        #getting all values except the credential that was read previously
        if ($c ne "credential") {
            $config{$c} = $row{$c};
        }
    }

    return %config;
}

########################################################################

=head2 plugin_info
 
  Title    : plugin_info
  Usage    : plugin_info("Plugin name");
  Function : get the information of the given plugin
  Returns  : nothing
  Args     : named arguments:
           : -pluginKey  => name of the plugin
           :
=cut

########################################################################
sub plugin_info {

    # Print plugin Info
    my $pluginKey  = 'EC-AppHarbor';
    my $xpath      = $ec->getPlugin($pluginKey);
    my $pluginName = $xpath->findvalue('//pluginVersion')->value;
    print "Using plugin $pluginKey version $pluginName";
    print "\n----------------------------------------------------------------------------------------------------\n";
}

1;

use ElectricCommander;

my $ec = new ElectricCommander();
my $code = $ec->getProperty("/myProject/AppHarbor")->findvalue("//value")->value();

eval($code) or die("Error loading AppHarbor library code: $@\n");

my $ConfigName          = ($ec->getProperty( "ConfigName" ))->findvalue('//value')->string_value;    
my $AppSlug             = ($ec->getProperty( "AppSlug" ))->findvalue('//value')->string_value;    
my $Collaborator        = ($ec->getProperty( "Collaborator" ))->findvalue('//value')->string_value;    
my $Role                = ($ec->getProperty( "Role" ))->findvalue('//value')->string_value;

plugin_info();
edit_collaborator($ConfigName,$AppSlug,$Collaborator, $Role);
use ElectricCommander;

my $ec = new ElectricCommander();
my $code = $ec->getProperty("/myProject/AppHarbor")->findvalue("//value")->value();

eval($code) or die("Error loading AppHarbor library code: $@\n");

my $ConfigName          = ($ec->getProperty( "ConfigName" ))->findvalue('//value')->string_value;    
my $AppSlug             = ($ec->getProperty( "AppSlug" ))->findvalue('//value')->string_value;
my $ConfigVar           = ($ec->getProperty( "ConfigVar" ))->findvalue('//value')->string_value;
my $Name                = ($ec->getProperty( "Name" ))->findvalue('//value')->string_value;    
my $Value               = ($ec->getProperty( "Value" ))->findvalue('//value')->string_value;

plugin_info();
edit_config_var($ConfigName,$AppSlug,$ConfigVar,$Name, $Value);
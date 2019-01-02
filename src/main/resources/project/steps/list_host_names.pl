use ElectricCommander;

my $ec = new ElectricCommander();
my $code = $ec->getProperty("/myProject/AppHarbor")->findvalue("//value")->value();

eval($code) or die("Error loading AppHarbor library code: $@\n");

my $ConfigName         = ($ec->getProperty( "ConfigName" ))->findvalue('//value')->string_value;
my $Action             = ($ec->getProperty( "Action" ))->findvalue('//value')->string_value;
my $AppSlug            = ($ec->getProperty( "AppSlug" ))->findvalue('//value')->string_value;
my $Hostname           = ($ec->getProperty( "Hostname" ))->findvalue('//value')->string_value;

plugin_info();
list_host_names($ConfigName,$Action,$AppSlug,$Hostname);
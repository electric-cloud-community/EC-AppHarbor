use ElectricCommander;

my $ec = new ElectricCommander();
my $code = $ec->getProperty("/myProject/AppHarbor")->findvalue("//value")->value();

eval($code) or die("Error loading AppHarbor library code: $@\n");

my $ConfigName         = ($ec->getProperty( "ConfigName" ))->findvalue('//value')->string_value;
my $AppSlug            = ($ec->getProperty( "AppSlug" ))->findvalue('//value')->string_value;
my $Hostname           = ($ec->getProperty( "Hostname" ))->findvalue('//value')->string_value;

plugin_info();
delete_host_name($ConfigName,$AppSlug,$Hostname);
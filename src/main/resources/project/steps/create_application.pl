use ElectricCommander;

my $ec = new ElectricCommander();
my $code = $ec->getProperty("/myProject/AppHarbor")->findvalue("//value")->value();

eval($code) or die("Error loading AppHarbor library code: $@\n");

my $ConfigName          = ($ec->getProperty( "ConfigName" ))->findvalue('//value')->string_value;    
my $Name                = ($ec->getProperty( "Name" ))->findvalue('//value')->string_value;    
my $Region              = ($ec->getProperty( "Region" ))->findvalue('//value')->string_value;    

plugin_info();
create_application($ConfigName,$Name,$Region);
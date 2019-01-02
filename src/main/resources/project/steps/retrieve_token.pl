use ElectricCommander;

my $ec = new ElectricCommander();
my $code = $ec->getProperty("/myProject/AppHarbor")->findvalue("//value")->value();

eval($code) or die("Error loading AppHarbor library code: $@\n");

my $ConfigName          = ($ec->getProperty( "ConfigName" ))->findvalue('//value')->string_value;    
my $UserName            = ($ec->getProperty( "UserName" ))->findvalue('//value')->string_value;    
my $Password            = ($ec->getProperty( "Password" ))->findvalue('//value')->string_value;

plugin_info();
retrieve_token($ConfigName,$UserName,$Password);
use ElectricCommander;

my $ec   = new ElectricCommander();
my $code = $ec->getProperty("/myProject/AppHarbor")->findvalue("//value")->value();

eval($code) or die("Error loading AppHarbor library code: $@\n");

my $ConfigName  = ($ec->getProperty("ConfigName"))->findvalue('//value')->string_value;
my $Action      = ($ec->getProperty("Action"))->findvalue('//value')->string_value;
my $AppSlug     = ($ec->getProperty("AppSlug"))->findvalue('//value')->string_value;
my $Error       = ($ec->getProperty("Error"))->findvalue('//value')->string_value;

plugin_info();
list_errors($ConfigName, $Action, $AppSlug, $Error);

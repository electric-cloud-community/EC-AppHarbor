@::gMatchers = (
  {
        id =>           "AppHarborStatus",
        pattern =>      q{(HTTP\/\d.\d)\s(\d\d\d)\s(.*)},
        action =>       q{&addSimpleError("AppHarborStatus", "Request Status: $2 $3");updateSummary();},
  },
  {
    id =>               "TokenError",
    pattern =>          q{.*Sign\sin.*},
    action =>           q{&addSimpleError("TokenError", "Error: Invalid Access Token");setProperty("outcome", "error" );updateSummary();},
  },
  {
    id =>               "InexistentConfiguration",
    pattern =>          q{.*Failed\sto\sfind\sproperty\s'.*},
    action =>           q{&addSimpleError("InexistentConfiguration", "Error: The Configuration provided does not exist");setProperty("outcome", "error" );updateSummary();},
  },
);

sub addSimpleError {
    my ($name, $customError) = @_;
    if(!defined $::gProperties{$name}){
        setProperty ($name, $customError);
    }
}

sub updateSummary() {    
    my $summary = (defined $::gProperties{"AppHarborStatus"}) ? $::gProperties{"AppHarborStatus"} . "\n" : "";
    $summary .= (defined $::gProperties{"TokenError"}) ? $::gProperties{"TokenError"} . "\n" : "";
    $summary .= (defined $::gProperties{"InexistentConfiguration"}) ? $::gProperties{"InexistentConfiguration"} . "\n" : "";

    setProperty ("summary", $summary);
}

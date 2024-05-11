use plm::rgx;
use strict;


my $spcdir = $ENV{'HOME'} . '/.metatemple-bell';
my $comfil = $spcdir . '/itrup.cm';
my $btween = '';

system('mkdir','-p',$spcdir);

open TAK, ( "| cat >> " . &plm::rgx::bsc($comfil) );

while ( &plm::rgx::remain() )
{
  print TAK $btween;
  print TAK &plm::rgx::rgget();
  $btween = ' ';
}
print TAK "\n";

close TAK;


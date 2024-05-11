# util/sc-expand.pl -- Ring the bell at expanding intervals
# Copyright (C) 2024  Sophia Elizabeth Shapira
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use plm::bellring;
use plm::timeshow;
use strict;

#&plm::bellring::ring();

my $expandi = 20;
my $minexpandi = 5;
my $percengrow = 10;

my $spancaff = 30;
my $durcaff = int($spancaff * 1.8);
my $lastcaff = int(time - ( 2 * $spancaff) );

my @lisotimes;

my $lastring = time;
my $nextring;

my $spcdir = $ENV{'HOME'} . '/.metatemple-bell';
my $comfil = $spcdir . '/itrup.cm';

my $continuar;

sub comfilproc {
  my $lc_cm;
  my $lc_cont;
  my @lc_lines;
  my $lc_line;
  if ( ! ( -f $comfil ) ) { return; }
  sleep(2);
  $lc_cm = 'cat ' . &plm::rgx::bsc($comfil);
  $lc_cont = `$lc_cm`;
  system('rm','-rf',$comfil);
  @lc_lines = split(/\n/,$lc_cont);
  foreach $lc_line (@lc_lines) { &comfillin($lc_line); }
}

sub comfillin {
  my $lc_line;
  my @lc_comp;
  
  @lc_comp = split(' ',$_[0]);
  $lc_line = $lc_comp[0];
  
  if ( $lc_line eq 'rew' )
  {
    $continuar = 0;
    $expandi = int($expandi * ( 1 - ( $percengrow / 100 ) ) );
    if ( $expandi < $minexpandi ) { $expandi = $minexpandi; }
    return;
  }
  
  if ( $lc_line eq 'pcen' )
  {
    $percengrow = $lc_comp[1];
    if ( $percengrow < 1 ) { $percengrow = 1; }
    return;
  }
}

&plm::rgx::setopt('-t',\&opto__no__t__x);
sub opto__no__t__x {
  my $lc_set;
  my $lc_va;
  my $lc_vb;
  $lc_va = &plm::rgx::rgget();
  $lc_vb = &plm::rgx::rgget();
  $lc_set = int( ( $lc_va * 60 ) + $lc_vb + 0.2);
  $expandi = $lc_set;
  if ( $expandi < $minexpandi ) { $expandi = $minexpandi; }
}

&plm::rgx::runopts();

sub retocaff {
  my $lc_cm;
  my $lc_now;
  $lc_now = time;
  if ( $lc_now < $lastcaff ) { return; }
  $lastcaff = int( $lc_now + $spancaff + 0.2 );
  
  $lc_cm = 'caffeinate -d -t ' . $durcaff;
  $lc_cm = '( ' . $lc_cm . ' ) &bg';
  $lc_cm = '( ' . $lc_cm . ' ) > /dev/null 2> /dev/null';
  system($lc_cm);
}

$nextring = $lastring;
while ( 2 > 1 ) { &zangry(); }
sub zangry {
  my $lc_now;
  my $lc_rem;
  my $lc_slp;
  
  $lastring = $nextring;
  $continuar = 10;
  
  print "\nRINGING";
  {
    my $lc2_a;
    
    $lc2_a = `date`; chop($lc2_a);
    @lisotimes = (@lisotimes,$lc2_a);
    $lc2_a = @lisotimes;
    if ( $lc2_a > 5.5 ) { shift(@lisotimes); }
    foreach $lc2_a (@lisotimes)
    {
      print "\n" . $lc2_a;
    }
  }
  print "\n\n";
  &plm::bellring::ring();
  
  
  $nextring = int($lastring + $expandi + 0.2);
  
  $lc_now = time;
  {
    if ( $nextring < $lc_now )
    {
      my $lc3_x;
      $lc3_x = int($lc_now + 0.2 - $nextring);
      $nextring = $lc_now;
      print("\n" .
        "Sleep adjusted for: " . &plm::timeshow::vithour($lc3_x) .
      ":\n\n");
    }
  }
  while ( $lc_now < $nextring )
  {
    $lc_slp = 1;
    $lc_rem = int(($nextring - $lc_now) + 0.2);
    
    print(
      "Remaining in this round: " .
      &plm::timeshow::vithour($lc_rem) .
      " out of " .
      &plm::timeshow::vithour($expandi) .
      ":\n"
    );
    
    &retocaff();
    
    if ( $lc_rem > 3 )
    {
      #system('caffeinate -s -t 1');
      if ( $lc_rem > 8 )
      {
        &comfilproc();
        if ( $continuar < 5 )
        {
          $nextring = time;
          return;
        }
        $lc_slp = 3;
        if ( $lc_rem > 20 ) { $lc_slp = 4; }
      }
    }
    sleep($lc_slp);
    
    $lc_now = time;
  }
  
  
  &expandinex();
}


  
sub expandinex {
  my $lc_ex;
  
  $lc_ex = int($expandi * ( 1 + ( $percengrow / 100 ) ) );
  if ( $lc_ex < ( $expandi + 0.5 ) )
  {
    $lc_ex = int($expandi + 1.2);
  }
  $expandi = $lc_ex;
}

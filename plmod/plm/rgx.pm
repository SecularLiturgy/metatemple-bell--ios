# plm::rgx.pm -- Helps metatemple-bell utility scripts interface with the command line
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

package plm::rgx;
use strict;
use Cwd 'abs_path';

# We start by setting up a copy of the low-level
# command-line that will soon become a copy of
# the high-level one.
my @glc_fullrg = @ARGV;

# The high-level command-line is derived by removing
# everything from the raw command line up-to and
# and including the first '-x' argument. These
# arguments (not including forementioned '-x'
# argument) are placed in a special array that
# provides low-level information from the wrapper
# script to the utility script.
my @glc_critray;
{
  my $lc_a;
  my $lc_b;
  @glc_critray = ();
  $lc_a = '-x';
  $lc_b = @glc_fullrg;
  if ( $lc_b > 0.5 ) { $lc_a = shift(@glc_fullrg); $lc_b = @glc_fullrg; }
  while ( ( $lc_b > 0.5 ) and ( $lc_a ne '-x' ) )
  {
    @glc_critray = ( @glc_critray, $lc_a );
    $lc_a = shift(@glc_fullrg); $lc_b = @glc_fullrg;
  }
}

# And while it is all fine to have a stable copy
# of the high-level command-line, a volatile copy
# is also needed for all of the event-based
# accesses.
my @glc_volrg = @glc_fullrg;

# And the hash of options ....
my %glc_optref = ();

# This is what happens if an unfamiliar option occurs.
my $glc_optnot = \&strange_option;

# ##################### #
#  LIBRARY SUBROUTINES  #
# ##################### #

sub homeland {
  return $glc_critray[0];
}

sub setopt
{
  $glc_optref{$_[0]} = $_[1];
}

sub remain
{
  my $lc_a;
  $lc_a = @glc_volrg;
  return ( $lc_a > 0.5 );
}

sub remc
{
  my $lc_a;
  $lc_a = @glc_volrg;
  return $lc_a;
}

sub rgget
{
  my $lc_a;
  $lc_a = shift(@glc_volrg);
  return $lc_a;
}

sub strange_option {
  my $lc_dh;
  
  $lc_dh = "\n";
  $lc_dh .= "FATAL ERROR: Unknown Option: " . $_[0] . " :\n";
  
  die ( $lc_dh . "\n" );
}

sub runopts {
  my $lc_opt;
  my $lc_act;
  
  while ( &remain() )
  {
    $lc_opt = &rgget();
    $lc_act = $glc_optnot;
    if ( exists($glc_optref{$lc_opt}) ) { $lc_act = $glc_optref{$lc_opt}; }
    
    &$lc_act($lc_opt);
  }
  
  # Be kind. Please rewind.
  @glc_volrg = @glc_fullrg;
}

sub rgadd
{
  my $lc_ret;
  my $lc_rg;
  
  $lc_ret = '';
  
  foreach $lc_rg (@_)
  {
    $lc_ret .= ( ' ' . &bsc($lc_rg) );
  }
  
  return $lc_ret;
}


sub bsc {
  my $lc_ret;
  my $lc_src;
  my $lc_chr;
  $lc_src = scalar reverse $_[0];
  $lc_ret = "\'";
  while ( $lc_src ne "" )
  {
    $lc_chr = chop($lc_src);
    if ( $lc_chr eq "\'" ) { $lc_chr = "\'\"\'\"\'"; }
    $lc_ret .= $lc_chr;
  }
  $lc_ret .= "\'";
  return $lc_ret;
}

1;


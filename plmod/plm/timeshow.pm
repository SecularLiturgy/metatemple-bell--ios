# plm/timeshow.pm -- Functions useful for displaying time durations
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

package plm::timeshow;
use strict;

sub dzero {
  my $lc_a;
  my $lc_b;
  my $lc_c;
  $lc_a = ( '00' . $_[0] );
  $lc_b = chop($lc_a);
  $lc_c = chop($lc_a);
  #print " ----- $lc_c -- $lc_b\n";
  $lc_b = ( $lc_c . $lc_b );
  return $lc_b;
}

sub takeout {
  my $lc_resco;
  my $lc_facto;
  my $lc_remo;
  my $lc_adro;
  
  $lc_adro = $_[0];
  
  $lc_resco = $$lc_adro;
  $lc_facto = $_[1];
  
  $lc_remo = ($lc_resco % $lc_facto);
  $lc_resco = ($lc_resco - $lc_remo);
  $lc_resco = ($lc_resco / $lc_facto);
  $lc_resco = int($lc_resco + 0.2);
  $$lc_adro = $lc_resco;
  #print " $lc_remo - :\n";
  return $lc_remo;
}

sub vithour {
  my $lc_src;
  my $lc_ret;
  $lc_src = $_[0];
  
  $lc_ret = &dzero(&takeout(\$lc_src,60));
  $lc_ret = &dzero(&takeout(\$lc_src,60)) . ':' . $lc_ret;
  
  $lc_ret = $lc_src . ':' . $lc_ret;
}


1;


# plm/bellring.pm -- Functions used for actually sounding the bell.
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

package plm::bellring;
use plm::rgx;
use strict;

my $bellsndfile = &plm::rgx::homeland() . '/bellsnd/modified-bell-sound.wav';

sub ring {
  my $lc_cm;
  $lc_cm = 'afplay ' . &plm::rgx::bsc($bellsndfile);
  
  $lc_cm = '( ' . $lc_cm . ' ) &bg';
  $lc_cm = '( ' . $lc_cm . ' ) > /dev/null 2> /dev/null';
  
  system($lc_cm);
}

1;

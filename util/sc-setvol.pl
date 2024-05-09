
# util/sc-setvol.pl -- Repeatedly rings bell to allow volume adjustment
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
use strict;

while ( 2 > 1 )
{
  print "BELLRING\n"; &plm::bellring::ring();

  print "Waiting 5:\n"; sleep(1);
  print "Waiting 4:\n"; sleep(1);
  print "Waiting 3:\n"; sleep(1);
  print "Waiting 2:\n"; sleep(1);
  print "Waiting 1:\n"; sleep(1);
}

1;
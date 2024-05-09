# install.pl -- Install-script for the wrapper script
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

use Cwd 'abs_path';
use File::Basename;
use strict;

my $var_inslocat = abs_path($0);
my $var_locat = dirname($var_inslocat);

my $var_homedir;
{
  $var_homedir = $ENV{'HOME'};
  if ( $var_homedir eq '' )
  {
    $var_homedir = `( cd && pwd )`; chomp($var_homedir);
  }
}

my $var_bindir = $var_homedir . '/bin';
if ( ! ( -d $var_bindir ) )
{
  die "\nWe need the directory: $var_bindir :\n\n";
}

my $var_binwrap = $var_bindir . '/metatemple-bell';

#print $var_locat . "\n";
#print $var_homedir . "\n";

my $var_catcon = `cat $var_locat/preres/wrap.pl`;

open TAK, ("|cat > " . $var_binwrap);

print TAK "#! /usr/bin/perl\nuse strict;\n";
print TAK "my \$homeland = \"" . $var_locat . "\";\n";

print TAK $var_catcon;

close TAK;

#system('cat ' . $var_binwrap);

system('chmod','755',$var_binwrap);
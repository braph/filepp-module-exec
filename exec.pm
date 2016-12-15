########################################################################
#
# exec is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.  If not, write to
# the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
#
########################################################################
#
#  Project      :  File Preprocessor - exec module
#  Filename     :  exec.pm
#  Author       :  Benjamin Abendroth
#  Description  :  This module allows execution of external programs
#  Licence      :  GNU copyleft
#
########################################################################
# THIS IS A FILEPP MODULE, YOU NEED FILEPP TO USE IT!!!
# usage: filepp -m exec.pm <files>
########################################################################

package Exec;

use strict;

# version number of module
my $VERSION = '0.0.1';

require "function.pm";

use IPC::System::Simple qw(capture capturex);

sub Exec
{
    return capturex(@_);
}
Function::AddFunction("filepp_exec", "Exec::Exec");

sub ShellExec
{
    return capture(@_);
}
Function::AddFunction("filepp_shell_exec", "Exec::ShellExec");

return 1;

########################################################################
# End of file
########################################################################


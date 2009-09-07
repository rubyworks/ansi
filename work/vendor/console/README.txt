
This file implements a port of Perl's Win32::Console
and Win32::Console::ANSI modules.

Win32::Console allows controling the windows command line terminal
thru an OO-interface.  This allows you to query the terminal (find
its size, characters, attributes, etc).  The interface and functionality
should be identical to Perl's.

Win32::Console consists of a Ruby .rb interface.
For best performance, this library has been also ported to C.  
If you lack a C compiler, you can still use the class thru the ruby
interface.  If you can compile it, then the ruby interface is not
used and the C functions are called instead.

Win32::Console::ANSI is a class derived from IO that seamlessly
translates ANSI Esc control character codes into Windows' command.exe 
or cmd.exe equivalents.

These modules allow you to develop command-line tools that can take 
advantage of the unix terminal functions while still being portable.
One of the most common uses for this is to allow to color your
output.
The modules are disted with Term/ansicolor.rb, too, as it is a nice
thing to verify it is working properly.


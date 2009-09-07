#################################################################
#
# To compile and install, do this:
#
# Make sure your compiling environment is in your path.
# In the case of MSVC, this involves running vcvars32.bat first
# which is located in the bin directory of MS Visual C++.
#
# Then:
#
# > ruby extconf.rb
# > nmake Makefile
# > nmake install
#
#
##################################################################
require 'mkmf'
create_makefile('Console')

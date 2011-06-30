
SHELL = /bin/sh

#### Start of system configuration section. ####

srcdir = C:/ruby/visualc/Console
topdir = $(rubylibdir)/$(arch)
hdrdir = $(rubylibdir)/$(arch)
VPATH = $(srcdir)

DESTDIR = c:
prefix = $(DESTDIR)/ruby
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
sitelibdir = $(sitedir)/$(ruby_version)
datadir = $(prefix)/share
sitedir = $(prefix)/lib/ruby/site_ruby
sharedstatedir = $(DESTDIR)/etc
archdir = $(rubylibdir)/$(arch)
localstatedir = $(DESTDIR)/var
infodir = $(prefix)/info
oldincludedir = $(DESTDIR)/usr/include
libexecdir = $(exec_prefix)/libexec
compile_dir = $(DESTDIR)/WINDOWS/Escritorio/Programacion/ruby/win32
sbindir = $(exec_prefix)/sbin
includedir = $(prefix)/include
sysconfdir = $(prefix)/etc
sitearchdir = $(sitelibdir)/$(sitearch)
mandir = $(prefix)/man
libdir = $(exec_prefix)/lib
rubylibdir = $(libdir)/ruby/$(ruby_version)

CC = cl -nologo
LIBRUBY = $(RUBY_SO_NAME).lib
LIBRUBY_A = $(RUBY_SO_NAME)-static.lib
LIBRUBYARG_SHARED = $(LIBRUBY)
LIBRUBYARG_STATIC = $(LIBRUBY_A)

CFLAGS   =  -MD -Zi -O2b2xg- -G6 
CPPFLAGS = -I. -I$(topdir) -I$(hdrdir) -I$(srcdir)  -I. -I./.. -I./../missing
CXXFLAGS = $(CFLAGS) 
DLDFLAGS =  -link -incremental:no -debug -opt:ref -opt:icf -dll $(LIBPATH) -def:$(DEFFILE) 
LDSHARED = cl -nologo -LD
AR = lib -nologo
EXEEXT = .exe

RUBY_INSTALL_NAME = ruby
RUBY_SO_NAME = msvcrt-ruby18
arch = i386-mswin32
sitearch = i386-msvcrt
ruby_version = 1.8
RUBY = ruby
RM = $(RUBY) -run -e rm -- -f
MAKEDIRS = $(RUBY) -run -e mkdir -- -p
INSTALL_PROG = $(RUBY) -run -e install -- -vpm 0755
INSTALL_DATA = $(RUBY) -run -e install -- -vpm 0644

#### End of system configuration section. ####


LIBPATH =  -libpath:"$(libdir)"
DEFFILE = $(TARGET)-$(arch).def

CLEANFILES = 
DISTCLEANFILES = $(DEFFILE)

target_prefix = 
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED)  oldnames.lib user32.lib advapi32.lib wsock32.lib  
OBJS = Console.obj
TARGET = Console
DLLIB = $(TARGET).so
STATIC_LIB = $(TARGET).lib

RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR    = $(sitelibdir)$(target_prefix)
RUBYARCHDIR   = $(sitearchdir)$(target_prefix)

CLEANLIBS     = "$(TARGET).{lib,exp,il?,tds,map}" $(DLLIB)
CLEANOBJS     = "*.{obj,lib,s[ol],pdb,bak}"

all:		$(DLLIB)
static:		$(STATIC_LIB)

clean:
		@$(RM) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES)

distclean:	clean
		@$(RM) Makefile extconf.h conftest.* mkmf.log
		@$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)

realclean:	distclean
install: $(RUBYARCHDIR)
install: $(RUBYARCHDIR)/$(DLLIB)
$(RUBYARCHDIR)/$(DLLIB): $(DLLIB) $(RUBYARCHDIR)
	@$(INSTALL_PROG) $(DLLIB) $(RUBYARCHDIR)
install: $(RUBYLIBDIR)/Win32
install: $(RUBYLIBDIR)/Win32/Console.rb
$(RUBYLIBDIR)/Win32/Console.rb: $(srcdir)/lib/Win32/Console.rb $(RUBYLIBDIR)/Win32
	@$(INSTALL_DATA) $(srcdir)/lib/Win32/Console.rb $(RUBYLIBDIR)/Win32
install: $(RUBYLIBDIR)/Win32/Console
install: $(RUBYLIBDIR)/Win32/Console/ANSI.rb
$(RUBYLIBDIR)/Win32/Console/ANSI.rb: $(srcdir)/lib/Win32/Console/ANSI.rb $(RUBYLIBDIR)/Win32/Console
	@$(INSTALL_DATA) $(srcdir)/lib/Win32/Console/ANSI.rb $(RUBYLIBDIR)/Win32/Console
install: $(RUBYLIBDIR)/Term
install: $(RUBYLIBDIR)/Term/ansicolor.rb
$(RUBYLIBDIR)/Term/ansicolor.rb: $(srcdir)/lib/Term/ansicolor.rb $(RUBYLIBDIR)/Term
	@$(INSTALL_DATA) $(srcdir)/lib/Term/ansicolor.rb $(RUBYLIBDIR)/Term
$(RUBYARCHDIR):
	@$(MAKEDIRS) $(RUBYARCHDIR)
$(RUBYLIBDIR)/Win32:
	@$(MAKEDIRS) $(RUBYLIBDIR)/Win32
$(RUBYLIBDIR)/Win32/Console:
	@$(MAKEDIRS) $(RUBYLIBDIR)/Win32/Console
$(RUBYLIBDIR)/Term:
	@$(MAKEDIRS) $(RUBYLIBDIR)/Term

site-install: install

.SUFFIXES: .c .cc .m .cxx .cpp .C .obj

{$(srcdir)}.cc{}.obj:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -Tp$(<:\=/)

.cc.obj:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -Tp$(<:\=/)

{$(srcdir)}.cpp{}.obj:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -Tp$(<:\=/)

.cpp.obj:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -Tp$(<:\=/)

{$(srcdir)}.cxx{}.obj:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -Tp$(<:\=/)

.cxx.obj:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -Tp$(<:\=/)

{$(srcdir)}.C{}.obj:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -Tp$(<:\=/)

.C.obj:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -Tp$(<:\=/)

{$(srcdir)}.c{}.obj:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -Tc$(<:\=/)

.c.obj:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -Tc$(<:\=/)

$(DLLIB): $(OBJS) $(DEFFILE)
	@-$(RM) $@
	@-$(RM) $(TARGET).lib
	$(LDSHARED) -Fe$(@) $(OBJS) $(LIBS) $(LOCAL_LIBS) $(DLDFLAGS)

$(STATIC_LIB): $(OBJS)
	$(AR) -machine:x86 -out:$@ $(OBJS)

$(DEFFILE): 
	$(RUBY) -e "puts 'EXPORTS', 'Init_$(TARGET)'"  > $@


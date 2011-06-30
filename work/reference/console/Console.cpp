
#include "windows.h"
#include "ruby.h"

#ifdef WIN32
#define CONSOLE_EXPORT __declspec(dllexport)
#else
#error Not compiling on Windows
#endif

VALUE rb_mWin32;
VALUE rb_mConsole;
VALUE rb_mAPI;
VALUE rb_mConstants;

/* old RUBY_METHOD_FUNC() definition doesn't match to prototypes in those days. */
#ifndef ANYARGS
#undef  RUBY_METHOD_FUNC
#define RUBY_METHOD_FUNC(func) ((VALUE (*)())func)
#endif


#define RB_DEF_S_METHOD(klass,method,func,argtype) \
     rb_define_singleton_method(klass,method,RUBY_METHOD_FUNC(func), argtype)

#define RB_DEF_API_METHOD(name,argtype) \
     RB_DEF_S_METHOD(rb_mAPI,#name,RUBY_METHOD_FUNC(rb_##name), argtype)

#define RB_DEF_METHOD(klass,method,func,argtype) \
        rb_define_method(klass,method,RUBY_METHOD_FUNC(func), argtype)

VALUE
rb_getWin32Error()
{
   DWORD e = GetLastError();
   LPVOID lpMsgBuf;
   if (!FormatMessage( 
		      FORMAT_MESSAGE_ALLOCATE_BUFFER | 
		      FORMAT_MESSAGE_FROM_SYSTEM | 
		      FORMAT_MESSAGE_IGNORE_INSERTS,
		      NULL,
		      GetLastError(),
		      MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
		      (LPTSTR) &lpMsgBuf,
		      0,
		      NULL ))
   {
      // Handle the error.
      return Qnil;
   }

   VALUE t = rb_str_new2( (LPCTSTR) lpMsgBuf );
   
   // Free the buffer.
   LocalFree( lpMsgBuf );

   // Raise exception
   rb_raise(rb_eRuntimeError, RSTRING(t)->ptr);
   return Qnil;

}


extern "C"
{

static VALUE rb_GetStdHandle(VALUE self, VALUE handle)
{
   unsigned long x;
   if ( FIXNUM_P( handle ) )
   {
      x = NUM2ULONG( handle );
   }
   else
   {
      Check_Type( handle, T_BIGNUM );
      x = rb_big2ulong(handle);
   }
   unsigned long h = PtrToUlong( GetStdHandle( x ) );
   return ULONG2NUM(h);
}


static VALUE rb_AllocConsole(VALUE self)
{
   if (AllocConsole()) return INT2FIX(1);
   return rb_getWin32Error();
}


static VALUE rb_FreeConsole(VALUE self)
{
   if (FreeConsole()) return INT2FIX(1);
   return rb_getWin32Error();
}

static VALUE rb_GenerateConsoleCtrlEvent(VALUE self, VALUE event, VALUE pgid)
{
   unsigned int e = NUM2UINT(event);
   if ( e != CTRL_C_EVENT && e != CTRL_BREAK_EVENT )
      rb_raise(rb_eArgError, "Wrong event: only CTRL_C_EVENT or "
	       "CTRL_BREAK_EVENT accepted.");
   if ( GenerateConsoleCtrlEvent(e, NUM2UINT(pgid)) )
      return INT2FIX(1);
   return rb_getWin32Error();
}

static VALUE rb_GetConsoleMode(VALUE self, VALUE hConsoleOutput)
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   DWORD mode;
   if (GetConsoleMode(handle,&mode))
      return UINT2NUM(mode);
   return rb_getWin32Error();
}

static VALUE rb_GetConsoleTitle(VALUE self)
{
   char title[1024];
   if (GetConsoleTitle((char*)&title,1024))
      return  rb_str_new2( title );
   return rb_getWin32Error();
}




static VALUE rb_GetNumberOfConsoleMouseButtons( VALUE self )
{
   DWORD mb;
   if (GetNumberOfConsoleMouseButtons( &mb ))
      return INT2FIX(mb);
   return rb_getWin32Error();
}



static VALUE rb_GetNumberOfConsoleInputEvents( VALUE self, VALUE hConsoleOutput )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   DWORD events;
   if (GetNumberOfConsoleInputEvents(handle, &events))
      return INT2FIX(events);
   return rb_getWin32Error();
}


static VALUE
rb_CreateConsoleScreenBuffer( VALUE self, VALUE dwDesiredAccess,
				  VALUE dwShareMode, VALUE dwFlags )
{
   if (CreateConsoleScreenBuffer( NUM2UINT(dwDesiredAccess),
				      NUM2UINT( dwShareMode),
				      NULL,
				      NUM2UINT( dwFlags),
				      NULL
				      ))
      return INT2FIX(1);
   return rb_getWin32Error();
}


static VALUE rb_GetConsoleCP( VALUE self )
{
   unsigned int h = GetConsoleCP();
   return UINT2NUM(h);
}

static VALUE rb_GetConsoleOutputCP( VALUE self )
{
   unsigned int h = GetConsoleOutputCP();
   return UINT2NUM(h);
}

static VALUE rb_SetConsoleMode( VALUE self, VALUE hConsoleOutput,
				VALUE Mode )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   if ( SetConsoleMode( handle, NUM2UINT( Mode ) ) )
      return INT2FIX(1);
   return rb_getWin32Error();
}

static VALUE rb_SetConsoleCP( VALUE self, VALUE wCodePageID )
{
   if ( SetConsoleCP( NUM2UINT( wCodePageID ) ) )
      return INT2FIX(1);
   return rb_getWin32Error();
}

static VALUE rb_SetConsoleOutputCP( VALUE self, VALUE wCodePageID )
{
   if ( SetConsoleOutputCP( NUM2UINT( wCodePageID ) ) )
      return INT2FIX(1);
   return rb_getWin32Error();
}

static VALUE rb_GetConsoleWindow( VALUE self )
{
   unsigned long h = PtrToUlong( GetConsoleOutputCP() );
   return ULONG2NUM(h);
}

static VALUE rb_WriteConsole( VALUE self, VALUE hConsoleOutput,
			      VALUE lpBuffer )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   DWORD nNumberOfCharsToWrite = RSTRING(lpBuffer)->len;
   
   DWORD lpNumberOfCharsWritten;

   WriteConsole( handle, RSTRING(lpBuffer)->ptr,
		 nNumberOfCharsToWrite,
		 &lpNumberOfCharsWritten, NULL );
   return UINT2NUM( lpNumberOfCharsWritten );
}


static VALUE rb_GetLargestConsoleWindowSize( VALUE self, VALUE hConsoleOutput )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   COORD size = GetLargestConsoleWindowSize( handle);
   
   VALUE ret = rb_ary_new();
   rb_ary_push( ret, UINT2NUM( size.X ) );
   rb_ary_push( ret, UINT2NUM( size.Y ) );
   return ret;
}

static VALUE rb_GetConsoleCursorInfo( VALUE self, VALUE hConsoleOutput )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   
   CONSOLE_CURSOR_INFO out;
   if ( !GetConsoleCursorInfo( handle, &out ) )
      return rb_getWin32Error();
   
   VALUE ret = rb_ary_new();
   rb_ary_push( ret, UINT2NUM( out.dwSize ) );
   rb_ary_push( ret, UINT2NUM( out.bVisible ) );
   return ret;
}

void rb_ParseEvent(VALUE ret, INPUT_RECORD& event )
{
   switch(event.EventType) {
      case KEY_EVENT:
	 {
	    KEY_EVENT_RECORD* kevent=(KEY_EVENT_RECORD *)&(event.Event);
	    rb_ary_push(ret, UINT2NUM(KEY_EVENT));
	    rb_ary_push(ret, UINT2NUM(kevent->bKeyDown));
	    rb_ary_push(ret, UINT2NUM(kevent->wRepeatCount));
	    rb_ary_push(ret, UINT2NUM(kevent->wVirtualKeyCode));
	    rb_ary_push(ret, UINT2NUM(kevent->wVirtualScanCode));
#ifdef UNICODE
	    rb_ary_push(ret, UINT2NUM(kevent->uChar.UnicodeChar));
#else
	    rb_ary_push(ret, UINT2NUM(kevent->uChar.AsciiChar));
#endif
	    rb_ary_push(ret, UINT2NUM(kevent->dwControlKeyState));
	    break;
	 }
      case MOUSE_EVENT:
	 {
	    MOUSE_EVENT_RECORD * mevent=(MOUSE_EVENT_RECORD *)&(event.Event);
	    rb_ary_push(ret, UINT2NUM(MOUSE_EVENT) );
	    rb_ary_push(ret, UINT2NUM(mevent->dwMousePosition.X) );
	    rb_ary_push(ret, UINT2NUM(mevent->dwMousePosition.Y) );
	    rb_ary_push(ret, UINT2NUM(mevent->dwButtonState) );
	    rb_ary_push(ret, UINT2NUM(mevent->dwControlKeyState) );
	    rb_ary_push(ret, UINT2NUM(mevent->dwEventFlags) );
	    break;
	 }
      case WINDOW_BUFFER_SIZE_EVENT:
	 {
	    WINDOW_BUFFER_SIZE_RECORD* wevent=
	    (WINDOW_BUFFER_SIZE_RECORD *)&(event.Event);
	    rb_ary_push(ret, UINT2NUM(WINDOW_BUFFER_SIZE_EVENT) );
	    rb_ary_push(ret, UINT2NUM(wevent->dwSize.X) );
	    rb_ary_push(ret, UINT2NUM(wevent->dwSize.Y) );
	 }
	 break;
      case MENU_EVENT:
	 {
	    MENU_EVENT_RECORD* mevent= (MENU_EVENT_RECORD *)&(event.Event);
	    rb_ary_push(ret, UINT2NUM(MENU_EVENT) );
	    rb_ary_push(ret, UINT2NUM(mevent->dwCommandId) );
	 }
	 break;
      case FOCUS_EVENT:
	 {
	    FOCUS_EVENT_RECORD* mevent= (FOCUS_EVENT_RECORD *)&(event.Event);
	    rb_ary_push(ret, UINT2NUM(FOCUS_EVENT) );
	    rb_ary_push(ret, UINT2NUM(mevent->bSetFocus) );
	 }
	 break;
   }
}

static VALUE rb_PeekConsoleInput( VALUE self, VALUE hConsoleOutput )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   
   DWORD nofread;
   INPUT_RECORD event;
   if (!PeekConsoleInput(handle,&event,1,&nofread))
      return rb_getWin32Error();
   
   VALUE ret = rb_ary_new();
   rb_ParseEvent( ret, event );
   return ret;
}

static VALUE rb_ReadConsole( VALUE self, VALUE hConsoleOutput,
				  VALUE buffer, VALUE numread )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   DWORD nofread;
   Check_Type( buffer, T_STRING );
   int to_read = NUM2INT(numread);
   if ( RSTRING(buffer)->len > to_read )
      rb_raise(rb_eArgError, "String is too small to read that many characters.");
   if (ReadConsole(handle,(void *)RSTRING(buffer)->ptr, to_read,
		   &nofread,NULL))
      return UINT2NUM(nofread);
   return rb_getWin32Error();
}

static VALUE rb_ReadConsoleInput( VALUE self, VALUE hConsoleOutput )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   DWORD nofread;
   INPUT_RECORD event;
   if (!ReadConsoleInput(handle,&event,1,&nofread))
      return rb_getWin32Error();
   
   VALUE ret = rb_ary_new();
   rb_ParseEvent( ret, event );
   return ret;
}



static VALUE rb_ReadConsoleOutputCharacter( VALUE self, VALUE hConsoleOutput,
					    VALUE charbuf, VALUE len,
					    VALUE x, VALUE y )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   COORD coords;
   DWORD nofread;
   coords.X= NUM2UINT( x );
   coords.Y= NUM2UINT( y );
   int l = NUM2INT(len);
   if ( RSTRING(charbuf)->len < l*sizeof(TCHAR) )
      rb_raise(rb_eArgError, "String is too small to read that many characters.");
   if (ReadConsoleOutputCharacter(handle,RSTRING(charbuf)->ptr,l,
				  coords,&nofread))
      return UINT2NUM( nofread );
   return rb_getWin32Error();
}


static VALUE rb_ReadConsoleOutputAttribute( VALUE self, VALUE hConsoleOutput,
					    VALUE len, VALUE x, VALUE y )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   COORD coords;
   DWORD nofread;
   unsigned short abuffer[80*999*sizeof(unsigned short)];
   char cbuffer[80*999];
   coords.X= NUM2UINT( x );
   coords.Y= NUM2UINT( y );
   if (ReadConsoleOutputAttribute(handle, abuffer, NUM2UINT(len),
				  coords,&nofread))
   {
      for(unsigned i=0;i<nofread;++i) {
	 cbuffer[i]=(char)abuffer[i];
      }
      return rb_str_new( cbuffer, nofread );
   }
   return rb_getWin32Error();
}


static VALUE rb_ReadConsoleOutput( VALUE self, VALUE hConsoleOutput,
				   VALUE buffer, VALUE srcwid, VALUE srcht,
				   VALUE startx, VALUE starty,
				   VALUE l, VALUE t, VALUE r, VALUE b )
{
   COORD coords;
   COORD size;
   SMALL_RECT from;
   size.X= NUM2UINT( srcwid );
   size.Y= NUM2UINT( srcht );
   coords.X= NUM2INT( startx );
   coords.Y= NUM2INT( starty );
   from.Left   = NUM2INT( l );
   from.Top    = NUM2INT( t );
   from.Right  = NUM2INT( r );
   from.Bottom = NUM2INT( b );
   Check_Type( buffer, T_STRING );
   if ( RSTRING(buffer)->len < (sizeof(CHAR_INFO)*size.X*size.Y) )
      rb_raise(rb_eArgError, "string buffer is too small for reading that many characters.");
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   if (!ReadConsoleOutput(handle,(CHAR_INFO *)RSTRING(buffer)->ptr,size,coords,&from))
      return rb_getWin32Error();

   VALUE ret = rb_ary_new();
   rb_ary_push( ret, INT2FIX(from.Left) );
   rb_ary_push( ret, INT2FIX(from.Top) );
   rb_ary_push( ret, INT2FIX(from.Right) );
   rb_ary_push( ret, INT2FIX(from.Bottom) );
   return ret;
}



static VALUE rb_GetConsoleScreenBufferInfo( VALUE self, VALUE hConsoleOutput )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );

   CONSOLE_SCREEN_BUFFER_INFO out;

   if ( !GetConsoleScreenBufferInfo( handle, &out ) )
      return rb_getWin32Error();

   VALUE ret = rb_ary_new();
   rb_ary_push( ret, UINT2NUM( out.dwSize.X ) );
   rb_ary_push( ret, UINT2NUM( out.dwSize.Y ) );
   rb_ary_push( ret, UINT2NUM( out.dwCursorPosition.X ) );
   rb_ary_push( ret, UINT2NUM( out.dwCursorPosition.Y ) );
   
   rb_ary_push( ret, UINT2NUM( out.wAttributes ) );
   
   rb_ary_push( ret, INT2FIX( out.srWindow.Left ) );
   rb_ary_push( ret, INT2FIX( out.srWindow.Top ) );
   rb_ary_push( ret, INT2FIX( out.srWindow.Right ) );
   rb_ary_push( ret, INT2FIX( out.srWindow.Bottom ) );
   
   rb_ary_push( ret, UINT2NUM( out.dwMaximumWindowSize.X ) );
   rb_ary_push( ret, UINT2NUM( out.dwMaximumWindowSize.Y ) );

   
   return ret;
}


#define strEQ(x,y) strcmp(x,y) == 0

DWORD c_constant(char *name)
{
   switch (*name) {
    case 'A':
        break;
    case 'B':
        if (strEQ(name, "BACKGROUND_BLUE"))
            #ifdef BACKGROUND_BLUE
                return BACKGROUND_BLUE;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "BACKGROUND_GREEN"))
            #ifdef BACKGROUND_GREEN
                return BACKGROUND_GREEN;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "BACKGROUND_INTENSITY"))
            #ifdef BACKGROUND_INTENSITY
                return BACKGROUND_INTENSITY;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "BACKGROUND_RED"))
            #ifdef BACKGROUND_RED
                return BACKGROUND_RED;
            #else
                goto not_there;
            #endif
        break;
    case 'C':
       if (strEQ(name, "CAPSLOCK_ON"))
            #ifdef CAPSLOCK_ON
                return CAPSLOCK_ON;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "CONSOLE_TEXTMODE_BUFFER"))
            #ifdef CONSOLE_TEXTMODE_BUFFER
                return CONSOLE_TEXTMODE_BUFFER;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "CTRL_BREAK_EVENT"))
            #ifdef CTRL_BREAK_EVENT
                return CTRL_BREAK_EVENT;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "CTRL_C_EVENT"))
            #ifdef CTRL_C_EVENT
                return CTRL_C_EVENT;
            #else
                goto not_there;
            #endif
		break;

    case 'D':
        break;
    case 'E':
        if (strEQ(name, "ENABLE_ECHO_INPUT"))
            #ifdef ENABLE_ECHO_INPUT
                return ENABLE_ECHO_INPUT;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "ENABLE_LINE_INPUT"))
            #ifdef ENABLE_LINE_INPUT
                return ENABLE_LINE_INPUT;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "ENABLE_MOUSE_INPUT"))
            #ifdef ENABLE_MOUSE_INPUT
                return ENABLE_MOUSE_INPUT;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "ENABLE_PROCESSED_INPUT"))
            #ifdef ENABLE_PROCESSED_INPUT
                return ENABLE_PROCESSED_INPUT;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "ENABLE_PROCESSED_OUTPUT"))
            #ifdef ENABLE_PROCESSED_OUTPUT
                return ENABLE_PROCESSED_OUTPUT;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "ENABLE_WINDOW_INPUT"))
            #ifdef ENABLE_WINDOW_INPUT
                return ENABLE_WINDOW_INPUT;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "ENABLE_WRAP_AT_EOL_OUTPUT"))
            #ifdef ENABLE_WRAP_AT_EOL_OUTPUT
                return ENABLE_WRAP_AT_EOL_OUTPUT;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "ENHANCED_KEY"))
            #ifdef ENHANCED_KEY
                return ENHANCED_KEY;
            #else
                goto not_there;
            #endif
        break;
    case 'F':
        if (strEQ(name, "FILE_SHARE_READ"))
            #ifdef FILE_SHARE_READ
                return FILE_SHARE_READ;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "FILE_SHARE_WRITE"))
            #ifdef FILE_SHARE_WRITE
                return FILE_SHARE_WRITE;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "FOREGROUND_BLUE"))
            #ifdef FOREGROUND_BLUE
                return FOREGROUND_BLUE;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "FOREGROUND_GREEN"))
            #ifdef FOREGROUND_GREEN
                return FOREGROUND_GREEN;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "FOREGROUND_INTENSITY"))
            #ifdef FOREGROUND_INTENSITY
                return FOREGROUND_INTENSITY;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "FOREGROUND_RED"))
            #ifdef FOREGROUND_RED
                return FOREGROUND_RED;
            #else
                goto not_there;
            #endif
        break;
    case 'G':
        if (strEQ(name, "GENERIC_READ"))
            #ifdef GENERIC_READ
                return GENERIC_READ;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "GENERIC_WRITE"))
            #ifdef GENERIC_WRITE
                return GENERIC_WRITE;
            #else
                goto not_there;
            #endif
        break;
    case 'H':
        break;
    case 'I':
        break;
    case 'J':
        break;
    case 'K':
        if (strEQ(name, "KEY_EVENT"))
            #ifdef KEY_EVENT
                return KEY_EVENT;
            #else
                goto not_there;
            #endif
        break;
    case 'L':
        if (strEQ(name, "LEFT_ALT_PRESSED"))
            #ifdef LEFT_ALT_PRESSED
                return LEFT_ALT_PRESSED;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "LEFT_CTRL_PRESSED"))
            #ifdef LEFT_CTRL_PRESSED
                return LEFT_CTRL_PRESSED;
            #else
                goto not_there;
            #endif
		break;
    case 'M':
        break;
    case 'N':
        if (strEQ(name, "NUMLOCK_ON"))
            #ifdef NUMLOCK_ON
                return NUMLOCK_ON;
            #else
                goto not_there;
            #endif
        break;
    case 'O':
        break;
    case 'P':
        break;
    case 'Q':
        break;
    case 'R':
        if (strEQ(name, "RIGHT_ALT_PRESSED"))
            #ifdef RIGHT_ALT_PRESSED
                return RIGHT_ALT_PRESSED;
            #else
                goto not_there;
            #endif
        if (strEQ(name, "RIGHT_CTRL_PRESSED"))
            #ifdef RIGHT_CTRL_PRESSED
                return RIGHT_CTRL_PRESSED;
            #else
                goto not_there;
            #endif
		break;
    case 'S':
		if (strEQ(name, "SCROLLLOCK_ON"))
			#ifdef SCROLLLOCK_ON
				return SCROLLLOCK_ON;
			#else
				goto not_there;
			#endif
		if (strEQ(name, "SHIFT_PRESSED"))
			#ifdef SHIFT_PRESSED
				return SHIFT_PRESSED;
			#else
				goto not_there;
			#endif
		if (strEQ(name, "STD_ERROR_HANDLE"))
			#ifdef STD_ERROR_HANDLE
				return STD_ERROR_HANDLE;
			#else
				goto not_there;
			#endif
		if (strEQ(name, "STD_INPUT_HANDLE"))
			#ifdef STD_INPUT_HANDLE
				return STD_INPUT_HANDLE;
			#else
				goto not_there;
			#endif
		if (strEQ(name, "STD_OUTPUT_HANDLE"))
			#ifdef STD_OUTPUT_HANDLE
				return STD_OUTPUT_HANDLE;
			#else
				goto not_there;
			#endif
        break;
    case 'T':
        break;
    case 'U':
        break;
    case 'V':
        break;
    case 'W':
        break;
    case 'X':
        break;
    case 'Y':
        break;
    case 'Z':
        break;
    }
    rb_raise(rb_eArgError, "Not such constant.");
    return 0;

not_there:
    rb_raise(rb_eArgError, "Not defined.");
    return 0;
}

VALUE rb_constant( VALUE self, VALUE name )
{
   Check_Type( name, T_STRING );
   return ULONG2NUM( c_constant( RSTRING(name)->ptr ) );
}


void define_constants()
{
#define DEF_SELF_CONST(NAME) \
   rb_define_const(rb_mConstants, #NAME, ULONG2NUM( (ULONG)NAME ) );

   DEF_SELF_CONST(  STD_INPUT_HANDLE          );
   DEF_SELF_CONST(  STD_OUTPUT_HANDLE         );
   DEF_SELF_CONST(  STD_ERROR_HANDLE          );
   DEF_SELF_CONST(  INVALID_HANDLE_VALUE      );
   DEF_SELF_CONST(  GENERIC_READ              );
   DEF_SELF_CONST(  GENERIC_WRITE             );
   DEF_SELF_CONST(  FILE_SHARE_READ           );
   DEF_SELF_CONST(  FILE_SHARE_WRITE          );
   DEF_SELF_CONST(  CONSOLE_TEXTMODE_BUFFER   );

   DEF_SELF_CONST(  FOREGROUND_BLUE           );
   DEF_SELF_CONST(  FOREGROUND_GREEN          );
   DEF_SELF_CONST(  FOREGROUND_RED            );
   DEF_SELF_CONST(  FOREGROUND_INTENSITY      );
   DEF_SELF_CONST(  BACKGROUND_BLUE           );
   DEF_SELF_CONST(  BACKGROUND_GREEN          );
   DEF_SELF_CONST(  BACKGROUND_RED            );
   DEF_SELF_CONST(  BACKGROUND_INTENSITY      );

   DEF_SELF_CONST(  ENABLE_PROCESSED_INPUT    );
   DEF_SELF_CONST(  ENABLE_LINE_INPUT         );
   DEF_SELF_CONST(  ENABLE_ECHO_INPUT         );
   DEF_SELF_CONST(  ENABLE_WINDOW_INPUT       );
   DEF_SELF_CONST(  ENABLE_MOUSE_INPUT        );
   DEF_SELF_CONST(  ENABLE_PROCESSED_OUTPUT   );
   DEF_SELF_CONST(  ENABLE_WRAP_AT_EOL_OUTPUT );

   DEF_SELF_CONST(  KEY_EVENT                 );
   DEF_SELF_CONST(  MOUSE_EVENT               );
   DEF_SELF_CONST(  WINDOW_BUFFER_SIZE_EVENT  );
   DEF_SELF_CONST(  MENU_EVENT                );
   DEF_SELF_CONST(  FOCUS_EVENT               );

   DEF_SELF_CONST(  CAPSLOCK_ON               );
   DEF_SELF_CONST(  ENHANCED_KEY              );
   DEF_SELF_CONST(  NUMLOCK_ON                );
   DEF_SELF_CONST(  SHIFT_PRESSED             );
   DEF_SELF_CONST(  LEFT_CTRL_PRESSED         );
   DEF_SELF_CONST(  RIGHT_CTRL_PRESSED        );
   DEF_SELF_CONST(  LEFT_ALT_PRESSED          );
   DEF_SELF_CONST(  RIGHT_ALT_PRESSED         );
   DEF_SELF_CONST(  SCROLLLOCK_ON             );

   DEF_SELF_CONST(  MOUSE_WHEELED             );
   DEF_SELF_CONST(  DOUBLE_CLICK              );
   DEF_SELF_CONST(  MOUSE_MOVED               );

   DEF_SELF_CONST(  FROM_LEFT_1ST_BUTTON_PRESSED    );
   DEF_SELF_CONST(  FROM_LEFT_2ND_BUTTON_PRESSED    );
   DEF_SELF_CONST(  FROM_LEFT_3RD_BUTTON_PRESSED    );
   DEF_SELF_CONST(  FROM_LEFT_4TH_BUTTON_PRESSED    );
   DEF_SELF_CONST(  RIGHTMOST_BUTTON_PRESSED        );

   DEF_SELF_CONST(  CTRL_C_EVENT              );
   DEF_SELF_CONST(  CTRL_BREAK_EVENT          );
   DEF_SELF_CONST(  CTRL_CLOSE_EVENT          );
   DEF_SELF_CONST(  CTRL_LOGOFF_EVENT         );
   DEF_SELF_CONST(  CTRL_SHUTDOWN_EVENT       );
}


VALUE
rb_FillConsoleOutputAttribute( VALUE self, VALUE hConsoleOutput,
			       VALUE wAttribute, VALUE nLength,
			       VALUE col, VALUE row )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );

   COORD dwWriteCoord;
   dwWriteCoord.X = NUM2UINT(col);
   dwWriteCoord.Y = NUM2UINT(row);
   DWORD numChars;
   if (FillConsoleOutputAttribute( handle, NUM2UINT(wAttribute),
				   NUM2ULONG(nLength), dwWriteCoord,
				   &numChars ))
      return ULONG2NUM(numChars);
   return rb_getWin32Error();
}

VALUE
rb_SetConsoleScreenBufferSize( VALUE self, VALUE hConsoleOutput,
			       VALUE x, VALUE y )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   COORD size;
   size.X=NUM2UINT(x);
   size.Y=NUM2UINT(y);
   if (SetConsoleScreenBufferSize(handle, size))
      return NUM2UINT(1);
   return rb_getWin32Error();
}

VALUE
rb_SetConsoleTitle( VALUE self, VALUE title )
{
   Check_Type( title, T_STRING );
   if (SetConsoleTitle(RSTRING( title )->ptr))
      return NUM2UINT(1);
   return rb_getWin32Error();
}

VALUE
rb_SetStdHandle( VALUE self, VALUE fd, VALUE hConsoleOutput )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   if (SetStdHandle(NUM2UINT(fd), handle))
      return NUM2UINT(1);
   return rb_getWin32Error();
}

VALUE
rb_SetConsoleWindowInfo( VALUE self, VALUE hConsoleOutput, VALUE bAbsolute, 
			 VALUE left, VALUE top, VALUE right, VALUE bottom )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   
   SMALL_RECT rect;
   rect.Left   = NUM2INT( left );
   rect.Top    = NUM2INT( top );
   rect.Right  = NUM2INT( right );
   rect.Bottom = NUM2INT( bottom );
   if (SetConsoleWindowInfo( handle, NUM2INT( bAbsolute ), &rect ))
      return UINT2NUM(1);
   return rb_getWin32Error();
}



VALUE
rb_SetConsoleCursorPosition( VALUE self, VALUE hConsoleOutput,
			     VALUE col, VALUE row )
{  
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );

   COORD dwWriteCoord;
   dwWriteCoord.X = NUM2UINT(col);
   dwWriteCoord.Y = NUM2UINT(row);
   // Cannot call rb_getWin32Error as this function fails when
   // setting cursor to last column/row.
   if ( !SetConsoleCursorPosition( handle, dwWriteCoord ) )
      return Qnil;
   return INT2FIX(1);
}

VALUE
rb_SetConsoleCursorInfo( VALUE self, VALUE hConsoleOutput,
			 VALUE size, VALUE visib )
{  
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   CONSOLE_CURSOR_INFO c;
   c.dwSize = NUM2UINT(size);
   c.bVisible = NUM2UINT(visib);
   if ( !SetConsoleCursorInfo( handle, &c ) )
      return rb_getWin32Error();
   return INT2FIX(1);
}



VALUE
rb_SetConsoleActiveScreenBuffer( VALUE self, VALUE hConsoleOutput )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );

   if ( !SetConsoleActiveScreenBuffer( handle ) )
      return rb_getWin32Error();
   return INT2FIX(1);
}

VALUE
rb_SetConsoleTextAttribute( VALUE self, VALUE hConsoleOutput, 
						   VALUE wAttributes )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );

   if ( !SetConsoleTextAttribute( handle, NUM2UINT(wAttributes) ) )
      return Qnil; // no getWin32Error to allow piping/redirecting
   return INT2FIX(1);
}



VALUE
rb_ScrollConsoleScreenBuffer( VALUE self, VALUE hConsoleOutput, VALUE left1,
			      VALUE top1, VALUE right1, VALUE bottom1,
			      VALUE col, VALUE row, VALUE cChar, VALUE attr,
			      VALUE left2, VALUE top2, VALUE right2,
			      VALUE bottom2)
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );
   
   SMALL_RECT scroll, clip;
   scroll.Left   = NUM2INT( left1 );
   scroll.Right  = NUM2INT( right1 );
   scroll.Top    = NUM2INT( top1 );
   scroll.Bottom = NUM2INT( bottom1 );
   clip.Left   = NUM2INT( left2 );
   clip.Right  = NUM2INT( right2 );
   clip.Top    = NUM2INT( top2 );
   clip.Bottom = NUM2INT( bottom2 );
   CHAR_INFO fill;
#ifdef UNICODE
   fill.Char.UnicodeChar = NUM2CHR( cChar );
#else
   fill.Char.AsciiChar = NUM2CHR( cChar );
#endif
   fill.Attributes = NUM2INT(attr);
   COORD origin;
   origin.X = NUM2UINT( col );
   origin.Y = NUM2UINT( row );
   
   if ( ScrollConsoleScreenBuffer( handle, &scroll, &clip, origin,
				   &fill ) )
      return INT2FIX(1);
   return rb_getWin32Error();
}


VALUE
rb_FillConsoleOutputCharacter( VALUE self, VALUE hConsoleOutput,
			       VALUE cCharacter, VALUE nLength,
			       VALUE col, VALUE row )
{
   HANDLE handle = ULongToPtr( NUM2ULONG( hConsoleOutput ) );

   COORD dwWriteCoord;
   dwWriteCoord.X = NUM2UINT(col);
   dwWriteCoord.Y = NUM2UINT(row);
   DWORD numChars;
   if (FillConsoleOutputCharacter( handle, NUM2CHR(cCharacter),
				   NUM2ULONG(nLength), dwWriteCoord,
				   &numChars ))
      return ULONG2NUM(numChars);
   return rb_getWin32Error();
}


VALUE
rb_WriteConsoleInput(int argc, VALUE *argv, VALUE self)
{
   if (argc < 3)
      rb_raise(rb_eArgError, "Wrong number of arguments.");
   
   HANDLE handle = ULongToPtr( NUM2ULONG( argv[0] ) );
   WORD type = NUM2INT( argv[1] );
   DWORD written;
   INPUT_RECORD event;
   event.EventType = type;
   switch(event.EventType) {
      case KEY_EVENT:
	 {
	 KEY_EVENT_RECORD* kevent=(KEY_EVENT_RECORD *)&(event.Event);
	 kevent->bKeyDown=(BOOL)NUM2UINT( argv[2] );
	 kevent->wRepeatCount=NUM2UINT( argv[3] );
	 kevent->wVirtualKeyCode=NUM2UINT( argv[4] );
	 kevent->wVirtualScanCode=NUM2UINT( argv[5] );
#ifdef UNICODE
	 if (argc < 7)
	    rb_raise(rb_eArgError, "Wrong number of arguments.");
	kevent->uChar.UnicodeChar=NUM2UINT( argv[6] );
#else
	if (argc < 8)
	   rb_raise(rb_eArgError, "Wrong number of arguments.");
	kevent->uChar.AsciiChar=NUM2UINT( argv[7] );
#endif
	break;
	 }
    case MOUSE_EVENT:
       {
	  if (argc < 7)
	     rb_raise(rb_eArgError, "Wrong number of arguments.");
	
	  MOUSE_EVENT_RECORD* mevent=(MOUSE_EVENT_RECORD *)&(event.Event);
	  mevent->dwMousePosition.X=NUM2UINT( argv[2] );
	  mevent->dwMousePosition.Y=NUM2UINT( argv[3] );
	  mevent->dwButtonState=NUM2UINT( argv[4] );
	  mevent->dwControlKeyState=NUM2UINT( argv[5] );
	  mevent->dwEventFlags=NUM2UINT( argv[6] );
       break;
       }
      case WINDOW_BUFFER_SIZE_EVENT:
	 {
	    if (argc < 4)
	       rb_raise(rb_eArgError, "Wrong number of arguments.");
	    WINDOW_BUFFER_SIZE_RECORD* mevent=
	    (WINDOW_BUFFER_SIZE_RECORD *)&(event.Event);
	    mevent->dwSize.X = NUM2UINT( argv[2] );
	    mevent->dwSize.Y = NUM2UINT( argv[3] );
	 }
	 break;
      case MENU_EVENT:
	 {
	    if (argc < 3)
	       rb_raise(rb_eArgError, "Wrong number of arguments.");
	    MENU_EVENT_RECORD* mevent= (MENU_EVENT_RECORD *)&(event.Event);
	    mevent->dwCommandId = argv[2];
	 }
	 break;
      case FOCUS_EVENT:
	 {
	    if (argc < 3)
	       rb_raise(rb_eArgError, "Wrong number of arguments.");
	    FOCUS_EVENT_RECORD* mevent= (FOCUS_EVENT_RECORD *)&(event.Event);
	    mevent->bSetFocus = NUM2UINT( argv[2] );
	 }
    default:
       rb_raise( rb_eArgError, "Unknown type of event.");
       break;
   }
   if (WriteConsoleInput(handle,&event,1,&written))
      return INT2FIX(1);
   return rb_getWin32Error();
}

VALUE
rb_WriteConsoleOutput(VALUE self, VALUE h, VALUE buffer,
		      VALUE srcwid, VALUE srcht, VALUE startx,
		      VALUE starty, VALUE l, VALUE t, VALUE r, VALUE b)
{
    COORD coords;
    COORD size;
    SMALL_RECT to;

    HANDLE handle = ULongToPtr( NUM2ULONG( h ) );
    Check_Type( buffer, T_STRING );
    size.X=NUM2UINT( srcwid );
    size.Y=NUM2UINT( srcht );
    coords.X=NUM2INT( startx );
    coords.Y=NUM2INT( starty );
    to.Left   = NUM2INT( l );
    to.Top    = NUM2INT( t );
    to.Right  = NUM2INT( r );
    to.Bottom = NUM2INT( b );
    if (WriteConsoleOutput(handle,(CHAR_INFO *)RSTRING(buffer)->ptr,
			   size,coords,&to)) {
       VALUE ret = rb_ary_new();
       rb_ary_push( ret, INT2FIX( to.Left   ) );
       rb_ary_push( ret, INT2FIX( to.Top    ) );
       rb_ary_push( ret, INT2FIX( to.Right  ) );
       rb_ary_push( ret, INT2FIX( to.Bottom ) );
       return ret;
    }
    return rb_getWin32Error();
}


VALUE
rb_WriteConsoleOutputAttribute(VALUE self, VALUE h, VALUE s,
			       VALUE x, VALUE y)
{

    HANDLE handle = ULongToPtr( NUM2ULONG( h ) );
    Check_Type( s, T_STRING );
    
    unsigned short buffer[80*999*sizeof(unsigned short)];
    DWORD written;
    DWORD towrite = RSTRING(s)->len;
    for(unsigned i=0; i<towrite; i++) {
        buffer[i] = (unsigned short)(RSTRING(s)->ptr[i]);
    }
    COORD coords;
    coords.X=NUM2INT( x );
    coords.Y=NUM2INT( y );
    if (WriteConsoleOutputAttribute(handle,(const unsigned short *)&buffer,
				    towrite,coords,&written)) {
       return UINT2NUM( written );
    }
    return rb_getWin32Error();
}


VALUE
rb_WriteConsoleOutputCharacter(VALUE self, VALUE h, VALUE s,
			       VALUE x, VALUE y)
{

    HANDLE handle = ULongToPtr( NUM2ULONG( h ) );
    Check_Type( s, T_STRING );
    
    DWORD written;
    COORD coords;
    coords.X=NUM2INT( x );
    coords.Y=NUM2INT( y );
    if (WriteConsoleOutputCharacter(handle,(LPCTSTR)RSTRING(s)->ptr,
				    RSTRING(s)->len,coords,&written)) {
       return UINT2NUM( written );
    }
    return rb_getWin32Error();
}


CONSOLE_EXPORT  void
Init_Console(void)
{
   rb_mWin32 = rb_define_module("Win32");
   rb_define_const(rb_mKernel, "Win32", rb_mWin32);

   rb_mConsole = rb_define_class_under(rb_mWin32, "Console", rb_cObject);

   // Handle Constants
   rb_mConstants = rb_define_module_under(rb_mConsole,"Constants");
   define_constants();

   // Handle API
   rb_mAPI = rb_define_class_under(rb_mConsole, "API", rb_cObject);
   
   RB_DEF_API_METHOD(constant, 1); //OK

   RB_DEF_API_METHOD(AllocConsole, 0);
   
   RB_DEF_API_METHOD(CreateConsoleScreenBuffer, 3); //OK
   
   RB_DEF_API_METHOD(FillConsoleOutputAttribute, 5); //OK
   RB_DEF_API_METHOD(FillConsoleOutputCharacter, 5); //OK
//     RB_DEF_API_METHOD(FillConsoleInputBuffer, 1); // Does not exist anymore
   
   RB_DEF_API_METHOD(FreeConsole, 0);
   
   RB_DEF_API_METHOD(GenerateConsoleCtrlEvent, 2);
   
   RB_DEF_API_METHOD(GetConsoleCP, 0); //OK
   RB_DEF_API_METHOD(GetConsoleCursorInfo, 1); //OK
   RB_DEF_API_METHOD(GetConsoleMode, 1);
   RB_DEF_API_METHOD(GetConsoleOutputCP, 0);
   RB_DEF_API_METHOD(GetConsoleScreenBufferInfo, 1); //OK
   RB_DEF_API_METHOD(GetConsoleTitle, 0);
   RB_DEF_API_METHOD(GetConsoleWindow, 0);
   RB_DEF_API_METHOD(GetLargestConsoleWindowSize, 1);
   RB_DEF_API_METHOD(GetNumberOfConsoleInputEvents, 1);
   RB_DEF_API_METHOD(GetNumberOfConsoleMouseButtons, 0);
   
   RB_DEF_API_METHOD(GetStdHandle, 1); //OK
   
   RB_DEF_API_METHOD(PeekConsoleInput, 1); //OK
   RB_DEF_API_METHOD(ReadConsole, 3); //OK
   RB_DEF_API_METHOD(ReadConsoleInput, 1); //OK
   
   RB_DEF_API_METHOD(ReadConsoleOutput, 10);  // OK
   RB_DEF_API_METHOD(ReadConsoleOutputAttribute, 4);  // OK
   RB_DEF_API_METHOD(ReadConsoleOutputCharacter, 5);  // OK

   
   RB_DEF_API_METHOD(ScrollConsoleScreenBuffer, 13); //OK
   
   RB_DEF_API_METHOD(SetConsoleActiveScreenBuffer, 1);
   RB_DEF_API_METHOD(SetConsoleCP, 1);
   RB_DEF_API_METHOD(SetConsoleCursorPosition, 3);
   RB_DEF_API_METHOD(SetConsoleCursorInfo, 3);
   RB_DEF_API_METHOD(SetConsoleMode, 2); //OK
   RB_DEF_API_METHOD(SetConsoleOutputCP, 1);
   RB_DEF_API_METHOD(SetConsoleScreenBufferSize, 3);
   RB_DEF_API_METHOD(SetConsoleTextAttribute, 2);
   RB_DEF_API_METHOD(SetConsoleTitle, 1); //OK
   RB_DEF_API_METHOD(SetConsoleWindowInfo, 6);
   
   RB_DEF_API_METHOD(SetStdHandle, 2);
   
   RB_DEF_API_METHOD(WriteConsole, 2);
   
   RB_DEF_API_METHOD(WriteConsoleInput, -1);
   RB_DEF_API_METHOD(WriteConsoleOutput, 10);
   RB_DEF_API_METHOD(WriteConsoleOutputAttribute, 4);
   RB_DEF_API_METHOD(WriteConsoleOutputCharacter, 4);
 
}

}

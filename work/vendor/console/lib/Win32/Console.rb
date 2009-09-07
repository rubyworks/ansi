# Win32::Console:  an object implementing the Win32 API Console functions
# Copyright (C) 2003 Gonzalo Garramuno (ggarramuno@aol.com)
#
# Original Win32API_Console was:
# Copyright (C) 2001 Michael L. Semon (mlsemon@sega.net)

begin
  # If Console.so is available, use that.  Otherwise, we define
  # equivalent functions in ruby (a tad slower)
  # That dll should define everything in an identical interface
  # to all the ruby code that the rescue below defines.
  require "Console.so"
  STDERR.print "Using faster, DLL Console.so\n" if $DEBUG

rescue Exception

  STDERR.print "Using slower, non-DLL Console.rb\n" if $DEBUG

  module Win32
    class Console
    end
  end

  # The WINDOWS constants
  module Win32::Console::Constants
    STD_INPUT_HANDLE          = 0xFFFFFFF6
    STD_OUTPUT_HANDLE         = 0xFFFFFFF5
    STD_ERROR_HANDLE          = 0xFFFFFFF4
    INVALID_HANDLE_VALUE      = 0xFFFFFFFF
    GENERIC_READ              = 0x80000000
    GENERIC_WRITE             = 0x40000000
    FILE_SHARE_READ           = 0x00000001
    FILE_SHARE_WRITE          = 0x00000002
    CONSOLE_TEXTMODE_BUFFER   = 0x00000001

    FOREGROUND_BLUE           = 0x0001
    FOREGROUND_GREEN          = 0x0002
    FOREGROUND_RED            = 0x0004
    FOREGROUND_INTENSITY      = 0x0008
    BACKGROUND_BLUE           = 0x0010
    BACKGROUND_GREEN          = 0x0020
    BACKGROUND_RED            = 0x0040
    BACKGROUND_INTENSITY      = 0x0080

    ENABLE_PROCESSED_INPUT    = 0x0001
    ENABLE_LINE_INPUT         = 0x0002
    ENABLE_ECHO_INPUT         = 0x0004
    ENABLE_WINDOW_INPUT       = 0x0008
    ENABLE_MOUSE_INPUT        = 0x0010
    ENABLE_PROCESSED_OUTPUT   = 0x0001
    ENABLE_WRAP_AT_EOL_OUTPUT = 0x0002

    KEY_EVENT                 = 0x0001
    MOUSE_EVENT               = 0x0002
    WINDOW_BUFFER_SIZE_EVENT  = 0x0004
    MENU_EVENT                = 0x0008
    FOCUS_EVENT               = 0x0010

    CAPSLOCK_ON               = 0x0080
    ENHANCED_KEY              = 0x0100
    NUMLOCK_ON                = 0x0020
    SHIFT_PRESSED             = 0x0010
    LEFT_CTRL_PRESSED         = 0x0008
    RIGHT_CTRL_PRESSED        = 0x0004
    LEFT_ALT_PRESSED          = 0x0002
    RIGHT_ALT_PRESSED         = 0x0001
    SCROLLLOCK_ON             = 0x0040

    MOUSE_WHEELED             = 0x0004
    DOUBLE_CLICK              = 0x0002
    MOUSE_MOVED               = 0x0001

    FROM_LEFT_1ST_BUTTON_PRESSED    = 0x0001
    FROM_LEFT_2ND_BUTTON_PRESSED    = 0x0004
    FROM_LEFT_3RD_BUTTON_PRESSED    = 0x0008
    FROM_LEFT_4TH_BUTTON_PRESSED    = 0x0010
    RIGHTMOST_BUTTON_PRESSED        = 0x0002

    CTRL_C_EVENT              = 0x0000
    CTRL_BREAK_EVENT          = 0x0001
    CTRL_CLOSE_EVENT          = 0x0002
    CTRL_LOGOFF_EVENT         = 0x0005
    CTRL_SHUTDOWN_EVENT       = 0x0006
  end

  # The actual api to access windows functions
  class Win32::Console::API
    require 'Win32API'

    private
    # This is a class-wide cache that will hold Win32API objects.  As each 
    # Win32API object is about 920 bytes, I didn't want to initialize all of 
    # them at one time.  That would waste about 42 kB for this object because 
    # it has 47 functions.  However, to not have a cache at all would reduce 
    # the speed of this object by 164%.
    @@m_AllocConsole = nil
    @@m_CreateConsoleScreenBuffer = nil
    @@m_FillConsoleOutputAttribute = nil
    @@m_FillConsoleOutputCharacter = nil
    @@m_FlushConsoleInputBuffer = nil
    @@m_FreeConsole = nil
    @@m_GenerateConsoleCtrlEvent = nil
    @@m_GetConsoleCP = nil
    @@m_GetConsoleCursorInfo = nil
    @@m_GetConsoleMode = nil
    @@m_GetConsoleOutputCP = nil
    @@m_GetConsoleScreenBufferInfo = nil
    @@m_GetConsoleTitle = nil
    @@m_GetConsoleWindow = nil
    @@m_GetLargestConsoleWindowSize = nil
    @@m_GetNumberOfConsoleInputEvents = nil
    @@m_GetNumberOfConsoleMouseButtons = nil
    @@m_GetStdHandle = nil
    @@m_PeekConsoleInput = nil
    @@m_ReadConsole = nil
    @@m_ReadConsoleInput = nil
    @@m_ReadConsoleOutput = nil
    @@m_ReadConsoleOutputAttribute = nil
    @@m_ReadConsoleOutputCharacter = nil
    @@m_ScrollConsoleScreenBuffer = nil
    @@m_SetConsoleActiveScreenBuffer = nil
    @@m_SetConsoleCP = nil
    @@m_SetConsoleCursorInfo = nil
    @@m_SetConsoleCursorPosition = nil
    @@m_SetConsoleMode = nil
    @@m_SetConsoleOutputCP = nil
    @@m_SetConsoleScreenBufferSize = nil
    @@m_SetConsoleTextAttribute = nil
    @@m_SetConsoleTitle = nil
    @@m_SetConsoleWindowInfo = nil
    @@m_SetStdHandle = nil
    @@m_WriteConsole = nil
    @@m_WriteConsoleInput = nil
    @@m_WriteConsoleOutput = nil
    @@m_WriteConsoleOutputAttribute = nil
    @@m_WriteConsoleOutputCharacter = nil

    public

    class << self

    
      def constant(t)
	begin
	  eval "return Win32::Console::Constants::#{t}"
	rescue
	  return nil
	end
      end


     def AllocConsole()
       if @@m_AllocConsole == nil
	  @@m_AllocConsole = Win32API.new( "kernel32", "AllocConsole", 
					  [], 'l' )
       end
       @@m_AllocConsole.call()
     end

      def CreateConsoleScreenBuffer( dwDesiredAccess, dwShareMode, dwFlags )
        if @@m_CreateConsoleScreenBuffer == nil
	  @@m_CreateConsoleScreenBuffer = Win32API.new( "kernel32", "CreateConsoleScreenBuffer", ['l', 'l', 'p', 'l', 'p'], 'l' )
        end
        @@m_CreateConsoleScreenBuffer.call( dwDesiredAccess, dwShareMode, 
					    nil, dwFlags, nil )
      end



     def FillConsoleOutputAttribute( hConsoleOutput, wAttribute, nLength, 
				      col, row )
       if @@m_FillConsoleOutputAttribute == nil
	  @@m_FillConsoleOutputAttribute = Win32API.new( "kernel32", "FillConsoleOutputAttribute", ['l', 'i', 'l', 'l', 'p'], 'l' )
       end
	dwWriteCoord = (row << 16) + col
	lpNumberOfAttrsWritten = ' ' * 4
       @@m_FillConsoleOutputAttribute.call( hConsoleOutput, wAttribute, 
					    nLength, dwWriteCoord, 
					    lpNumberOfAttrsWritten )
	return lpNumberOfAttrsWritten.unpack('L')
     end



     def FillConsoleOutputCharacter( hConsoleOutput, cCharacter, nLength, 
				      col, row )
       if @@m_FillConsoleOutputCharacter == nil
	  @@m_FillConsoleOutputCharacter = Win32API.new( "kernel32", "FillConsoleOutputCharacter", ['l', 'i', 'l', 'l', 'p'], 'l' )
       end
	dwWriteCoord = (row << 16) + col
	lpNumberOfAttrsWritten = ' ' * 4
       @@m_FillConsoleOutputCharacter.call( hConsoleOutput, cCharacter, 
					    nLength, dwWriteCoord, 
					    lpNumberOfAttrsWritten )
	return lpNumberOfAttrsWritten.unpack('L')
     end


      def FlushConsoleInputBuffer( hConsoleInput )
        if @@m_FlushConsoleInputBuffer == nil
	  @@m_FlushConsoleInputBuffer = Win32API.new( "kernel32", 
						     "FillConsoleInputBuffer",
						     ['l'], 'l' )
        end
        @@m_FlushConsoleInputBuffer.call( hConsoleInput )
      end


      def FreeConsole()
        if @@m_FreeConsole == nil
	  @@m_FreeConsole = Win32API.new( "kernel32", "FreeConsole", [], 'l' )
        end
        @@m_FreeConsole.call()
      end


      def GenerateConsoleCtrlEvent( dwCtrlEvent, dwProcessGroupId )
        if @@m_GenerateConsoleCtrlEvent == nil
	  @@m_GenerateConsoleCtrlEvent = Win32API.new( "kernel32", "GenerateConsoleCtrlEvent", ['l', 'l'], 'l' )
        end
        @@m_GenerateConsoleCtrlEvent.call( dwCtrlEvent, dwProcessGroupId )
      end

     def GetConsoleCP()
       if @@m_GetConsoleCP == nil
	  @@m_GetConsoleCP = Win32API.new( "kernel32", "GetConsoleCP", 
					  [], 'l' )
       end
       @@m_GetConsoleCP.call()
     end

     def GetConsoleCursorInfo( hConsoleOutput )
       if @@m_GetConsoleCursorInfo == nil
	  @@m_GetConsoleCursorInfo = Win32API.new( "kernel32", 
						  "GetConsoleCursorInfo", 
						  ['l', 'p'], 'l' )
       end
	lpConsoleCursorInfo = ' ' * 8
       @@m_GetConsoleCursorInfo.call( hConsoleOutput, lpConsoleCursorInfo )
	return lpConsoleCursorInfo.unpack('LL')
     end

      def GetConsoleMode( hConsoleHandle )
        if @@m_GetConsoleMode == nil
	  @@m_GetConsoleMode = Win32API.new( "kernel32", "GetConsoleMode", 
					    ['l', 'p'], 'l' )
        end
	lpMode = ' ' * 4
        @@m_GetConsoleMode.call( hConsoleHandle, lpMode )
	return lpMode.unpack('L')
      end

     def GetConsoleOutputCP()
       if @@m_GetConsoleOutputCP == nil
	  @@m_GetConsoleOutputCP = Win32API.new( "kernel32", 
						"GetConsoleOutputCP", [], 'l' )
       end
       @@m_GetConsoleOutputCP.call()
     end

     def GetConsoleScreenBufferInfo( hConsoleOutput )
       if @@m_GetConsoleScreenBufferInfo == nil
	  @@m_GetConsoleScreenBufferInfo = Win32API.new( "kernel32", "GetConsoleScreenBufferInfo", ['l', 'p'], 'l' )
       end
	lpBuffer = ' ' * 22
       @@m_GetConsoleScreenBufferInfo.call( hConsoleOutput, lpBuffer )
	return lpBuffer.unpack('SSSSSssssSS')
     end

     def GetConsoleTitle()
        if @@m_GetConsoleTitle == nil
	  @@m_GetConsoleTitle = Win32API.new( "kernel32", "GetConsoleTitle", 
					     ['p', 'l'], 'l' )
        end
	nSize = 120
	lpConsoleTitle = ' ' * nSize
        @@m_GetConsoleTitle.call( lpConsoleTitle, nSize )
	return lpConsoleTitle.strip
      end

     def GetConsoleWindow()
       if @@m_GetConsoleWindow == nil
	  @@m_GetConsoleWindow = Win32API.new( "kernel32", "GetConsoleWindow",
					      [], 'l' )
       end
       @@m_GetConsoleWindow.call()
     end

      def GetLargestConsoleWindowSize( hConsoleOutput )
        if @@m_GetLargestConsoleWindowSize == nil
	  @@m_GetLargestConsoleWindowSize = Win32API.new( "kernel32", "GetLargestConsoleWindowSize", ['l'], 'l' )
        end
        coord = @@m_GetLargestConsoleWindowSize.call( hConsoleOutput )
	x = coord >> 16
	y = coord & 0x0000ffff
	return [x,y]
      end

      def GetNumberOfConsoleInputEvents( hConsoleInput )
        if @@m_GetNumberOfConsoleInputEvents == nil
	  @@m_GetNumberOfConsoleInputEvents = Win32API.new( "kernel32", "GetNumberOfConsoleInputEvents", ['l', 'p'], 'l' )
        end
	lpcNumberOfEvents = 0
        @@m_GetNumberOfConsoleInputEvents.call( hConsoleInput, 
					       lpcNumberOfEvents )
	return lpcNumberOfEvents
      end

      def GetNumberOfConsoleMouseButtons( )
        if @@m_GetNumberOfConsoleMouseButtons == nil
	  @@m_GetNumberOfConsoleMouseButtons = Win32API.new( "kernel32", "GetNumberOfConsoleMouseButtons", ['p'], 'l' )
        end
	lpNumberOfMouseButtons = 0
        @@m_GetNumberOfConsoleMouseButtons.call( lpNumberOfMouseButtons )
	return lpNumberOfMouseButtons
      end

     def GetStdHandle( nStdHandle )
       if @@m_GetStdHandle == nil
	  @@m_GetStdHandle = Win32API.new( "kernel32", "GetStdHandle", 
					  ['l'], 'l' )
       end
       @@m_GetStdHandle.call( nStdHandle )
     end

      # <<HandlerRoutine>> : This is not an actual API function, just a concept description in the SDK.

      def PeekConsoleInput( hConsoleInput )
        if @@m_PeekConsoleInput == nil
	  @@m_PeekConsoleInput = Win32API.new( "kernel32", "PeekConsoleInput",
					      ['l', 'p', 'l', 'p'], 'l' )
        end
	lpNumberOfEventsRead = ' ' * 4
	lpBuffer = ' ' * 20
	nLength  = 20
        @@m_PeekConsoleInput.call( hConsoleInput, lpBuffer, nLength, 
				   lpNumberOfEventsRead )
	type = lpBuffer.unpack('s')[0]

	case type
	when KEY_EVENT
	  return lpBuffer.unpack('sSSSSCS') 
	when MOUSE_EVENT
	  return lpBuffer.unpack('sSSSS')
	when WINDOW_BUFFER_SIZE_EVENT
	  return lpBuffer.unpack('sS') 
	when MENU_EVENT
	  return lpBuffer.unpack('sS') 
	when FOCUS_EVENT
	  return lpBuffer.unpack('sS')
	else
	  return []
	end
      end

      def ReadConsole( hConsoleInput, lpBuffer, nNumberOfCharsToRead )
        if @@m_ReadConsole == nil
	  @@m_ReadConsole = Win32API.new( "kernel32", "ReadConsole", 
					 ['l', 'p', 'l', 'p', 'p'], 'l' )
        end
	lpBuffer = ' ' * nNumberOfCharsToRead unless lpBuffer
	lpNumberOfCharsRead = ' ' * 4
	lpReserved = ' ' * 4
        @@m_ReadConsole.call( hConsoleInput, lpBuffer, nNumberOfCharsToRead, 
			     lpNumberOfCharsRead, lpReserved )
	return lpNumberOfCharsRead.unpack('L')
      end

      def ReadConsoleInput( hConsoleInput )
        if @@m_ReadConsoleInput == nil
	  @@m_ReadConsoleInput = Win32API.new( "kernel32", "ReadConsoleInput",
					      ['l', 'p', 'l', 'p'], 'l' )
        end
	lpNumberOfEventsRead = ' ' * 4
	lpBuffer = ' ' * 20
	nLength  = 20
        @@m_ReadConsoleInput.call( hConsoleInput, lpBuffer, nLength, 
				  lpNumberOfEventsRead )
	type = lpBuffer.unpack('s')[0] 

	case type
	when KEY_EVENT
	  return lpBuffer.unpack('sSSSSCS') 
	when MOUSE_EVENT
	  return lpBuffer.unpack('sSSSS')
	when WINDOW_BUFFER_SIZE_EVENT
	  return lpBuffer.unpack('sS') 
	when MENU_EVENT
	  return lpBuffer.unpack('sS') 
	when FOCUS_EVENT
	  return lpBuffer.unpack('sS')
	else
	  return []
	end
      end

      def ReadConsoleOutput( hConsoleOutput, lpBuffer, cols, rows,
			    bufx, bufy, left, top, right, bottom )
        if @@m_ReadConsoleOutput == nil
	  @@m_ReadConsoleOutput = Win32API.new( "kernel32", 
					       "ReadConsoleOutput", 
					       ['l', 'p', 'l', 'l', 'p'], 'l' )
        end
	dwBufferSize  = cols * rows * 4
	lpBuffer = ' ' * dwBufferSize
	dwBufferCoord = (bufy << 16) + bufx
	lpReadRegion  = [ left, top, right, bottom ].pack('ssss')
        @@m_ReadConsoleOutput.call( hConsoleOutput, lpBuffer, dwBufferSize, 
				   dwBufferCoord, lpReadRegion )
      end

      def ReadConsoleOutputAttribute( hConsoleOutput, nLength, col, row )
        if @@m_ReadConsoleOutputAttribute == nil
	  @@m_ReadConsoleOutputAttribute = Win32API.new( "kernel32", "ReadConsoleOutputAttribute", ['l', 'p', 'l', 'l', 'p'], 'l' )
        end
	lpAttribute = ' ' * nLength
	dwReadCoord = (row << 16) + col
	lpNumberOfAttrsRead = ' ' * 4
        @@m_ReadConsoleOutputAttribute.call( hConsoleOutput, lpAttribute, 
					    nLength, dwReadCoord, 
					    lpNumberOfAttrsRead )
	return lpAttribute
      end

      def ReadConsoleOutputCharacter( hConsoleOutput, lpCharacter, nLength, 
				      col, row )
        if @@m_ReadConsoleOutputCharacter == nil
	  @@m_ReadConsoleOutputCharacter = Win32API.new( "kernel32", "ReadConsoleOutputCharacter", ['l', 'p', 'l', 'l', 'p'], 'l' )
        end
	dwReadCoord = (row << 16) + col
	lpNumberOfCharsRead = ' ' * 4
        @@m_ReadConsoleOutputCharacter.call( hConsoleOutput, lpCharacter, 
					    nLength, dwReadCoord, 
					    lpNumberOfCharsRead )
	return lpNumberOfCharsRead.unpack('L')
      end

     def ScrollConsoleScreenBuffer( hConsoleOutput, 
				    left1, top1, right1, bottom1,
				    col, row, char, attr,
				    left2, top2, right2, bottom2 )
       if @@m_ScrollConsoleScreenBuffer == nil
	  @@m_ScrollConsoleScreenBuffer = Win32API.new( "kernel32", "ScrollConsoleScreenBuffer", ['l', 'p', 'p', 'l', 'p'], 'l' )
       end
	lpScrollRectangle = [left1, top1, right1, bottom1].pack('ssss')
	lpClipRectangle   = [left2, top2, right2, bottom2].pack('ssss')
	dwDestinationOrigin = (row << 16) + col
	lpFill = [char, attr].pack('ss')
       @@m_ScrollConsoleScreenBuffer.call( hConsoleOutput, lpScrollRectangle,
					   lpClipRectangle, 
					   dwDestinationOrigin, lpFill )
     end

     def SetConsoleActiveScreenBuffer( hConsoleOutput )
       if @@m_SetConsoleActiveScreenBuffer == nil
	  @@m_SetConsoleActiveScreenBuffer = Win32API.new( "kernel32", "SetConsoleActiveScreenBuffer", ['l'], 'l' )
       end
       @@m_SetConsoleActiveScreenBuffer.call( hConsoleOutput )
     end

      # <<SetConsoleCtrlHandler>>:  Will probably not be implemented.

     def SetConsoleCP( wCodePageID )
       if @@m_SetConsoleCP == nil
	  @@m_SetConsoleCP = Win32API.new( "kernel32", "SetConsoleCP", 
					  ['l'], 'l' )
       end
       @@m_SetConsoleCP.call( wCodePageID )
     end

     def SetConsoleCursorInfo( hConsoleOutput, col, row )
       if @@m_SetConsoleCursorInfo == nil
	  @@m_SetConsoleCursorInfo = Win32API.new( "kernel32", 
						  "SetConsoleCursorInfo", 
						  ['l', 'p'], 'l' )
       end
	lpConsoleCursorInfo = [size,visi].pack('LL')
       @@m_SetConsoleCursorInfo.call( hConsoleOutput, lpConsoleCursorInfo )
     end

     def SetConsoleCursorPosition( hConsoleOutput, col, row )
       if @@m_SetConsoleCursorPosition == nil
	  @@m_SetConsoleCursorPosition = Win32API.new( "kernel32", "SetConsoleCursorPosition", ['l', 'p'], 'l' )
       end
	dwCursorPosition = (row << 16) + col
       @@m_SetConsoleCursorPosition.call( hConsoleOutput, dwCursorPosition )
     end

     def SetConsoleMode( hConsoleHandle, lpMode )
       if @@m_SetConsoleMode == nil
	  @@m_SetConsoleMode = Win32API.new( "kernel32", "SetConsoleMode", 
					    ['l', 'p'], 'l' )
       end
       @@m_SetConsoleMode.call( hConsoleHandle, lpMode )
     end

     def SetConsoleOutputCP( wCodePageID )
       if @@m_SetConsoleOutputCP == nil
	  @@m_SetConsoleOutputCP = Win32API.new( "kernel32", 
						"GetConsoleOutputCP", 
						['l'], 'l' )
       end
       @@m_SetConsoleOutputCP.call( wCodePageID )
     end

      def SetConsoleScreenBufferSize( hConsoleOutput, col, row )
        if @@m_SetConsoleScreenBufferSize == nil
	  @@m_SetConsoleScreenBufferSize = Win32API.new( "kernel32", "SetConsoleScreenBufferSize", ['l', 'l'], 'l' )
        end
	dwSize = (row << 16) + col
        @@m_SetConsoleScreenBufferSize.call( hConsoleOutput, dwSize )
      end

     def SetConsoleTextAttribute( hConsoleOutput, wAttributes )
       if @@m_SetConsoleTextAttribute == nil
	  @@m_SetConsoleTextAttribute = Win32API.new( "kernel32", "SetConsoleTextAttribute", ['l', 'i'], 'l' )
       end
       @@m_SetConsoleTextAttribute.call( hConsoleOutput, wAttributes )
     end

      def SetConsoleTitle( lpConsoleTitle )
        if @@m_SetConsoleTitle == nil
	  @@m_SetConsoleTitle = Win32API.new( "kernel32", "SetConsoleTitle", 
					     ['p'], 'l' )
        end
        @@m_SetConsoleTitle.call( lpConsoleTitle )
      end

      def SetConsoleWindowInfo( hConsoleOutput, bAbsolute, 
			        left, top, right, bottom )
        if @@m_SetConsoleWindowInfo == nil
	  @@m_SetConsoleWindowInfo = Win32API.new( "kernel32", 
						  "SetConsoleWindowInfo", 
						  ['l', 'l', 'p'], 'l' )
        end
	lpConsoleWindow = [ left, top, right, bottom ].pack('ssss')
        @@m_SetConsoleWindowInfo.call( hConsoleOutput, bAbsolute, 
				      lpConsoleWindow )
      end

      def SetStdHandle( nStdHandle, hHandle )
        if @@m_SetStdHandle == nil
	  @@m_SetStdHandle = Win32API.new( "kernel32", "SetStdHandle",
					  ['l', 'l'], 'l' )
        end
        @@m_SetStdHandle.call( nStdHandle, hHandle )
      end

     def WriteConsole( hConsoleOutput, lpBuffer )
       if @@m_WriteConsole == nil
	  @@m_WriteConsole = Win32API.new( "kernel32", "WriteConsole",
					  ['l', 'p', 'l', 'p', 'p'], 'l' )
       end
	nNumberOfCharsToWrite = lpBuffer.length()
	lpNumberOfCharsWritten = ' ' * 4
	lpReserved = ' ' * 4
       @@m_WriteConsole.call( hConsoleOutput, lpBuffer, nNumberOfCharsToWrite,
			      lpNumberOfCharsWritten,  lpReserved )
	return lpNumberOfCharsWritten
     end

      def WriteConsoleInput( hConsoleInput, lpBuffer )
        if @@m_WriteConsoleInput == nil
	  @@m_WriteConsoleInput = Win32API.new( "kernel32", "WriteConsoleInput", ['l', 'p', 'l', 'p'], 'l' )
        end
        @@m_WriteConsoleInput.call( hConsoleInput, lpBuffer, nLength, 
				   lpNumberOfEventsWritten )
      end

      # @@ Todo: Test this
      def WriteConsoleOutput( hConsoleOutput, buffer, cols, rows,
			     bufx, bufy, left, top, right, bottom )
        if @@m_WriteConsoleOutput == nil
	  @@m_WriteConsoleOutput = Win32API.new( "kernel32", "WriteConsoleOutput", ['l', 'p', 'l', 'l', 'p'], 'l' )
        end
	lpBuffer = buffer.flatten.pack('ss' * buffer.length() * 2)
	dwBufferSize = (buffer.length() << 16) + 2
	dwBufferCoord = (row << 16) + col 
	lpWriteRegion = [ left, top, right, bottom ].pack('ssss')
        @@m_WriteConsoleOutput.call( hConsoleOutput, lpBuffer, dwBufferSize,
				    dwBufferCoord, lpWriteRegion )
      end

      def WriteConsoleOutputAttribute( hConsoleOutput, lpAttribute, col, row )
        if @@m_WriteConsoleOutputAttribute == nil
	  @@m_WriteConsoleOutputAttribute = Win32API.new( "kernel32", "WriteConsoleOutputAttribute", ['l', 'p', 'l', 'l', 'p'], 'l' )
        end
	nLength = lpAttribute.length()
	dwWriteCoord = (row << 16) + col
	lpNumberOfAttrsWritten = ' ' * 4
        @@m_WriteConsoleOutputAttribute.call( hConsoleOutput, lpAttribute, 
					     nLength, dwWriteCoord, 
					     lpNumberOfAttrsWritten )
	return lpNumberOfAttrsWritten.unpack('L')
      end

      def WriteConsoleOutputCharacter( hConsoleOutput, lpCharacter, col, row )
        if @@m_WriteConsoleOutputCharacter == nil
	  @@m_WriteConsoleOutputCharacter = Win32API.new( "kernel32", "WriteConsoleOutputCharacter", ['l', 'p', 'l', 'l', 'p'], 'l' )
        end
	nLength = lpCharacter.length()
	dwWriteCoord = (row << 16) + col
	lpNumberOfCharsWritten = ' ' * 4
        @@m_WriteConsoleOutputCharacter.call( hConsoleOutput, lpCharacter, 
					     nLength, dwWriteCoord, 
					     lpNumberOfCharsWritten )
	return lpNumberOfCharsWritten.unpack('L')
      end

    end
  end

end  # rescue



module Win32
  class Console

    VERSION = '1.0'

    include Win32::Console::Constants

    def initialize( t = nil )
      if t and ( t == STD_INPUT_HANDLE or t == STD_OUTPUT_HANDLE or
		 t == STD_ERROR_HANDLE )
	@handle = API.GetStdHandle( t )
      else
	param1 = GENERIC_READ    | GENERIC_WRITE
	param2 = FILE_SHARE_READ | FILE_SHARE_WRITE
	@handle = API.CreateConsoleScreenBuffer( param1, param2, 
						 CONSOLE_TEXTMODE_BUFFER )
      end
    end


    def Display
      return API.SetConsoleActiveScreenBuffer(@handle)
    end

    def Select(type)
      return API.SetStdHandle(type,@handle)
    end

    def Title(title = nil)
      if title
	return API.SetConsoleTitle(title)
      else
	return API.GetConsoleTitle()
      end
    end

    def WriteChar(s, col, row)
      API.WriteConsoleOutputCharacter( @handle, s, col, row )
    end

    def ReadChar(size, col, row)
      buffer = ' ' * size
      if API.ReadConsoleOutputCharacter( @handle, buffer, size, col, row )
	return buffer
      else
	return nil
      end
    end

    def WriteAttr(attr, col, row)
      API.WriteConsoleOutputAttribute( @handle, attr, col, row )
    end

    def ReadAttr(size, col, row)
      x = API.ReadConsoleOutputAttribute( @handle, size, col, row )
      return x.unpack('c'*size)
    end


    def Cursor(*t)
      col, row, size, visi = t
      if col
	row = -1 if !row
	if col < 0 or row < 0
	  curr_col, curr_row = API.GetConsoleScreenBufferInfo(@handle)
	  col = curr_col if col < 0
	  row = curr_row if row < 0
	end
	API.SetConsoleCursorPosition( @handle, col, row )
	if size and visi
	  curr_size, curr_visi = API.GetConsoleCursorInfo( @handle )
	  size = curr_size if size < 0
	  visi = curr_visi if visi < 0
	  size = 1 if size < 1
	  size = 99 if size > 99
	  API.SetConsoleCursorInfo( @handle, size, visi )
	end
      else
	d, d, curr_col, curr_row = API.GetConsoleScreenBufferInfo(@handle)
	curr_size, curr_visi = API.GetConsoleCursorInfo( @handle )
        return [ curr_col, curr_row, curr_size, curr_visi ]
      end
    end

    def Write(s)
      API.WriteConsole( @handle, s )
    end

    def ReadRect( left, top, right, bottom )
      col = right  - left + 1
      row = bottom - top  + 1
      size = col * row
      buffer = ' ' * size * 4
      if API.ReadConsoleOutput( @handle, buffer, col, row, 0, 0, 
			       left, top, right, bottom )
	#return buffer.unpack('US'*size)  # for unicode
	return buffer.unpack('axS'*size)  # for ascii
      else
	return nil
      end
    end

    def WriteRect( buffer, left, top, right, bottom )
      col = right  - left + 1
      row = bottom - top  + 1
      API.WriteConsoleOutput( @handle, buffer, col, row, 0, 0, 
			     left, top, right, bottom )
    end



    def Scroll( left1, top1, right1, bottom1,
	       col, row, char, attr,
	       left2, top2, right2, bottom2 )
      API.ScrollConsoleScreenBuffer(@handle, left1, top1, right1, bottom1,
				    col, row, char, attr,
				    left2, top2, right2, bottom2)
    end


    def MaxWindow(flag = nil)
      if !flag
	info = API.GetConsoleScreenBufferInfo(@handle)
        return info[9], info[10]
      else
        return API.GetLargestConsoleWindowSize(@handle)
      end
    end


    def Info()
      return API.GetConsoleScreenBufferInfo( @handle )
    end


    def GetEvents()
      return API.GetNumberOfConsoleInputEvents(@handle)
    end


    def Flush()
      return API.FlushConsoleInputBuffer(@handle)
    end

    def InputChar(number = nil)
      number = 1 unless number
      buffer = ' ' * number
      if API.ReadConsole(@handle, buffer, number) == number
	return buffer
      else
	return nil
      end
    end


    def Input()
      API.ReadConsoleInput(@handle)
    end


    def PeekInput()
      API.PeekConsoleInput(@handle)
    end


    def Mode(mode = nil)
      if mode
	mode = mode.pack('L') if mode === Array
	API.SetConsoleMode(@handle, mode)
      else
	return API.GetConsoleMode(@handle)
      end
    end

    def WriteInput(*t)
      API.WriteConsoleInput(@handle, *t)
    end

    def Attr(*attr)
      if attr.size > 0
	API.SetConsoleTextAttribute( @handle, attr[0] )
      else
	info = API.GetConsoleScreenBufferInfo( @handle )
	return info[4]
      end
    end


    def Size(*t)
      if t.size == 0
	col, row = API.GetConsoleScreenBufferInfo(@handle )
        return [col, row]
      else
	row = -1 if !t[1]
	col = -1 if !t[0]
	if col < 0 or row < 0
	  curr_col, curr_row = Size()
	  col = curr_col if col < 0
	  row = curr_row if row < 0
	end
	API.SetConsoleScreenBufferSize(@handle, row, col)
      end
    end

    def Window(*t)
      if t.size != 5
	info = API.GetConsoleScreenBufferInfo( @handle )
	return info[5..8]
      else
	API.SetConsoleWindowInfo(@handle, t[0], t[1], t[2], t[3], t[4])
      end
    end

    def FillAttr(attr, number = 1, col = -1, row = -1)
      if col < 0 or row < 0
	d, d, curr_col, curr_row = API.GetConsoleScreenBufferInfo(@handle)
        col = curr_col if col < 0
        row = curr_row if row < 0
      end
      API.FillConsoleOutputAttribute(@handle, attr, number, col, row)
    end

    def FillChar(char, number, col = -1, row = -1)
      if col < 0 or row < 0
	d, d, curr_col, curr_row = API.GetConsoleScreenBufferInfo(@handle)
        col = curr_col if col < 0
        row = curr_row if row < 0
      end
      API.FillConsoleOutputCharacter(@handle, char[0], number, col, row)
    end

    def Cls()
      attr = ATTR_NORMAL
      x, y = Size()
      left, top, right , bottom = Window()
      vx = right  - left
      vy = bottom - top
      FillChar(' ', x*y, 0, 0)
      FillAttr(attr, x*y, 0, 0)
      Cursor(0,0)
      Window(1,0,0,vx,vy)
    end

    def Console.Free()
      API.FreeConsole()
    end

    def Console.Alloc()
      API.AllocConsole()
    end

    def Console.MouseButtons()
      API.GetNumberOfConsoleMouseButtons()
    end

    def Console.InputCP(codepage=nil)
      if codepage
	API.SetConsoleCP(codepage)
      else
	return API.GetConsoleCP()
      end
    end

    def Console.OutputCP(codepage=nil)
      if codepage
	API.SetConsoleOutputCP(codepage)
      else
	return API.GetConsoleOutputCP()
      end
    end

    def Console.GenerateCtrlEvent( type=nil, pid=nil )
      type = API.constant('CTRL_C_EVENT') if type == nil
      pid  = 0 if pid == nil
      API.GenerateConsoleCtrlEvent(type, pid)
    end

  end
end





FG_BLACK        = 0
FG_BLUE         = Win32::Console::API.constant("FOREGROUND_BLUE")
FG_LIGHTBLUE    = Win32::Console::API.constant("FOREGROUND_BLUE")|
                  Win32::Console::API.constant("FOREGROUND_INTENSITY")
FG_RED          = Win32::Console::API.constant("FOREGROUND_RED")
FG_LIGHTRED     = Win32::Console::API.constant("FOREGROUND_RED")|
                  Win32::Console::API.constant("FOREGROUND_INTENSITY")
FG_GREEN        = Win32::Console::API.constant("FOREGROUND_GREEN")
FG_LIGHTGREEN   = Win32::Console::API.constant("FOREGROUND_GREEN")|
                  Win32::Console::API.constant("FOREGROUND_INTENSITY")
FG_MAGENTA      = Win32::Console::API.constant("FOREGROUND_RED")|
                  Win32::Console::API.constant("FOREGROUND_BLUE")
FG_LIGHTMAGENTA = Win32::Console::API.constant("FOREGROUND_RED")|
                  Win32::Console::API.constant("FOREGROUND_BLUE")|
                  Win32::Console::API.constant("FOREGROUND_INTENSITY")
FG_CYAN         = Win32::Console::API.constant("FOREGROUND_GREEN")|
                  Win32::Console::API.constant("FOREGROUND_BLUE")
FG_LIGHTCYAN    = Win32::Console::API.constant("FOREGROUND_GREEN")|
                  Win32::Console::API.constant("FOREGROUND_BLUE")|
                  Win32::Console::API.constant("FOREGROUND_INTENSITY")
FG_BROWN        = Win32::Console::API.constant("FOREGROUND_RED")|
                  Win32::Console::API.constant("FOREGROUND_GREEN")
FG_YELLOW       = Win32::Console::API.constant("FOREGROUND_RED")|
                  Win32::Console::API.constant("FOREGROUND_GREEN")|
                  Win32::Console::API.constant("FOREGROUND_INTENSITY")
FG_GRAY         = Win32::Console::API.constant("FOREGROUND_RED")|
                  Win32::Console::API.constant("FOREGROUND_GREEN")|
                  Win32::Console::API.constant("FOREGROUND_BLUE")
FG_WHITE        = Win32::Console::API.constant("FOREGROUND_RED")|
                  Win32::Console::API.constant("FOREGROUND_GREEN")|
                  Win32::Console::API.constant("FOREGROUND_BLUE")|
                  Win32::Console::API.constant("FOREGROUND_INTENSITY")

BG_BLACK        = 0
BG_BLUE         = Win32::Console::API.constant("BACKGROUND_BLUE")
BG_LIGHTBLUE    = Win32::Console::API.constant("BACKGROUND_BLUE")|
                  Win32::Console::API.constant("BACKGROUND_INTENSITY")
BG_RED          = Win32::Console::API.constant("BACKGROUND_RED")
BG_LIGHTRED     = Win32::Console::API.constant("BACKGROUND_RED")|
                  Win32::Console::API.constant("BACKGROUND_INTENSITY")
BG_GREEN        = Win32::Console::API.constant("BACKGROUND_GREEN")
BG_LIGHTGREEN   = Win32::Console::API.constant("BACKGROUND_GREEN")|
                  Win32::Console::API.constant("BACKGROUND_INTENSITY")
BG_MAGENTA      = Win32::Console::API.constant("BACKGROUND_RED")|
                  Win32::Console::API.constant("BACKGROUND_BLUE")
BG_LIGHTMAGENTA = Win32::Console::API.constant("BACKGROUND_RED")|
                  Win32::Console::API.constant("BACKGROUND_BLUE")|
                  Win32::Console::API.constant("BACKGROUND_INTENSITY")
BG_CYAN         = Win32::Console::API.constant("BACKGROUND_GREEN")|
                  Win32::Console::API.constant("BACKGROUND_BLUE")
BG_LIGHTCYAN    = Win32::Console::API.constant("BACKGROUND_GREEN")|
                  Win32::Console::API.constant("BACKGROUND_BLUE")|
                  Win32::Console::API.constant("BACKGROUND_INTENSITY")
BG_BROWN        = Win32::Console::API.constant("BACKGROUND_RED")|
                  Win32::Console::API.constant("BACKGROUND_GREEN")
BG_YELLOW       = Win32::Console::API.constant("BACKGROUND_RED")|
                  Win32::Console::API.constant("BACKGROUND_GREEN")|
                  Win32::Console::API.constant("BACKGROUND_INTENSITY")
BG_GRAY         = Win32::Console::API.constant("BACKGROUND_RED")|
                  Win32::Console::API.constant("BACKGROUND_GREEN")|
                  Win32::Console::API.constant("BACKGROUND_BLUE")
BG_WHITE        = Win32::Console::API.constant("BACKGROUND_RED")|
                  Win32::Console::API.constant("BACKGROUND_GREEN")|
                  Win32::Console::API.constant("BACKGROUND_BLUE")|
                  Win32::Console::API.constant("BACKGROUND_INTENSITY")

ATTR_NORMAL  = FG_GRAY  | BG_BLACK
ATTR_INVERSE = FG_BLACK | BG_GRAY

include Win32::Console::Constants

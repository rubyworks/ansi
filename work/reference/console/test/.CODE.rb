


@_deferred = []
@_errormsg = nil
@_finished = nil

begin

  def defer(&i)
    @_deferred.push( i )
  end

  def reject(*i)
    if !i || i[0]
      @_errormsg = i[1] if i[1]
      throw :paramout
    end
  end

  def finish(i)
    if !i || i[0]
      @_finished = 1
    end
  end

  @unused = []
  @cache  = {}
  _FOUND_ = {}
  _errors = 0
  _invalid = {}
  _lastprefix = nil

  _pos     = 0   # current position to match from
  _nextpos = 0   # next position to match from

  catch(:alldone) do 
    while !@_finished
      begin
	catch(:arg) do
	  @_errormsg = nil

	  # This is used for clustering of flags
	  while _lastprefix
	    substr = _args[_nextpos..-1]
	    substr =~ /^(?!\s|\0|\Z)(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)/ or
	      begin 
		_lastprefix=nil
		break
	      end
	    "#{_lastprefix}#{substr}" =~ /^((?:\-r|\-no_directories|\-nd|\-no_sequences|\-ns|\-no_movies|\-nm|\-no_files|\-nf|\-m|\-full_path|\-fp|\-fmt|\-color_directories|\-cd|\-color_sequences|\-cs|\-color_movies|\-cm|\-color_files|\-cf))/ or
	      begin 
		_lastprefix=nil
		break
	      end
	    _args = _args[0.._nextpos-1] + _lastprefix + _args[_nextpos..-1]
	    break
	  end #  while _lastprefix

	  
	  _pos = _nextpos if _args

	  usage(0) if _args && gindex(_args,/\G(--HELP|--Help|-HELP|-Help|-help|-H|-h|--help)(\s|\0|\Z)/,_pos)
          version(0) if _args && _args =~ /(-version|-VERSION|-Version|--VERSION|--Version|--version|-V|-v)(\s|\0|\Z)/
      
          catch(:paramout) do
            while !_FOUND_['-color_directories']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-color_directories/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-color_directories' parameter|
                  end

                  _PARAM_ = '-color_directories'

                  _args && _pos = gindex( _args, /\G(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:clear|reset|bold|dark|italic|underline|underscore|blink|rapid_blink|negative|concealed|strikethrough|black|red|green|yellow|blue|magenta|cyan|white|on_black|on_red|on_green|on_yellow|on_blue|on_magenta|on_cyan|on_white))))/xi, _pos ) or throw(:paramout)
	          _VAR_ = %q|<c>|
	          _VAL_ = @@m[0]
		  _VAL_.tr!("\0"," ") if _VAL_
		  c = _VAL_

                  if _invalid.has_key?('-color_directories')
                    @_errormsg = %q|parameter '-color_directories' not allowed with parameter '| + _invalid['-color_directories'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-color_directories'
                    end
                  end  #if/then


                   @cache['-cd'] = c 
		  @cache['-color_directories'] = c
                  _lastprefix = "\-"

                  _FOUND_['-color_directories'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-color_sequences']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-color_sequences/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-color_sequences' parameter|
                  end

                  _PARAM_ = '-color_sequences'

                  _args && _pos = gindex( _args, /\G(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:clear|reset|bold|dark|italic|underline|underscore|blink|rapid_blink|negative|concealed|strikethrough|black|red|green|yellow|blue|magenta|cyan|white|on_black|on_red|on_green|on_yellow|on_blue|on_magenta|on_cyan|on_white))))/xi, _pos ) or throw(:paramout)
	          _VAR_ = %q|<c>|
	          _VAL_ = @@m[0]
		  _VAL_.tr!("\0"," ") if _VAL_
		  c = _VAL_

                  if _invalid.has_key?('-color_sequences')
                    @_errormsg = %q|parameter '-color_sequences' not allowed with parameter '| + _invalid['-color_sequences'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-color_sequences'
                    end
                  end  #if/then


                   @cache['-cs'] = c 
		  @cache['-color_sequences'] = c
                  _lastprefix = "\-"

                  _FOUND_['-color_sequences'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-no_directories']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-no_directories/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-no_directories' parameter|
                  end

                  _PARAM_ = '-no_directories'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-no_directories')
                    @_errormsg = %q|parameter '-no_directories' not allowed with parameter '| + _invalid['-no_directories'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-no_directories'
                    end
                  end  #if/then


                   @cache['-nd'] = '-nd' 

                  @cache['-no_directories'] = '-no_directories'
                  _lastprefix = "\-"

                  _FOUND_['-no_directories'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-color_movies']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-color_movies/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-color_movies' parameter|
                  end

                  _PARAM_ = '-color_movies'

                  _args && _pos = gindex( _args, /\G(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:clear|reset|bold|dark|italic|underline|underscore|blink|rapid_blink|negative|concealed|strikethrough|black|red|green|yellow|blue|magenta|cyan|white|on_black|on_red|on_green|on_yellow|on_blue|on_magenta|on_cyan|on_white))))/xi, _pos ) or throw(:paramout)
	          _VAR_ = %q|<c>|
	          _VAL_ = @@m[0]
		  _VAL_.tr!("\0"," ") if _VAL_
		  c = _VAL_

                  if _invalid.has_key?('-color_movies')
                    @_errormsg = %q|parameter '-color_movies' not allowed with parameter '| + _invalid['-color_movies'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-color_movies'
                    end
                  end  #if/then


                   @cache['-cm'] = c 
		  @cache['-color_movies'] = c
                  _lastprefix = "\-"

                  _FOUND_['-color_movies'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-no_sequences']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-no_sequences/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-no_sequences' parameter|
                  end

                  _PARAM_ = '-no_sequences'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-no_sequences')
                    @_errormsg = %q|parameter '-no_sequences' not allowed with parameter '| + _invalid['-no_sequences'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-no_sequences'
                    end
                  end  #if/then


                   @cache['-ns'] = '-ns' 

                  @cache['-no_sequences'] = '-no_sequences'
                  _lastprefix = "\-"

                  _FOUND_['-no_sequences'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-color_files']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-color_files/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-color_files' parameter|
                  end

                  _PARAM_ = '-color_files'

                  _args && _pos = gindex( _args, /\G(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:clear|reset|bold|dark|italic|underline|underscore|blink|rapid_blink|negative|concealed|strikethrough|black|red|green|yellow|blue|magenta|cyan|white|on_black|on_red|on_green|on_yellow|on_blue|on_magenta|on_cyan|on_white))))/xi, _pos ) or throw(:paramout)
	          _VAR_ = %q|<c>|
	          _VAL_ = @@m[0]
		  _VAL_.tr!("\0"," ") if _VAL_
		  c = _VAL_

                  if _invalid.has_key?('-color_files')
                    @_errormsg = %q|parameter '-color_files' not allowed with parameter '| + _invalid['-color_files'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-color_files'
                    end
                  end  #if/then


                   @cache['-cf'] = c 
		  @cache['-color_files'] = c
                  _lastprefix = "\-"

                  _FOUND_['-color_files'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-no_movies']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-no_movies/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-no_movies' parameter|
                  end

                  _PARAM_ = '-no_movies'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-no_movies')
                    @_errormsg = %q|parameter '-no_movies' not allowed with parameter '| + _invalid['-no_movies'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-no_movies'
                    end
                  end  #if/then


                   @cache['-nm'] = '-nm' 

                  @cache['-no_movies'] = '-no_movies'
                  _lastprefix = "\-"

                  _FOUND_['-no_movies'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-full_path']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-full_path/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-full_path' parameter|
                  end

                  _PARAM_ = '-full_path'

                  _args && _pos = gindex( _args, /\G(?:()(?:\s|\0)*((?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)s)())?/xi, _pos ) or throw(:paramout)
                  if @@m[1] && !@@m[1].empty?
                    _PUNCT_['s'] = @@m[1]
                  end

                  if _invalid.has_key?('-full_path')
                    @_errormsg = %q|parameter '-full_path' not allowed with parameter '| + _invalid['-full_path'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-full_path'
                    end
                  end  #if/then

                  @cache['-full_path'] = _PUNCT_['s'] || 1
                  _lastprefix = "\-"

                  _FOUND_['-full_path'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-no_files']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-no_files/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-no_files' parameter|
                  end

                  _PARAM_ = '-no_files'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-no_files')
                    @_errormsg = %q|parameter '-no_files' not allowed with parameter '| + _invalid['-no_files'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-no_files'
                    end
                  end  #if/then


                   @cache['-nf'] = '-nf' 

                  @cache['-no_files'] = '-no_files'
                  _lastprefix = "\-"

                  _FOUND_['-no_files'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-fmt']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-fmt/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-fmt' parameter|
                  end

                  _PARAM_ = '-fmt'

                  _args && _pos = gindex( _args, /\G(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)ilm|dd|shake))/xi, _pos ) or throw(:paramout)
	          _VAR_ = %q|<p>|
	          _VAL_ = @@m[0]
		  _VAL_.tr!("\0"," ") if _VAL_
		  p = _VAL_

                  if _invalid.has_key?('-fmt')
                    @_errormsg = %q|parameter '-fmt' not allowed with parameter '| + _invalid['-fmt'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-fmt'
                    end
                  end  #if/then

		  @cache['-fmt'] = p
                  _lastprefix = "\-"

                  _FOUND_['-fmt'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-cf']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-cf/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-cf' parameter|
                  end

                  _PARAM_ = '-cf'

                  _args && _pos = gindex( _args, /\G(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:clear|reset|bold|dark|italic|underline|underscore|blink|rapid_blink|negative|concealed|strikethrough|black|red|green|yellow|blue|magenta|cyan|white|on_black|on_red|on_green|on_yellow|on_blue|on_magenta|on_cyan|on_white))))/xi, _pos ) or throw(:paramout)
	          _VAR_ = %q|<c>|
	          _VAL_ = @@m[0]
		  _VAL_.tr!("\0"," ") if _VAL_
		  c = _VAL_

                  if _invalid.has_key?('-cf')
                    @_errormsg = %q|parameter '-cf' not allowed with parameter '| + _invalid['-cf'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-cf'
                    end
                  end  #if/then


                   @cache['-cf'] = c 
		  @cache['-cf'] = c
                  _lastprefix = "\-"

                  _FOUND_['-cf'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-nf']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-nf/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-nf' parameter|
                  end

                  _PARAM_ = '-nf'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-nf')
                    @_errormsg = %q|parameter '-nf' not allowed with parameter '| + _invalid['-nf'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-nf'
                    end
                  end  #if/then


                  @cache['-nf'] = '-nf'
                  _lastprefix = "\-"

                  _FOUND_['-nf'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-nm']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-nm/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-nm' parameter|
                  end

                  _PARAM_ = '-nm'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-nm')
                    @_errormsg = %q|parameter '-nm' not allowed with parameter '| + _invalid['-nm'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-nm'
                    end
                  end  #if/then


                  @cache['-nm'] = '-nm'
                  _lastprefix = "\-"

                  _FOUND_['-nm'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-ns']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-ns/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-ns' parameter|
                  end

                  _PARAM_ = '-ns'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-ns')
                    @_errormsg = %q|parameter '-ns' not allowed with parameter '| + _invalid['-ns'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-ns'
                    end
                  end  #if/then


                  @cache['-ns'] = '-ns'
                  _lastprefix = "\-"

                  _FOUND_['-ns'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-cd']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-cd/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-cd' parameter|
                  end

                  _PARAM_ = '-cd'

                  _args && _pos = gindex( _args, /\G(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:clear|reset|bold|dark|italic|underline|underscore|blink|rapid_blink|negative|concealed|strikethrough|black|red|green|yellow|blue|magenta|cyan|white|on_black|on_red|on_green|on_yellow|on_blue|on_magenta|on_cyan|on_white))))/xi, _pos ) or throw(:paramout)
	          _VAR_ = %q|<c>|
	          _VAL_ = @@m[0]
		  _VAL_.tr!("\0"," ") if _VAL_
		  c = _VAL_

                  if _invalid.has_key?('-cd')
                    @_errormsg = %q|parameter '-cd' not allowed with parameter '| + _invalid['-cd'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-cd'
                    end
                  end  #if/then


                   @cache['-cd'] = c 
		  @cache['-cd'] = c
                  _lastprefix = "\-"

                  _FOUND_['-cd'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-nd']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-nd/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-nd' parameter|
                  end

                  _PARAM_ = '-nd'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-nd')
                    @_errormsg = %q|parameter '-nd' not allowed with parameter '| + _invalid['-nd'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-nd'
                    end
                  end  #if/then


                  @cache['-nd'] = '-nd'
                  _lastprefix = "\-"

                  _FOUND_['-nd'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-cs']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-cs/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-cs' parameter|
                  end

                  _PARAM_ = '-cs'

                  _args && _pos = gindex( _args, /\G(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:clear|reset|bold|dark|italic|underline|underscore|blink|rapid_blink|negative|concealed|strikethrough|black|red|green|yellow|blue|magenta|cyan|white|on_black|on_red|on_green|on_yellow|on_blue|on_magenta|on_cyan|on_white))))/xi, _pos ) or throw(:paramout)
	          _VAR_ = %q|<c>|
	          _VAL_ = @@m[0]
		  _VAL_.tr!("\0"," ") if _VAL_
		  c = _VAL_

                  if _invalid.has_key?('-cs')
                    @_errormsg = %q|parameter '-cs' not allowed with parameter '| + _invalid['-cs'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-cs'
                    end
                  end  #if/then


                   @cache['-cs'] = c 
		  @cache['-cs'] = c
                  _lastprefix = "\-"

                  _FOUND_['-cs'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-fp']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-fp/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-fp' parameter|
                  end

                  _PARAM_ = '-fp'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-fp')
                    @_errormsg = %q|parameter '-fp' not allowed with parameter '| + _invalid['-fp'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-fp'
                    end
                  end  #if/then


                  @cache['-fp'] = '-fp'
                  _lastprefix = "\-"

                  _FOUND_['-fp'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-cm']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-cm/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-cm' parameter|
                  end

                  _PARAM_ = '-cm'

                  _args && _pos = gindex( _args, /\G(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:clear|reset|bold|dark|italic|underline|underscore|blink|rapid_blink|negative|concealed|strikethrough|black|red|green|yellow|blue|magenta|cyan|white|on_black|on_red|on_green|on_yellow|on_blue|on_magenta|on_cyan|on_white))))/xi, _pos ) or throw(:paramout)
	          _VAR_ = %q|<c>|
	          _VAL_ = @@m[0]
		  _VAL_.tr!("\0"," ") if _VAL_
		  c = _VAL_

                  if _invalid.has_key?('-cm')
                    @_errormsg = %q|parameter '-cm' not allowed with parameter '| + _invalid['-cm'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-cm'
                    end
                  end  #if/then


                   @cache['-cm'] = c 
		  @cache['-cm'] = c
                  _lastprefix = "\-"

                  _FOUND_['-cm'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-r']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-r/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-r' parameter|
                  end

                  _PARAM_ = '-r'

                  _args && _pos = gindex( _args, /\G/xi, _pos ) or throw(:paramout)

                  if _invalid.has_key?('-r')
                    @_errormsg = %q|parameter '-r' not allowed with parameter '| + _invalid['-r'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-r'
                    end
                  end  #if/then


                  @cache['-r'] = '-r'
                  _lastprefix = "\-"

                  _FOUND_['-r'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['-m']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*\-m/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '-m' parameter|
                  end

                  _PARAM_ = '-m'

                  _args && _pos = gindex( _args, /\G(?:()(?:\s|\0)*((?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)issing)())?/xi, _pos ) or throw(:paramout)
                  if @@m[1] && !@@m[1].empty?
                    _PUNCT_['issing'] = @@m[1]
                  end

                  if _invalid.has_key?('-m')
                    @_errormsg = %q|parameter '-m' not allowed with parameter '| + _invalid['-m'] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = '-m'
                    end
                  end  #if/then

                  @cache['-m'] = _PUNCT_['issing'] || 1
                  _lastprefix = "\-"

                  _FOUND_['-m'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)

          catch(:paramout) do
            while !_FOUND_['<dirs>']
              begin
                catch(:param) do
                  _pos = _nextpos if _args
                  _PUNCT_ = {}
              
                  _args && _pos = gindex( _args, /\G(?:\s|\0)*/i, _pos) or throw(:paramout) 
                  unless @_errormsg
		    @_errormsg = %q|incorrect specification of '' parameter|
                  end

                  _PARAM_ = '<dirs>'

                  _args && _pos = gindex( _args, /\G(?:()(?:\s|\0)*((?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:\S|\0))+)(?:\s+(?:(?!\-r)(?!\-no_directories)(?!\-nd)(?!\-no_sequences)(?!\-ns)(?!\-no_movies)(?!\-nm)(?!\-no_files)(?!\-nf)(?!\-m)(?!\-full_path)(?!\-fp)(?!\-fmt)(?!\-color_directories)(?!\-cd)(?!\-color_sequences)(?!\-cs)(?!\-color_movies)(?!\-cm)(?!\-color_files)(?!\-cf)(?:(?:\S|\0))+))*)())?/xi, _pos ) or throw(:paramout)
		  _VAR_ = %q|<dirs>|
		  _VAL_ = nil
		  dirs = (@@m[1]||'').split(' ').map { |i| 
                                                           i.tr("\0", " ") }

                  if _invalid.has_key?('')
                    @_errormsg = %q|parameter '' not allowed with parameter '| + _invalid[''] + %q|'|
                    throw(:paramout)
                  else
		    for i in []
		        _invalid[i] = ''
                    end
                  end  #if/then

		  @cache['<dirs>'] = dirs
                  _lastprefix = nil

                  _FOUND_['<dirs>'] = 1
                  throw :arg if _pos > 0
		  _nextpos = _args.length()
                  throw :alldone
                end  # catch(:param)
	      end  # begin
            end # while
          end # catch(:paramout)


	if _lastprefix
           _pos = _nextpos + _lastprefix.length()
	   _lastprefix = nil
	   next
        end

	  _pos = _nextpos

	  _args && _pos = gindex( _args, /\G(?:\s|\0)*(\S+)/, _pos ) or throw(:alldone)

	  if @_errormsg
             $stderr.puts( "Error#{source}: #{@_errormsg}\n" )
          else
             @unused.push( @@m[0] )
          end

	  _errors += 1 if @_errormsg

        end  # catch(:arg)

      ensure  # begin
        _pos = 0 if _pos.nil?
	_nextpos = _pos if _args
	if _args and _args.index( /\G(\s|\0)*\Z/, _pos )
	  _args = _get_nextline.call(self) if !@_finished
          throw(:alldone) unless _args
          _pos = _nextpos = 0
          _lastprefix = ''
	end   # if
      end   # begin/ensure
    end   # while @_finished
  end   # catch(:alldone)
end  # begin


#################### Add unused arguments
if _args && _nextpos > 0 && _args.length() > 0
    @unused.push( _args[_nextpos..-1].split(' ' ) )
end

for i in @unused
    i.tr!( "\0", " " )
end


#################### Print help hint
if _errors > 0 && !@source.nil?
  $stderr.puts "\n(try '#$0 -help' for more information)"
end

## cannot just assign unused to ARGV in ruby
unless @source != ''
  ARGV.clear
  @unused.map { |i| ARGV.push(i) }
end

unless _errors > 0
  for i in @_deferred
    begin
      i.call()
    rescue => e
      raise "Error: action in Getopt::Declare specification produced:\n" + e
    end
  end
end

!(_errors>0)  # return true or false (false for errors)


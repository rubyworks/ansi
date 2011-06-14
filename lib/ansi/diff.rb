require 'ansi/code'

module ANSI

  # Diff can produced a colorized difference of two string or objects.
  class Diff

    #
    def initialize(object1, object2, options={})
      @object1 = convert(object1)
      @object2 = convert(object2)

      @diff1, @diff2 = diff_string(@object1, @object2)
    end

    #
    def diff1
      @diff1
    end

    #
    def diff2
      @diff2
    end

    #
    def to_s
      "#{@diff1}\n#{@diff2}"
    end

    private

    # Take two plain strings and produce colorized
    # versions of each highlighting their differences.
    def diff_string(string1, string2)
      compare(string1, string2)
    end

    # Ensure the object of comparison is a string. If +object+ is not
    # an instance of String then it wll be converted to one by calling
    # either #to_str, if the object responds to it, or #inspect.
    def convert(object)
      if String === object
        object
      elsif object.respond_to?(:to_str)
        object.to_str
      else
        object.inspect
      end
    end

    # Rotation of colors for diff output.
    COLORS = [:red, :yellow, :magenta]

    #
    def compare(x, y)
      c = common(x, y)
      a = x.dup
      b = y.dup
      oi = 0
      oj = 0
      c.each_with_index do |m, q|
        i = a.index(m, oi)
        j = b.index(m, oj)
        a[i,m.size] = ANSI.ansi(m, COLORS[q%3]) if i
        b[j,m.size] = ANSI.ansi(m, COLORS[q%3]) if j
        oi = i + m.size if i
        oj = j + m.size if j
      end
      return a, b
    end

    #
    def common(x,y)
      c = lcs(x, y)

      i = x.index(c)
      j = y.index(c)

      ix = i + c.size
      jx = j + c.size

      if i == 0 
        l = y[0...j]
      elsif j == 0
        l = x[0...i]
      else
        l = common(x[0...i], y[0...j])
      end

      if ix == x.size - 1
        r = y[jx..-1]
      elsif jx = y.size - 1
        r = x[ix..-1]
      else
        r = common(x[ix..-1], y[jx..-1])
      end

      [l, c, r].flatten.reject{ |s| s.empty? }
    end

    #
    def lcs_size(s1, s2)
      num=Array.new(s1.size){Array.new(s2.size)}
      len,ans=0
      s1.scan(/./).each_with_index do |l1,i |
        s2.scan(/./).each_with_index do |l2,j |
          unless l1==l2
            num[i][j]=0
          else
            (i==0 || j==0)? num[i][j]=1 : num[i][j]=1 + num[i-1][j-1]
            len = ans = num[i][j] if num[i][j] > len
          end
        end
      end
      ans
    end

    #
    def lcs(s1, s2)
      res="" 
      num=Array.new(s1.size){Array.new(s2.size)}
      len,ans=0
      lastsub=0
      s1.scan(/./).each_with_index do |l1,i |
        s2.scan(/./).each_with_index do |l2,j |
          unless l1==l2
            num[i][j]=0
          else
            (i==0 || j==0)? num[i][j]=1 : num[i][j]=1 + num[i-1][j-1]
            if num[i][j] > len
              len = ans = num[i][j]
              thissub = i
              thissub -= num[i-1][j-1] unless num[i-1][j-1].nil?  
              if lastsub==thissub
                res+=s1[i,1]
              else
                lastsub=thissub
                res=s1[lastsub, (i+1)-lastsub]
              end
            end
          end
        end
      end
      res
    end

  end

end

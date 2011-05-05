require 'ansi/code'

module ANSI

  # Diff can produced a colorized difference of two string or objects.
  #
  # IMPORTANT! This class is still a very much a work in progress.
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
    #
    # TODO: I am sure there are better ways to do this,
    # but for now this suffices.
    def diff_string(str1, str2)
      i1, i2 = 0, 0
      m1, m2 = nil, nil
      s1, s2 = "", ""
      t1, t2 = "", ""
      c = 0

      loop do
        if str1[i1,1] == str2[i2,1]
          s1 << red(t1); t1 = "" unless t1 == ""
          s2 << red(t2); t2 = "" unless t2 == ""
          s1 << str1[i1,1].to_s
          s2 << str2[i2,1].to_s
          i1 += 1; i2 += 1
          #m1 += 1; m2 += 1
        else
          if m1 && str1[m1,1] == str2[i2,1]
            s2 << color1(t2)
            t1, t2 = "", ""
            i1 = m1
            m1, m2 = nil, nil
          elsif m2 && str1[i1,1] == str2[m2,1]
            s1 << color2(t1)
            t1, t2 = "", ""
            i2 = m2
            m1, m2 = nil, nil
          else
            t1 << str1[i1,1].to_s
            t2 << str2[i2,1].to_s
            m1, m2 = i1, i2 if m1 == nil
            i1 += 1; i2 += 1
          end
        end
        break if i1 >= str1.size && i2 >= str2.size
      end
      s1 << red(t1); t1 = "" unless t1 == ""
      s2 << red(t2); t2 = "" unless t2 == ""
      #s1 << ANSI::Code::CLEAR
      #s2 << ANSI::Code::CLEAR

      return s1, s2
    end

    #
    def red(str)
      ANSI.color(:red){ str }
    end

    #
    def color1(str)
      ANSI.color(:blue){ str }
    end

    #
    def color2(str)
      ANSI.color(:green){ str }
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

  end

end

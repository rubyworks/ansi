require 'ansi/bbcode'

class TC_BBCode < KO::TestCase

  test "to_ansi" do
    str = "this is [COLOR=red]red[/COLOR], this is [B]bold[/B]"
    out = "this is \e[0;31mred\e[0m, this is \e[1mbold\e[0m\n"
    out == ANSI::BBCode.bbcode_to_ansi(str)
  end

  test "to_html" do
    str = "this is [COLOR=red]red[/COLOR], this is [B]bold[/B]"
    out = "this is <font color=\"red\">red</font>, this is <strong>bold</strong><br />\n"
    out == ANSI::BBCode.bbcode_to_html(str)
  end

  test "ansi_to_html" do
    str = "this is \e[0;31mred\e[0m, this is \e[1mbold\e[0m\n" +
          "this is a line without any ansi code\n" +
          "this is \e[0;31mred\e[0m, this is \e[1mbold\e[0m\n"
    out = "this is <font color=\"red\">red</font>, this is <strong>bold</strong><br />\n" +
          "this is a line without any ansi code<br />\n" +
          "this is <font color=\"red\">red</font>, this is <strong>bold</strong><br />\n"
    out == ANSI::BBCode.ansi_to_html(str)
  end

end


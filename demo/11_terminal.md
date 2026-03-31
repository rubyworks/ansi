# ANSI::Terminal

We should be able to get the terminal width via the `terminal_width` method.

    width = ANSI::Terminal.terminal_width

    Integer.assert === width


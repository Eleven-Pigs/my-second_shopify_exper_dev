# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `ansi` gem.
# Please instead update this file by running `bin/tapioca gem ansi`.

# ANSI namespace module contains all the ANSI related classes.
module ANSI
  extend ::ANSI::Constants
  extend ::ANSI::Code
end

# Table of codes used throughout the system.
ANSI::CHART = T.let(T.unsafe(nil), Hash)

# ANSI Codes
#
# Ansi::Code module makes it very easy to use ANSI codes.
# These are especially nice for beautifying shell output.
#
# Ansi::Code.red + "Hello" + Ansi::Code.blue + "World"
# => "\e[31mHello\e[34mWorld"
#
# Ansi::Code.red{ "Hello" } + Ansi::Code.blue{ "World" }
# => "\e[31mHello\e[0m\e[34mWorld\e[0m"
#
# IMPORTANT! Do not mixin Ansi::Code, instead use {ANSI::Mixin}.
#
# See {ANSI::CHART} for list of all supported codes.
module ANSI::Code
  include ::ANSI::Constants
  extend ::ANSI::Constants
  extend ::ANSI::Code

  # Return ANSI code given a list of symbolic names.
  def [](*codes); end

  # Apply ANSI codes to a first argument or block value.
  def ansi(*codes); end

  # Move cursor left a specified number of spaces.
  def back(spaces = T.unsafe(nil)); end

  def black_on_black(string = T.unsafe(nil)); end
  def black_on_blue(string = T.unsafe(nil)); end
  def black_on_cyan(string = T.unsafe(nil)); end
  def black_on_green(string = T.unsafe(nil)); end
  def black_on_magenta(string = T.unsafe(nil)); end
  def black_on_red(string = T.unsafe(nil)); end
  def black_on_white(string = T.unsafe(nil)); end
  def black_on_yellow(string = T.unsafe(nil)); end
  def blue_on_black(string = T.unsafe(nil)); end
  def blue_on_blue(string = T.unsafe(nil)); end
  def blue_on_cyan(string = T.unsafe(nil)); end
  def blue_on_green(string = T.unsafe(nil)); end
  def blue_on_magenta(string = T.unsafe(nil)); end
  def blue_on_red(string = T.unsafe(nil)); end
  def blue_on_white(string = T.unsafe(nil)); end
  def blue_on_yellow(string = T.unsafe(nil)); end

  # Look-up code from chart, or if Integer simply pass through.
  # Also resolves :random and :on_random.
  def code(*codes); end

  # Apply ANSI codes to a first argument or block value.
  # Alternate term for #ansi.
  def color(*codes); end

  def cyan_on_black(string = T.unsafe(nil)); end
  def cyan_on_blue(string = T.unsafe(nil)); end
  def cyan_on_cyan(string = T.unsafe(nil)); end
  def cyan_on_green(string = T.unsafe(nil)); end
  def cyan_on_magenta(string = T.unsafe(nil)); end
  def cyan_on_red(string = T.unsafe(nil)); end
  def cyan_on_white(string = T.unsafe(nil)); end
  def cyan_on_yellow(string = T.unsafe(nil)); end

  # Like +move+ but returns to original position after
  # yielding the block.
  def display(line, column = T.unsafe(nil)); end

  # Move cursor down a specified number of spaces.
  def down(spaces = T.unsafe(nil)); end

  # Move cursor right a specified number of spaces.
  def forward(spaces = T.unsafe(nil)); end

  def green_on_black(string = T.unsafe(nil)); end
  def green_on_blue(string = T.unsafe(nil)); end
  def green_on_cyan(string = T.unsafe(nil)); end
  def green_on_green(string = T.unsafe(nil)); end
  def green_on_magenta(string = T.unsafe(nil)); end
  def green_on_red(string = T.unsafe(nil)); end
  def green_on_white(string = T.unsafe(nil)); end
  def green_on_yellow(string = T.unsafe(nil)); end

  # Creates an xterm-256 color code from a CSS-style color string.
  def hex_code(string, background = T.unsafe(nil)); end

  # Move cursor left a specified number of spaces.
  def left(spaces = T.unsafe(nil)); end

  def magenta_on_black(string = T.unsafe(nil)); end
  def magenta_on_blue(string = T.unsafe(nil)); end
  def magenta_on_cyan(string = T.unsafe(nil)); end
  def magenta_on_green(string = T.unsafe(nil)); end
  def magenta_on_magenta(string = T.unsafe(nil)); end
  def magenta_on_red(string = T.unsafe(nil)); end
  def magenta_on_white(string = T.unsafe(nil)); end
  def magenta_on_yellow(string = T.unsafe(nil)); end

  # Use method missing to dispatch ANSI code methods.
  def method_missing(code, *args, &blk); end

  # Move cursor to line and column.
  def move(line, column = T.unsafe(nil)); end

  # Provides a random primary ANSI color.
  def random(background = T.unsafe(nil)); end

  def red_on_black(string = T.unsafe(nil)); end
  def red_on_blue(string = T.unsafe(nil)); end
  def red_on_cyan(string = T.unsafe(nil)); end
  def red_on_green(string = T.unsafe(nil)); end
  def red_on_magenta(string = T.unsafe(nil)); end
  def red_on_red(string = T.unsafe(nil)); end
  def red_on_white(string = T.unsafe(nil)); end
  def red_on_yellow(string = T.unsafe(nil)); end

  # Creates an XTerm 256 color escape code from RGB value(s). The
  # RGB value can be three arguments red, green and blue respectively
  # each from 0 to 255, or the RGB value can be a single CSS-style
  # hex string.
  def rgb(*args); end

  # Given red, green and blue values between 0 and 255, this method
  # returns the closest XTerm 256 color value.
  def rgb_256(r, g, b); end

  # Creates an xterm-256 color from rgb value.
  def rgb_code(red, green, blue, background = T.unsafe(nil)); end

  # Move cursor right a specified number of spaces.
  def right(spaces = T.unsafe(nil)); end

  # Apply ANSI codes to a first argument or block value.
  # Alias for #ansi method.
  def style(*codes); end

  # Remove ANSI codes from string or block value.
  def unansi(string = T.unsafe(nil)); end

  # Remove ANSI codes from string or block value.
  # Alias for unansi.
  def uncolor(string = T.unsafe(nil)); end

  # Remove ANSI codes from string or block value.
  # Alias for #unansi method.
  def unstyle(string = T.unsafe(nil)); end

  # Move cursor up a specified number of spaces.
  def up(spaces = T.unsafe(nil)); end

  def white_on_black(string = T.unsafe(nil)); end
  def white_on_blue(string = T.unsafe(nil)); end
  def white_on_cyan(string = T.unsafe(nil)); end
  def white_on_green(string = T.unsafe(nil)); end
  def white_on_magenta(string = T.unsafe(nil)); end
  def white_on_red(string = T.unsafe(nil)); end
  def white_on_white(string = T.unsafe(nil)); end
  def white_on_yellow(string = T.unsafe(nil)); end
  def yellow_on_black(string = T.unsafe(nil)); end
  def yellow_on_blue(string = T.unsafe(nil)); end
  def yellow_on_cyan(string = T.unsafe(nil)); end
  def yellow_on_green(string = T.unsafe(nil)); end
  def yellow_on_magenta(string = T.unsafe(nil)); end
  def yellow_on_red(string = T.unsafe(nil)); end
  def yellow_on_white(string = T.unsafe(nil)); end
  def yellow_on_yellow(string = T.unsafe(nil)); end

  class << self
    # List of primary colors.
    def colors; end

    # List of primary styles.
    def styles; end
  end
end

# ANSI clear code.
ANSI::Code::ENDCODE = T.let(T.unsafe(nil), String)

# Regexp for matching most ANSI codes.
ANSI::Code::PATTERN = T.let(T.unsafe(nil), Regexp)

# Converts {CHART} and {SPECIAL_CHART} entries into constants.
# So for example, the CHART entry for :red becomes:
#
# ANSI::Constants::RED  #=> "\e[31m"
#
# The ANSI Constants are include into ANSI::Code and can be included
# any where will they would be of use.
module ANSI::Constants; end

ANSI::Constants::BLACK = T.let(T.unsafe(nil), String)
ANSI::Constants::BLINK = T.let(T.unsafe(nil), String)
ANSI::Constants::BLINK_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::BLUE = T.let(T.unsafe(nil), String)
ANSI::Constants::BOLD = T.let(T.unsafe(nil), String)
ANSI::Constants::BOLD_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::BRIGHT = T.let(T.unsafe(nil), String)
ANSI::Constants::BRIGHT_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::CLEAN = T.let(T.unsafe(nil), String)
ANSI::Constants::CLEAR = T.let(T.unsafe(nil), String)
ANSI::Constants::CLEAR_EOL = T.let(T.unsafe(nil), String)
ANSI::Constants::CLEAR_LEFT = T.let(T.unsafe(nil), String)
ANSI::Constants::CLEAR_LINE = T.let(T.unsafe(nil), String)
ANSI::Constants::CLEAR_RIGHT = T.let(T.unsafe(nil), String)
ANSI::Constants::CLEAR_SCREEN = T.let(T.unsafe(nil), String)
ANSI::Constants::CLR = T.let(T.unsafe(nil), String)
ANSI::Constants::CLS = T.let(T.unsafe(nil), String)
ANSI::Constants::CONCEAL = T.let(T.unsafe(nil), String)
ANSI::Constants::CONCEALED = T.let(T.unsafe(nil), String)
ANSI::Constants::CONCEAL_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::CROSSED_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::CROSSED_OUT_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::CURSOR_HIDE = T.let(T.unsafe(nil), String)
ANSI::Constants::CURSOR_SHOW = T.let(T.unsafe(nil), String)
ANSI::Constants::CYAN = T.let(T.unsafe(nil), String)
ANSI::Constants::DARK = T.let(T.unsafe(nil), String)
ANSI::Constants::DEFAULT_FONT = T.let(T.unsafe(nil), String)
ANSI::Constants::DOUBLE_UNDERLINE = T.let(T.unsafe(nil), String)
ANSI::Constants::ENCIRCLE = T.let(T.unsafe(nil), String)
ANSI::Constants::ENCIRCLE_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::FAINT = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT0 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT1 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT2 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT3 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT4 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT5 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT6 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT7 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT8 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT9 = T.let(T.unsafe(nil), String)
ANSI::Constants::FONT_DEFAULT = T.let(T.unsafe(nil), String)
ANSI::Constants::FRAKTUR = T.let(T.unsafe(nil), String)
ANSI::Constants::FRAKTUR_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::FRAME = T.let(T.unsafe(nil), String)
ANSI::Constants::FRAME_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::GREEN = T.let(T.unsafe(nil), String)
ANSI::Constants::HIDE = T.let(T.unsafe(nil), String)
ANSI::Constants::INVERSE = T.let(T.unsafe(nil), String)
ANSI::Constants::INVERSE_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::INVERT = T.let(T.unsafe(nil), String)
ANSI::Constants::ITALIC = T.let(T.unsafe(nil), String)
ANSI::Constants::ITALIC_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::MAGENTA = T.let(T.unsafe(nil), String)
ANSI::Constants::NEGATIVE = T.let(T.unsafe(nil), String)
ANSI::Constants::ON_BLACK = T.let(T.unsafe(nil), String)
ANSI::Constants::ON_BLUE = T.let(T.unsafe(nil), String)
ANSI::Constants::ON_CYAN = T.let(T.unsafe(nil), String)
ANSI::Constants::ON_GREEN = T.let(T.unsafe(nil), String)
ANSI::Constants::ON_MAGENTA = T.let(T.unsafe(nil), String)
ANSI::Constants::ON_RED = T.let(T.unsafe(nil), String)
ANSI::Constants::ON_WHITE = T.let(T.unsafe(nil), String)
ANSI::Constants::ON_YELLOW = T.let(T.unsafe(nil), String)
ANSI::Constants::OVERLINE = T.let(T.unsafe(nil), String)
ANSI::Constants::OVERLINE_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::POSITIVE = T.let(T.unsafe(nil), String)
ANSI::Constants::RAPID = T.let(T.unsafe(nil), String)
ANSI::Constants::RAPID_BLINK = T.let(T.unsafe(nil), String)
ANSI::Constants::RED = T.let(T.unsafe(nil), String)
ANSI::Constants::RESET = T.let(T.unsafe(nil), String)
ANSI::Constants::RESTORE = T.let(T.unsafe(nil), String)
ANSI::Constants::REVEAL = T.let(T.unsafe(nil), String)
ANSI::Constants::REVERSE = T.let(T.unsafe(nil), String)
ANSI::Constants::SAVE = T.let(T.unsafe(nil), String)
ANSI::Constants::SHOW = T.let(T.unsafe(nil), String)
ANSI::Constants::SLOW_BLINK = T.let(T.unsafe(nil), String)
ANSI::Constants::STRIKE = T.let(T.unsafe(nil), String)
ANSI::Constants::SWAP = T.let(T.unsafe(nil), String)
ANSI::Constants::UNDERLINE = T.let(T.unsafe(nil), String)
ANSI::Constants::UNDERLINE_OFF = T.let(T.unsafe(nil), String)
ANSI::Constants::UNDERSCORE = T.let(T.unsafe(nil), String)
ANSI::Constants::WHITE = T.let(T.unsafe(nil), String)
ANSI::Constants::YELLOW = T.let(T.unsafe(nil), String)
ANSI::SPECIAL_CHART = T.let(T.unsafe(nil), Hash)

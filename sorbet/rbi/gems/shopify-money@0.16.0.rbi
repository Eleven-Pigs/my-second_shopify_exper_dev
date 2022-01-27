# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `shopify-money` gem.
# Please instead update this file by running `bin/tapioca gem shopify-money`.

ACTIVE_SUPPORT_DEFINED = T.let(T.unsafe(nil), String)

class AccountingMoneyParser < ::MoneyParser
  def parse(input, currency = T.unsafe(nil), **options); end
end

class Money
  include ::Comparable
  extend ::Forwardable

  def initialize(value, currency); end

  def *(numeric); end
  def +(other); end
  def -(other); end
  def -@; end
  def /(numeric); end
  def <=>(other); end
  def ==(other); end
  def abs; end
  def allocate(splits, strategy = T.unsafe(nil)); end
  def allocate_max_amounts(maximums); end
  def as_json(*args); end

  # Calculate the splits evenly without losing pennies.
  # Returns the number of high and low splits and the value of the high and low splits.
  # Where high represents the Money value with the extra penny
  # and low a Money without the extra penny.
  def calculate_splits(num); end

  # Clamps the value to be within the specified minimum and maximum. Returns
  # self if the value is within bounds, otherwise a new Money object with the
  # closest min or max value.
  def clamp(min, max); end

  def coerce(other); end

  # Returns the value of attribute currency.
  def currency; end

  def encode_with(coder); end

  # TODO: Remove once cross-currency mathematical operations are no longer allowed
  def eql?(other); end

  def floor; end
  def fraction(rate); end
  def hash(*args, **_arg1, &block); end
  def init_with(coder); end
  def inspect; end
  def negative?(*args, **_arg1, &block); end
  def no_currency?; end
  def nonzero?(*args, **_arg1, &block); end
  def positive?(*args, **_arg1, &block); end
  def round(ndigits = T.unsafe(nil)); end

  # Split money amongst parties evenly without losing pennies.
  def split(num); end

  def subunits(format: T.unsafe(nil)); end
  def to_d; end
  def to_f(*args, **_arg1, &block); end
  def to_i(*args, **_arg1, &block); end
  def to_json(options = T.unsafe(nil)); end
  def to_money(curr = T.unsafe(nil)); end
  def to_s(style = T.unsafe(nil)); end

  # Returns the value of attribute value.
  def value; end

  def zero?(*args, **_arg1, &block); end

  private

  def arithmetic(money_or_numeric); end
  def calculated_currency(other); end

  class << self
    def active_support_deprecator; end
    def current_currency; end
    def current_currency=(currency); end

    # Returns the value of attribute default_currency.
    def default_currency; end

    # Sets the attribute default_currency
    def default_currency=(_arg0); end

    def default_settings; end
    def deprecate(message); end
    def from_amount(value = T.unsafe(nil), currency = T.unsafe(nil)); end
    def from_subunits(subunits, currency_iso, format: T.unsafe(nil)); end
    def new(value = T.unsafe(nil), currency = T.unsafe(nil)); end
    def parse(*args, **kwargs); end

    # Returns the value of attribute parser.
    def parser; end

    # Sets the attribute parser
    def parser=(_arg0); end

    def rational(money1, money2); end

    # Set Money.default_currency inside the supplied block, resets it to
    # the previous value when done to prevent leaking state. Similar to
    # I18n.with_locale and ActiveSupport's Time.use_zone. This won't affect
    # instances being created with explicitly set currency.
    def with_currency(new_currency); end
  end
end

class Money::Allocator < ::SimpleDelegator
  def initialize(money); end

  def allocate(splits, strategy = T.unsafe(nil)); end

  # Allocates money between different parties up to the maximum amounts specified.
  # Left over pennies will be assigned round-robin up to the maximum specified.
  # Pennies are dropped when the maximums are attained.
  def allocate_max_amounts(maximums); end

  private

  def all_rational?(splits); end
  def allocation_index_for(strategy, length, idx); end
  def amounts_from_splits(allocations, splits, subunits_to_split = T.unsafe(nil)); end
  def extract_currency(money_array); end
end

class Money::Currency
  def initialize(currency_iso); end

  def ==(other); end
  def compatible?(other); end

  # Returns the value of attribute decimal_mark.
  def decimal_mark; end

  # Returns the value of attribute disambiguate_symbol.
  def disambiguate_symbol; end

  def eql?(other); end
  def hash; end

  # Returns the value of attribute iso_code.
  def iso_code; end

  # Returns the value of attribute iso_numeric.
  def iso_numeric; end

  # Returns the value of attribute minor_units.
  def minor_units; end

  # Returns the value of attribute name.
  def name; end

  # Returns the value of attribute smallest_denomination.
  def smallest_denomination; end

  # Returns the value of attribute subunit_symbol.
  def subunit_symbol; end

  # Returns the value of attribute subunit_to_unit.
  def subunit_to_unit; end

  # Returns the value of attribute symbol.
  def symbol; end

  # Returns the value of attribute iso_code.
  def to_s; end

  class << self
    def currencies; end
    def find(currency_iso); end
    def find!(currency_iso); end
    def new(currency_iso); end
  end
end

module Money::Currency::Loader
  class << self
    def load_currencies; end

    private

    def deep_deduplicate!(data); end
  end
end

class Money::Currency::UnknownCurrency < ::ArgumentError; end
class Money::Error < ::StandardError; end

module Money::Helpers
  private

  def value_to_currency(currency); end
  def value_to_decimal(num); end

  class << self
    def value_to_currency(currency); end
    def value_to_decimal(num); end
  end
end

Money::Helpers::DECIMAL_ZERO = T.let(T.unsafe(nil), BigDecimal)
Money::Helpers::MAX_DECIMAL = T.let(T.unsafe(nil), Integer)
Money::Helpers::STRIPE_SUBUNIT_OVERRIDE = T.let(T.unsafe(nil), Hash)
class Money::IncompatibleCurrencyError < ::Money::Error; end
Money::NULL_CURRENCY = T.let(T.unsafe(nil), Money::NullCurrency)

# A placeholder currency for instances where no actual currency is available,
# as defined by ISO4217. You should rarely, if ever, need to use this
# directly. It's here mostly for backwards compatibility and for that reason
# behaves like a dollar, which is how this gem worked before the introduction
# of currency.
#
# Here follows a list of preferred alternatives over using Money with
# NullCurrency:
#
# For comparisons where you don't know the currency beforehand, you can use
# Numeric predicate methods like #positive?/#negative?/#zero?/#nonzero?.
# Comparison operators with Numeric (==, !=, <=, =>, <, >) work as well.
#
# Money with NullCurrency has behaviour that may surprise you, such as
# database validations or GraphQL enum not allowing the string representation
# of NullCurrency. Prefer using Money.new(0, currency) where possible, as
# this sidesteps these issues and provides additional currency check
# safeties.
#
# Unlike other currencies, it is allowed to calculate a Money object with
# NullCurrency with another currency. The resulting Money object will have
# the other currency.
class Money::NullCurrency
  def initialize; end

  def ==(other); end
  def compatible?(other); end

  # Returns the value of attribute decimal_mark.
  def decimal_mark; end

  # Returns the value of attribute disambiguate_symbol.
  def disambiguate_symbol; end

  def eql?(other); end

  # Returns the value of attribute iso_code.
  def iso_code; end

  # Returns the value of attribute iso_numeric.
  def iso_numeric; end

  # Returns the value of attribute minor_units.
  def minor_units; end

  # Returns the value of attribute name.
  def name; end

  # Returns the value of attribute smallest_denomination.
  def smallest_denomination; end

  # Returns the value of attribute subunit_symbol.
  def subunit_symbol; end

  # Returns the value of attribute subunit_to_unit.
  def subunit_to_unit; end

  # Returns the value of attribute symbol.
  def symbol; end

  def to_s; end
end

class Money::ReverseOperationProxy
  include ::Comparable

  def initialize(value); end

  def *(other); end
  def +(other); end
  def -(other); end
  def <=>(other); end
end

module MoneyColumn; end

module MoneyColumn::ActiveRecordHooks
  mixes_in_class_methods ::MoneyColumn::ActiveRecordHooks::ClassMethods

  def reload(*_arg0); end

  private

  def clear_money_column_cache; end
  def init_internals; end
  def initialize_dup(*_arg0); end
  def read_money_attribute(column); end
  def write_money_attribute(column, money); end

  class << self
    def included(base); end
  end
end

module MoneyColumn::ActiveRecordHooks::ClassMethods
  def money_column(*columns, currency_column: T.unsafe(nil), currency: T.unsafe(nil), currency_read_only: T.unsafe(nil), coerce_null: T.unsafe(nil)); end

  # Returns the value of attribute money_column_options.
  def money_column_options; end

  private

  def clear_cache_on_currency_change(currency_column); end
  def inherited(subclass); end
  def normalize_money_column_options(options); end
end

class MoneyColumn::ActiveRecordType < ::ActiveModel::Type::Decimal
  def serialize(money); end
end

class MoneyColumn::Railtie < ::Rails::Railtie; end

# Parse an amount from a string
class MoneyParser
  def parse(input, currency = T.unsafe(nil), strict: T.unsafe(nil)); end

  private

  def extract_amount_from_string(input, currency, strict); end
  def last_digits_decimals?(digits, marks, currency); end
  def normalize_number(number, marks, currency); end

  class << self
    def parse(input, currency = T.unsafe(nil), **options); end
  end
end

# 1,1123,4567.89
MoneyParser::CHINESE_NUMERIC_REGEX = T.let(T.unsafe(nil), Regexp)

# 1.234.567,89
MoneyParser::COMMA_DECIMAL_REGEX = T.let(T.unsafe(nil), Regexp)

# 1,234,567.89
MoneyParser::DOT_DECIMAL_REGEX = T.let(T.unsafe(nil), Regexp)

MoneyParser::ESCAPED_MARKS = T.let(T.unsafe(nil), String)
MoneyParser::ESCAPED_NON_COMMA_MARKS = T.let(T.unsafe(nil), String)
MoneyParser::ESCAPED_NON_DOT_MARKS = T.let(T.unsafe(nil), String)
MoneyParser::ESCAPED_NON_SPACE_MARKS = T.let(T.unsafe(nil), String)

# 12,34,567.89
MoneyParser::INDIAN_NUMERIC_REGEX = T.let(T.unsafe(nil), Regexp)

MoneyParser::MARKS = T.let(T.unsafe(nil), Array)
class MoneyParser::MoneyFormatError < ::ArgumentError; end
MoneyParser::NUMERIC_REGEX = T.let(T.unsafe(nil), Regexp)

# Allows Writing of 100.to_money for +Numeric+ types
# 100.to_money => #<Money @cents=10000>
# 100.37.to_money => #<Money @cents=10037>
class Numeric
  include ::Comparable

  def to_money(currency = T.unsafe(nil)); end
end

Numeric::EXABYTE = T.let(T.unsafe(nil), Integer)
Numeric::GIGABYTE = T.let(T.unsafe(nil), Integer)
Numeric::KILOBYTE = T.let(T.unsafe(nil), Integer)
Numeric::MEGABYTE = T.let(T.unsafe(nil), Integer)
Numeric::PETABYTE = T.let(T.unsafe(nil), Integer)
Numeric::TERABYTE = T.let(T.unsafe(nil), Integer)
module RuboCop; end
module RuboCop::Cop; end
module RuboCop::Cop::Money; end

class RuboCop::Cop::Money::MissingCurrency < ::RuboCop::Cop::Cop
  def autocorrect(node); end
  def money_new(param0 = T.unsafe(nil)); end
  def on_csend(node); end
  def on_send(node); end
  def to_money_block?(param0 = T.unsafe(nil)); end
  def to_money_without_currency?(param0 = T.unsafe(nil)); end

  private

  def replacement_currency; end
end

class RuboCop::Cop::Money::ZeroMoney < ::RuboCop::Cop::Cop
  def autocorrect(node); end
  def money_zero(param0 = T.unsafe(nil)); end
  def on_send(node); end

  private

  def replacement_currency(currency_arg); end
end

# `Money.zero` and it's alias `empty`, with or without currency
# argument is removed in favour of the more explicit Money.new
# syntax. Supplying it with a real currency is preferred for
# additional currency safety checks.
#
# If no currency was supplied, it defaults to
# Money::NULL_CURRENCY which was the default setting of
# Money.default_currency and should effectively be the same. The cop
# can be configured with a ReplacementCurrency in case that is more
# appropriate for your application.
RuboCop::Cop::Money::ZeroMoney::MSG = T.let(T.unsafe(nil), String)

RuboCop::NodePattern = RuboCop::AST::NodePattern
RuboCop::ProcessedSource = RuboCop::AST::ProcessedSource
RuboCop::Token = RuboCop::AST::Token

# Allows Writing of '100'.to_money for +String+ types
# Excess characters will be discarded
# '100'.to_money => #<Money @cents=10000>
# '100.37'.to_money => #<Money @cents=10037>
class String
  include ::Comparable
  include ::JSON::Ext::Generator::GeneratorMethods::String
  extend ::JSON::Ext::Generator::GeneratorMethods::String::Extend

  def to_money(currency = T.unsafe(nil)); end
end

String::BLANK_RE = T.let(T.unsafe(nil), Regexp)
String::ENCODED_BLANKS = T.let(T.unsafe(nil), Concurrent::Map)

# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `xpath` gem.
# Please instead update this file by running `bin/tapioca gem xpath`.

# source://xpath//lib/xpath/dsl.rb#3
module XPath
  include ::XPath::DSL
  extend ::XPath::DSL

  class << self
    # @yield [_self]
    # @yieldparam _self [XPath] the object that the method was called on
    #
    # source://xpath//lib/xpath.rb#15
    def generate; end
  end
end

# source://xpath//lib/xpath/dsl.rb#4
module XPath::DSL
  # source://xpath//lib/xpath/dsl.rb#90
  def !(*args); end

  # source://xpath//lib/xpath/dsl.rb#122
  def !=(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def %(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def &(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def *(rhs); end

  # source://xpath//lib/xpath/dsl.rb#62
  def +(*expressions); end

  # source://xpath//lib/xpath/dsl.rb#122
  def /(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def <(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def <=(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def ==(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def >(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def >=(rhs); end

  # source://xpath//lib/xpath/dsl.rb#45
  def [](expression); end

  # source://xpath//lib/xpath/dsl.rb#136
  def ancestor(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#136
  def ancestor_or_self(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#122
  def and(rhs); end

  # source://xpath//lib/xpath/dsl.rb#21
  def anywhere(*expressions); end

  # source://xpath//lib/xpath/dsl.rb#25
  def attr(expression); end

  # source://xpath//lib/xpath/dsl.rb#136
  def attribute(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#17
  def axis(name, *element_names); end

  # source://xpath//lib/xpath/dsl.rb#58
  def binary_operator(name, rhs); end

  # source://xpath//lib/xpath/dsl.rb#90
  def boolean(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def ceiling(*args); end

  # source://xpath//lib/xpath/dsl.rb#13
  def child(*expressions); end

  # source://xpath//lib/xpath/dsl.rb#90
  def concat(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def contains(*args); end

  # source://xpath//lib/xpath/dsl.rb#147
  def contains_word(word); end

  # source://xpath//lib/xpath/dsl.rb#90
  def count(*args); end

  # source://xpath//lib/xpath/dsl.rb#33
  def css(selector); end

  # source://xpath//lib/xpath/dsl.rb#5
  def current; end

  # source://xpath//lib/xpath/dsl.rb#9
  def descendant(*expressions); end

  # source://xpath//lib/xpath/dsl.rb#136
  def descendant_or_self(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#122
  def divide(rhs); end

  # source://xpath//lib/xpath/dsl.rb#143
  def ends_with(suffix); end

  # source://xpath//lib/xpath/dsl.rb#122
  def equals(rhs); end

  # source://xpath//lib/xpath/dsl.rb#90
  def false(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def floor(*args); end

  # source://xpath//lib/xpath/dsl.rb#136
  def following(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#136
  def following_sibling(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#37
  def function(name, *arguments); end

  # source://xpath//lib/xpath/dsl.rb#122
  def gt(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def gte(rhs); end

  # source://xpath//lib/xpath/dsl.rb#90
  def id(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def inverse(*args); end

  # source://xpath//lib/xpath/dsl.rb#54
  def is(expression); end

  # source://xpath//lib/xpath/dsl.rb#90
  def lang(*args); end

  # source://xpath//lib/xpath/dsl.rb#67
  def last; end

  # source://xpath//lib/xpath/dsl.rb#90
  def local_name(*args); end

  # source://xpath//lib/xpath/dsl.rb#154
  def lowercase; end

  # source://xpath//lib/xpath/dsl.rb#122
  def lt(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def lte(rhs); end

  # source://xpath//lib/xpath/dsl.rb#41
  def method(name, *arguments); end

  # source://xpath//lib/xpath/dsl.rb#122
  def minus(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def mod(rhs); end

  # source://xpath//lib/xpath/dsl.rb#122
  def multiply(rhs); end

  # source://xpath//lib/xpath/dsl.rb#90
  def n(*args); end

  # source://xpath//lib/xpath/dsl.rb#136
  def namespace(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#90
  def namespace_uri(*args); end

  # source://xpath//lib/xpath/dsl.rb#166
  def next_sibling(*expressions); end

  # source://xpath//lib/xpath/dsl.rb#90
  def normalize(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def normalize_space(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def not(*args); end

  # source://xpath//lib/xpath/dsl.rb#122
  def not_equals(rhs); end

  # source://xpath//lib/xpath/dsl.rb#90
  def number(*args); end

  # source://xpath//lib/xpath/dsl.rb#162
  def one_of(*expressions); end

  # source://xpath//lib/xpath/dsl.rb#122
  def or(rhs); end

  # source://xpath//lib/xpath/dsl.rb#136
  def parent(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#122
  def plus(rhs); end

  # source://xpath//lib/xpath/dsl.rb#71
  def position; end

  # source://xpath//lib/xpath/dsl.rb#136
  def preceding(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#136
  def preceding_sibling(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#170
  def previous_sibling(*expressions); end

  # source://xpath//lib/xpath/dsl.rb#95
  def qname; end

  # source://xpath//lib/xpath/dsl.rb#90
  def round(*args); end

  # source://xpath//lib/xpath/dsl.rb#136
  def self(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#136
  def self_axis(*element_names); end

  # source://xpath//lib/xpath/dsl.rb#90
  def starts_with(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def string(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def string_length(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def substring(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def substring_after(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def substring_before(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def sum(*args); end

  # source://xpath//lib/xpath/dsl.rb#29
  def text; end

  # source://xpath//lib/xpath/dsl.rb#90
  def translate(*args); end

  # source://xpath//lib/xpath/dsl.rb#90
  def true(*args); end

  # source://xpath//lib/xpath/dsl.rb#62
  def union(*expressions); end

  # source://xpath//lib/xpath/dsl.rb#158
  def uppercase; end

  # source://xpath//lib/xpath/dsl.rb#45
  def where(expression); end

  # source://xpath//lib/xpath/dsl.rb#122
  def |(rhs); end

  # source://xpath//lib/xpath/dsl.rb#90
  def ~(*args); end
end

# source://xpath//lib/xpath/dsl.rb#128
XPath::DSL::AXES = T.let(T.unsafe(nil), Array)

# source://xpath//lib/xpath/dsl.rb#152
XPath::DSL::LOWERCASE_LETTERS = T.let(T.unsafe(nil), String)

# source://xpath//lib/xpath/dsl.rb#75
XPath::DSL::METHODS = T.let(T.unsafe(nil), Array)

# source://xpath//lib/xpath/dsl.rb#105
XPath::DSL::OPERATORS = T.let(T.unsafe(nil), Array)

# source://xpath//lib/xpath/dsl.rb#151
XPath::DSL::UPPERCASE_LETTERS = T.let(T.unsafe(nil), String)

# source://xpath//lib/xpath/expression.rb#4
class XPath::Expression
  include ::XPath::DSL

  # @return [Expression] a new instance of Expression
  #
  # source://xpath//lib/xpath/expression.rb#8
  def initialize(expression, *arguments); end

  # Returns the value of attribute arguments.
  #
  # source://xpath//lib/xpath/expression.rb#5
  def arguments; end

  # Sets the attribute arguments
  #
  # @param value the value to set the attribute arguments to.
  #
  # source://xpath//lib/xpath/expression.rb#5
  def arguments=(_arg0); end

  # source://xpath//lib/xpath/expression.rb#13
  def current; end

  # Returns the value of attribute expression.
  #
  # source://xpath//lib/xpath/expression.rb#5
  def expression; end

  # Sets the attribute expression
  #
  # @param value the value to set the attribute expression to.
  #
  # source://xpath//lib/xpath/expression.rb#5
  def expression=(_arg0); end

  # source://xpath//lib/xpath/expression.rb#17
  def to_s(type = T.unsafe(nil)); end

  # source://xpath//lib/xpath/expression.rb#17
  def to_xpath(type = T.unsafe(nil)); end
end

# source://xpath//lib/xpath/literal.rb#4
class XPath::Literal
  # @return [Literal] a new instance of Literal
  #
  # source://xpath//lib/xpath/literal.rb#6
  def initialize(value); end

  # Returns the value of attribute value.
  #
  # source://xpath//lib/xpath/literal.rb#5
  def value; end
end

# source://xpath//lib/xpath/renderer.rb#4
class XPath::Renderer
  # @return [Renderer] a new instance of Renderer
  #
  # source://xpath//lib/xpath/renderer.rb#9
  def initialize(type); end

  # source://xpath//lib/xpath/renderer.rb#55
  def anywhere(element_names); end

  # source://xpath//lib/xpath/renderer.rb#63
  def attribute(current, name); end

  # source://xpath//lib/xpath/renderer.rb#51
  def axis(current, name, element_names); end

  # source://xpath//lib/xpath/renderer.rb#71
  def binary_operator(name, left, right); end

  # source://xpath//lib/xpath/renderer.rb#47
  def child(current, element_names); end

  # source://xpath//lib/xpath/renderer.rb#18
  def convert_argument(argument); end

  # source://xpath//lib/xpath/renderer.rb#95
  def css(current, selector); end

  # source://xpath//lib/xpath/renderer.rb#43
  def descendant(current, element_names); end

  # source://xpath//lib/xpath/renderer.rb#106
  def function(name, *arguments); end

  # source://xpath//lib/xpath/renderer.rb#75
  def is(one, two); end

  # source://xpath//lib/xpath/renderer.rb#91
  def literal(node); end

  # source://xpath//lib/xpath/renderer.rb#13
  def render(node); end

  # source://xpath//lib/xpath/renderer.rb#28
  def string_literal(string); end

  # source://xpath//lib/xpath/renderer.rb#87
  def text(current); end

  # source://xpath//lib/xpath/renderer.rb#39
  def this_node; end

  # source://xpath//lib/xpath/renderer.rb#102
  def union(*expressions); end

  # source://xpath//lib/xpath/renderer.rb#83
  def variable(name); end

  # source://xpath//lib/xpath/renderer.rb#59
  def where(on, condition); end

  private

  # @return [Boolean]
  #
  # source://xpath//lib/xpath/renderer.rb#122
  def valid_xml_name?(name); end

  # source://xpath//lib/xpath/renderer.rb#112
  def with_element_conditions(expression, element_names); end

  class << self
    # source://xpath//lib/xpath/renderer.rb#5
    def render(node, type); end
  end
end

# source://xpath//lib/xpath/union.rb#4
class XPath::Union
  include ::Enumerable

  # @return [Union] a new instance of Union
  #
  # source://xpath//lib/xpath/union.rb#10
  def initialize(*expressions); end

  # Returns the value of attribute expressions.
  #
  # source://xpath//lib/xpath/union.rb#7
  def arguments; end

  # source://xpath//lib/xpath/union.rb#18
  def each(&block); end

  # source://xpath//lib/xpath/union.rb#14
  def expression; end

  # Returns the value of attribute expressions.
  #
  # source://xpath//lib/xpath/union.rb#7
  def expressions; end

  # source://xpath//lib/xpath/union.rb#22
  def method_missing(*args); end

  # source://xpath//lib/xpath/union.rb#26
  def to_s(type = T.unsafe(nil)); end

  # source://xpath//lib/xpath/union.rb#26
  def to_xpath(type = T.unsafe(nil)); end
end

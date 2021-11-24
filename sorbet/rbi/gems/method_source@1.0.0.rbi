# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `method_source` gem.
# Please instead update this file by running `bin/tapioca gem method_source`.

module MethodSource
  extend ::MethodSource::CodeHelpers

  class << self
    # Helper method responsible for opening source file and buffering up
    # the comments for a specified method. Defined here to avoid polluting
    # `Method` class.
    def comment_helper(source_location, name = T.unsafe(nil)); end

    def extract_code(source_location); end

    # Load a memoized copy of the lines in a file.
    def lines_for(file_name, name = T.unsafe(nil)); end

    # Helper method responsible for extracting method body.
    # Defined here to avoid polluting `Method` class.
    def source_helper(source_location, name = T.unsafe(nil)); end

    def valid_expression?(str); end
  end
end

module MethodSource::CodeHelpers
  # Retrieve the comment describing the expression on the given line of the given file.
  #
  # This is useful to get module or method documentation.
  def comment_describing(file, line_number); end

  # Determine if a string of code is a complete Ruby expression.
  def complete_expression?(str); end

  # Retrieve the first expression starting on the given line of the given file.
  #
  # This is useful to get module or method source code.
  #
  # line 1!
  def expression_at(file, line_number, options = T.unsafe(nil)); end

  private

  # Get the first expression from the input.
  def extract_first_expression(lines, consume = T.unsafe(nil), &block); end

  # Get the last comment from the input.
  def extract_last_comment(lines); end
end

# An exception matcher that matches only subsets of SyntaxErrors that can be
# fixed by adding more input to the buffer.
module MethodSource::CodeHelpers::IncompleteExpression
  class << self
    def ===(ex); end
    def rbx?; end
  end
end

MethodSource::CodeHelpers::IncompleteExpression::GENERIC_REGEXPS = T.let(T.unsafe(nil), Array)
MethodSource::CodeHelpers::IncompleteExpression::RBX_ONLY_REGEXPS = T.let(T.unsafe(nil), Array)

# This module is to be included by `Method` and `UnboundMethod` and
# provides the `#source` functionality
module MethodSource::MethodExtensions
  # Return the comments associated with the method as a string.
  def comment; end

  # Return the sourcecode for the method as a string
  def source; end

  class << self
    # We use the included hook to patch Method#source on rubinius.
    # We need to use the included hook as Rubinius defines a `source`
    # on Method so including a module will have no effect (as it's
    # higher up the MRO).
    def included(klass); end
  end
end

module MethodSource::ReeSourceLocation
  # Ruby enterprise edition provides all the information that's
  # needed, in a slightly different way.
  def source_location; end
end

module MethodSource::SourceLocation; end

module MethodSource::SourceLocation::MethodExtensions
  # Return the source location of a method for Ruby 1.8.
  def source_location; end

  private

  def trace_func(event, file, line, id, binding, classname); end
end

module MethodSource::SourceLocation::ProcExtensions
  # Return the source location for a Proc (in implementations
  # without Proc#source_location)
  def source_location; end
end

module MethodSource::SourceLocation::UnboundMethodExtensions
  # Return the source location of an instance method for Ruby 1.8.
  def source_location; end
end

# An Exception to mark errors that were raised trying to find the source from
# a given source_location.
class MethodSource::SourceNotFoundError < ::StandardError; end

MethodSource::VERSION = T.let(T.unsafe(nil), String)

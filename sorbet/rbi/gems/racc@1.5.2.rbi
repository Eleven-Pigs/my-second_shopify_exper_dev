# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `racc` gem.
# Please instead update this file by running `bin/tapioca gem racc`.

ParseError = Racc::ParseError
Racc::Copyright = T.let(T.unsafe(nil), String)

class Racc::Parser
  def _racc_do_parse_rb(arg, in_debug); end
  def _racc_do_reduce(arg, act); end

  # common
  def _racc_evalact(act, arg); end

  def _racc_init_sysvars; end
  def _racc_setup; end
  def _racc_yyparse_rb(recv, mid, arg, c_debug); end

  # The method to fetch next token.
  # If you use #do_parse method, you must implement #next_token.
  #
  # The format of return value is [TOKEN_SYMBOL, VALUE].
  # +token-symbol+ is represented by Ruby's symbol by default, e.g. :IDENT
  # for 'IDENT'.  ";" (String) for ';'.
  #
  # The final symbol (End of file) must be false.
  def next_token; end

  # This method is called when a parse error is found.
  #
  # ERROR_TOKEN_ID is an internal ID of token which caused error.
  # You can get string representation of this ID by calling
  # #token_to_str.
  #
  # ERROR_VALUE is a value of error token.
  #
  # value_stack is a stack of symbol values.
  # DO NOT MODIFY this object.
  #
  # This method raises ParseError by default.
  #
  # If this method returns, parsers enter "error recovering mode".
  def on_error(t, val, vstack); end

  def racc_accept; end
  def racc_e_pop(state, tstack, vstack); end
  def racc_next_state(curstate, state); end
  def racc_print_stacks(t, v); end
  def racc_print_states(s); end

  # For debugging output
  def racc_read_token(t, tok, val); end

  def racc_reduce(toks, sim, tstack, vstack); end
  def racc_shift(tok, tstack, vstack); end
  def racc_token2str(tok); end

  # Convert internal ID of token symbol to the string.
  def token_to_str(t); end

  # Exit parser.
  # Return value is Symbol_Value_Stack[0].
  def yyaccept; end

  # Leave error recovering mode.
  def yyerrok; end

  # Enter error recovering mode.
  # This method does not call #on_error.
  def yyerror; end

  class << self
    def racc_runtime_type; end
  end
end

Racc::Parser::Racc_Main_Parsing_Routine = T.let(T.unsafe(nil), Symbol)
Racc::Parser::Racc_Runtime_Core_Id_C = T.let(T.unsafe(nil), String)
Racc::Parser::Racc_Runtime_Core_Version = T.let(T.unsafe(nil), String)
Racc::Parser::Racc_Runtime_Core_Version_C = T.let(T.unsafe(nil), String)
Racc::Parser::Racc_Runtime_Core_Version_R = T.let(T.unsafe(nil), String)
Racc::Parser::Racc_Runtime_Type = T.let(T.unsafe(nil), String)
Racc::Parser::Racc_Runtime_Version = T.let(T.unsafe(nil), String)
Racc::Parser::Racc_YY_Parse_Method = T.let(T.unsafe(nil), Symbol)
Racc::VERSION = T.let(T.unsafe(nil), String)
Racc::Version = T.let(T.unsafe(nil), String)

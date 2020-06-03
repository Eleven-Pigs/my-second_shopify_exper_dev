# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   tapioca sync

# typed: true

module Byebug
  include(::Byebug::Helpers::ReflectionHelper)
  extend(::Byebug::Helpers::ReflectionHelper)
  extend(::Byebug)

  def displays; end
  def displays=(_); end
  def init_file; end
  def init_file=(_); end
  def mode; end
  def mode=(_); end
  def run_init_script; end

  private

  def add_catchpoint(_); end
  def breakpoints; end
  def catchpoints; end
  def contexts; end
  def current_context; end
  def debug_load(*_); end
  def lock; end
  def post_mortem=(_); end
  def post_mortem?; end
  def raised_exception; end
  def rc_dirs; end
  def run_rc_file(rc_file); end
  def start; end
  def started?; end
  def stop; end
  def stoppable?; end
  def thread_context(_); end
  def tracing=(_); end
  def tracing?; end
  def unlock; end
  def verbose=(_); end
  def verbose?; end

  def self.actual_control_port; end
  def self.actual_port; end
  def self.add_catchpoint(_); end
  def self.attach; end
  def self.breakpoints; end
  def self.catchpoints; end
  def self.contexts; end
  def self.current_context; end
  def self.debug_load(*_); end
  def self.handle_post_mortem; end
  def self.interrupt; end
  def self.load_settings; end
  def self.lock; end
  def self.parse_host_and_port(host_port_spec); end
  def self.post_mortem=(_); end
  def self.post_mortem?; end
  def self.raised_exception; end
  def self.spawn(host = _, port = _); end
  def self.start; end
  def self.start_client(host = _, port = _); end
  def self.start_control(host = _, port = _); end
  def self.start_server(host = _, port = _); end
  def self.started?; end
  def self.stop; end
  def self.stoppable?; end
  def self.thread_context(_); end
  def self.tracing=(_); end
  def self.tracing?; end
  def self.unlock; end
  def self.verbose=(_); end
  def self.verbose?; end
  def self.wait_connection; end
  def self.wait_connection=(_); end
end

class Byebug::DebugThread < ::Thread
  def self.inherited(_); end
end

Byebug::PORT = T.let(T.unsafe(nil), Integer)

class Byebug::PryProcessor < ::Byebug::CommandProcessor
  def at_breakpoint(breakpoint); end
  def at_end; end
  def at_line; end
  def at_return(_return_value); end
  def bold(*args, &block); end
  def output(*args, &block); end
  def perform(action, options = _); end
  def pry; end
  def pry=(_); end
  def run(&_block); end

  private

  def n_hits(breakpoint); end
  def perform_backtrace(_options); end
  def perform_down(options); end
  def perform_finish(*_); end
  def perform_frame(options); end
  def perform_next(options); end
  def perform_step(options); end
  def perform_up(options); end
  def resume_pry; end

  def self.start; end
end

class Byebug::ThreadsTable
end

class Pry
  extend(::Pry::Config::Convenience)

  def initialize(options = _); end

  def add_sticky_local(name, &block); end
  def backtrace; end
  def backtrace=(_); end
  def binding_stack; end
  def binding_stack=(_); end
  def color; end
  def color=(value); end
  def command_state; end
  def commands; end
  def commands=(value); end
  def complete(str); end
  def config; end
  def current_binding; end
  def current_context; end
  def custom_completions; end
  def custom_completions=(_); end
  def editor; end
  def editor=(value); end
  def eval(line, options = _); end
  def eval_string; end
  def eval_string=(_); end
  def evaluate_ruby(code); end
  def exception_handler; end
  def exception_handler=(value); end
  def exec_hook(name, *args, &block); end
  def exit_value; end
  def extra_sticky_locals; end
  def extra_sticky_locals=(value); end
  def hooks; end
  def hooks=(value); end
  def inject_local(name, value, b); end
  def inject_sticky_locals!; end
  def input; end
  def input=(value); end
  def input_array; end
  def input_ring; end
  def last_dir; end
  def last_dir=(_); end
  def last_exception; end
  def last_exception=(e); end
  def last_file; end
  def last_file=(_); end
  def last_result; end
  def last_result=(_); end
  def last_result_is_exception?; end
  def memory_size; end
  def memory_size=(size); end
  def output; end
  def output=(value); end
  def output_array; end
  def output_ring; end
  def pager; end
  def pager=(value); end
  def pop_prompt; end
  def print; end
  def print=(value); end
  def process_command(val); end
  def process_command_safely(val); end
  def prompt; end
  def prompt=(new_prompt); end
  def push_binding(object); end
  def push_initial_binding(target = _); end
  def push_prompt(new_prompt); end
  def quiet?; end
  def raise_up(*args); end
  def raise_up!(*args); end
  def raise_up_common(force, *args); end
  def repl(target = _); end
  def reset_eval_string; end
  def run_command(val); end
  def select_prompt; end
  def set_last_result(result, code = _); end
  def should_print?; end
  def show_result(result); end
  def sticky_locals; end
  def suppress_output; end
  def suppress_output=(_); end
  def update_input_history(code); end

  private

  def ensure_correct_encoding!(val); end
  def generate_prompt(prompt_proc, conf); end
  def handle_line(line, options); end
  def prompt_stack; end

  def self.Code(obj); end
  def self.Method(obj); end
  def self.WrappedModule(obj); end
  def self.auto_resize!; end
  def self.binding_for(target); end
  def self.cli; end
  def self.cli=(_); end
  def self.color; end
  def self.color=(value); end
  def self.commands; end
  def self.commands=(value); end
  def self.config; end
  def self.config=(_); end
  def self.configure; end
  def self.critical_section; end
  def self.current; end
  def self.current_line; end
  def self.current_line=(_); end
  def self.custom_completions; end
  def self.custom_completions=(_); end
  def self.default_editor_for_platform; end
  def self.editor; end
  def self.editor=(value); end
  def self.eval_path; end
  def self.eval_path=(_); end
  def self.exception_handler; end
  def self.exception_handler=(value); end
  def self.extra_sticky_locals; end
  def self.extra_sticky_locals=(value); end
  def self.final_session_setup; end
  def self.history; end
  def self.history=(_); end
  def self.hooks; end
  def self.hooks=(value); end
  def self.in_critical_section?; end
  def self.init; end
  def self.initial_session?; end
  def self.initial_session_setup; end
  def self.input; end
  def self.input=(value); end
  def self.last_internal_error; end
  def self.last_internal_error=(_); end
  def self.lazy(&block); end
  def self.line_buffer; end
  def self.line_buffer=(_); end
  def self.load_file_at_toplevel(file); end
  def self.load_file_through_repl(file_name); end
  def self.load_history; end
  def self.load_plugins(*args, &block); end
  def self.load_rc_files; end
  def self.load_requires; end
  def self.load_traps; end
  def self.load_win32console; end
  def self.locate_plugins(*args, &block); end
  def self.main; end
  def self.memory_size; end
  def self.memory_size=(value); end
  def self.output; end
  def self.output=(value); end
  def self.pager; end
  def self.pager=(value); end
  def self.plugins(*args, &block); end
  def self.print; end
  def self.print=(value); end
  def self.prompt; end
  def self.prompt=(value); end
  def self.quiet; end
  def self.quiet=(_); end
  def self.rc_files_to_load; end
  def self.real_path_to(file); end
  def self.reset_defaults; end
  def self.run_command(command_string, options = _); end
  def self.start(target = _, options = _); end
  def self.start_with_pry_byebug(target = _, options = _); end
  def self.start_without_pry_byebug(target = _, options = _); end
  def self.toplevel_binding; end
  def self.toplevel_binding=(binding); end
  def self.view_clip(obj, options = _); end
end

Pry::BINDING_METHOD_IMPL = T.let(T.unsafe(nil), Array)

module Pry::Byebug
end

module Pry::Byebug::Breakpoints
  extend(::Enumerable)
  extend(::Pry::Byebug::Breakpoints)

  def add_file(file, line, expression = _); end
  def add_method(method, expression = _); end
  def breakpoints; end
  def change(id, expression = _); end
  def delete(id); end
  def delete_all; end
  def disable(id); end
  def disable_all; end
  def each(&block); end
  def enable(id); end
  def find_by_id(id); end
  def last; end
  def size; end
  def to_a; end

  private

  def change_status(id, enabled = _); end
  def validate_expression(exp); end
end

class Pry::Byebug::Breakpoints::FileBreakpoint < ::SimpleDelegator
  def source_code; end
  def to_s; end
end

class Pry::Byebug::Breakpoints::MethodBreakpoint < ::SimpleDelegator
  def initialize(byebug_bp, method); end

  def source_code; end
  def to_s; end
end

Pry::CLIPPED_PRINT = T.let(T.unsafe(nil), Proc)

Pry::Commands = T.let(T.unsafe(nil), Pry::CommandSet)

Pry::DEFAULT_CONTROL_D_HANDLER = T.let(T.unsafe(nil), Proc)

Pry::DEFAULT_EXCEPTION_HANDLER = T.let(T.unsafe(nil), Proc)

Pry::DEFAULT_EXCEPTION_WHITELIST = T.let(T.unsafe(nil), Array)

Pry::DEFAULT_HOOKS = T.let(T.unsafe(nil), Pry::Hooks)

Pry::DEFAULT_PRINT = T.let(T.unsafe(nil), Proc)

Pry::DEFAULT_SYSTEM = T.let(T.unsafe(nil), Proc)

Pry::EMPTY_COMPLETIONS = T.let(T.unsafe(nil), Array)

Pry::HOME_RC_FILE = T.let(T.unsafe(nil), String)

Pry::LOCAL_RC_FILE = T.let(T.unsafe(nil), String)

Pry::SIMPLE_PRINT = T.let(T.unsafe(nil), Proc)

Pry::VERSION = T.let(T.unsafe(nil), String)

module PryByebug
  def current_remote_server; end
  def current_remote_server=(_); end

  private

  def check_file_context(target, msg = _); end
  def file_context?(target); end

  def self.check_file_context(target, msg = _); end
  def self.file_context?(target); end
end

class PryByebug::BacktraceCommand < ::Pry::ClassCommand
  include(::PryByebug::Helpers::Navigation)

  def process; end
end

class PryByebug::BreakCommand < ::Pry::ClassCommand
  include(::PryByebug::Helpers::Breakpoints)
  include(::PryByebug::Helpers::Multiline)

  def options(opt); end
  def process; end

  private

  def add_breakpoint(place, condition); end
  def new_breakpoint; end
  def option_to_method(option); end
  def print_all; end
  def process_condition; end
  def process_delete; end
  def process_delete_all; end
  def process_disable; end
  def process_disable_all; end
  def process_enable; end
  def process_show; end
end

class PryByebug::ContinueCommand < ::Pry::ClassCommand
  include(::PryByebug::Helpers::Navigation)
  include(::PryByebug::Helpers::Breakpoints)

  def process; end
end

class PryByebug::DownCommand < ::Pry::ClassCommand
  include(::PryByebug::Helpers::Navigation)

  def process; end
end

class PryByebug::ExitAllCommand < ::Pry::Command::ExitAll
  def process; end
end

class PryByebug::FinishCommand < ::Pry::ClassCommand
  include(::PryByebug::Helpers::Navigation)

  def process; end
end

class PryByebug::FrameCommand < ::Pry::ClassCommand
  include(::PryByebug::Helpers::Navigation)

  def process; end
end

module PryByebug::Helpers
end

module PryByebug::Helpers::Breakpoints
  def bold_puts(msg); end
  def breakpoints; end
  def current_file; end
  def max_width; end
  def print_breakpoints_header; end
  def print_full_breakpoint(breakpoint); end
  def print_short_breakpoint(breakpoint); end
end

module PryByebug::Helpers::Multiline
  def check_multiline_context; end
end

module PryByebug::Helpers::Navigation
  def breakout_navigation(action, options = _); end
end

class PryByebug::NextCommand < ::Pry::ClassCommand
  include(::PryByebug::Helpers::Navigation)
  include(::PryByebug::Helpers::Multiline)

  def process; end
end

class PryByebug::StepCommand < ::Pry::ClassCommand
  include(::PryByebug::Helpers::Navigation)

  def process; end
end

class PryByebug::UpCommand < ::Pry::ClassCommand
  include(::PryByebug::Helpers::Navigation)

  def process; end
end

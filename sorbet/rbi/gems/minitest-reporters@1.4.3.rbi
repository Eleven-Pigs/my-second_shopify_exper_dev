# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `minitest-reporters` gem.
# Please instead update this file by running `bin/tapioca gem minitest-reporters`.

module Minitest
  class << self
    def __run(reporter, options); end
    def after_run(&block); end
    def autorun; end
    def backtrace_filter; end
    def backtrace_filter=(_arg0); end
    def clock_time; end
    def extensions; end
    def extensions=(_arg0); end
    def filter_backtrace(bt); end
    def info_signal; end
    def info_signal=(_arg0); end
    def init_plugins(options); end
    def load_plugins; end
    def parallel_executor; end
    def parallel_executor=(_arg0); end
    def process_args(args = T.unsafe(nil)); end
    def reporter; end
    def reporter=(_arg0); end
    def run(args = T.unsafe(nil)); end
    def run_one_method(klass, method_name); end
  end
end

Minitest::ENCS = T.let(T.unsafe(nil), TrueClass)

class Minitest::Expectation < ::Struct
  def ctx; end
  def ctx=(_); end
  def must_be(*args); end
  def must_be_close_to(*args); end
  def must_be_empty(*args); end
  def must_be_instance_of(*args); end
  def must_be_kind_of(*args); end
  def must_be_nil(*args); end
  def must_be_same_as(*args); end
  def must_be_silent(*args); end
  def must_be_within_delta(*args); end
  def must_be_within_epsilon(*args); end
  def must_equal(*args); end
  def must_include(*args); end
  def must_match(*args); end
  def must_output(*args); end
  def must_raise(*args); end
  def must_respond_to(*args); end
  def must_throw(*args); end
  def path_must_exist(*args); end
  def path_wont_exist(*args); end
  def target; end
  def target=(_); end
  def wont_be(*args); end
  def wont_be_close_to(*args); end
  def wont_be_empty(*args); end
  def wont_be_instance_of(*args); end
  def wont_be_kind_of(*args); end
  def wont_be_nil(*args); end
  def wont_be_same_as(*args); end
  def wont_be_within_delta(*args); end
  def wont_be_within_epsilon(*args); end
  def wont_equal(*args); end
  def wont_include(*args); end
  def wont_match(*args); end
  def wont_respond_to(*args); end

  class << self
    def [](*_arg0); end
    def inspect; end
    def members; end
    def new(*_arg0); end
  end
end

# Filters backtraces of exceptions that may arise when running tests.
class Minitest::ExtensibleBacktraceFilter
  # Creates a new backtrace filter.
  def initialize; end

  # Adds a filter.
  def add_filter(regex); end

  # Filters a backtrace.
  #
  # This will add new lines to the new backtrace until a filtered line is
  # encountered. If there were lines added to the new backtrace, it returns
  # those lines. However, if the first line in the backtrace was filtered,
  # resulting in an empty backtrace, it returns all lines that would have
  # been unfiltered. If that in turn does not contain any lines, it returns
  # the original backtrace.
  def filter(backtrace); end

  # Determines if the string would be filtered.
  def filters?(str); end

  class << self
    # Returns the default filter.
    #
    # The default filter will filter out all Minitest and minitest-reporters
    # lines.
    def default_filter; end
  end
end

module Minitest::RelativePosition
  private

  def pad(str, size = T.unsafe(nil)); end
  def pad_mark(str); end
  def pad_test(str); end
  def print_with_info_padding(line); end
end

Minitest::RelativePosition::INFO_PADDING = T.let(T.unsafe(nil), Integer)
Minitest::RelativePosition::MARK_SIZE = T.let(T.unsafe(nil), Integer)
Minitest::RelativePosition::TEST_PADDING = T.let(T.unsafe(nil), Integer)
Minitest::RelativePosition::TEST_SIZE = T.let(T.unsafe(nil), Integer)

module Minitest::Reporters
  class << self
    def choose_reporters(console_reporters, env); end
    def clock_time; end
    def minitest_version; end

    # Returns the value of attribute reporters.
    def reporters; end

    # Sets the attribute reporters
    def reporters=(_arg0); end

    def use!(console_reporters = T.unsafe(nil), env = T.unsafe(nil), backtrace_filter = T.unsafe(nil)); end
    def use_around_test_hooks!; end
    def use_old_activesupport_fix!; end
    def use_runner!(console_reporters, env); end
  end
end

module Minitest::Reporters::ANSI; end

module Minitest::Reporters::ANSI::Code
  include ::ANSI::Constants
  include ::ANSI::Code
  extend ::ANSI::Constants
  extend ::ANSI::Code

  class << self
    def color?; end
  end
end

class Minitest::Reporters::BaseReporter < ::Minitest::StatisticsReporter
  def initialize(options = T.unsafe(nil)); end

  def add_defaults(defaults); end

  # called by our own after hooks
  def after_test(_test); end

  # called by our own before hooks
  def before_test(test); end

  def record(test); end
  def report; end

  # Returns the value of attribute tests.
  def tests; end

  # Sets the attribute tests
  def tests=(_arg0); end

  protected

  def after_suite(test); end
  def before_suite(test); end
  def filter_backtrace(backtrace); end
  def print(*args); end
  def print_colored_status(test); end
  def print_info(e, name = T.unsafe(nil)); end
  def puts(*args); end
  def result(test); end
  def test_class(result); end
  def total_count; end
  def total_time; end
end

class Minitest::Reporters::DefaultReporter < ::Minitest::Reporters::BaseReporter
  include ::ANSI::Constants
  include ::ANSI::Code
  include ::Minitest::Reporters::ANSI::Code
  include ::Minitest::RelativePosition

  def initialize(options = T.unsafe(nil)); end

  def after_suite(suite); end
  def before_suite(suite); end
  def before_test(test); end
  def on_record(test); end
  def on_report; end
  def on_start; end
  def print_failure(test); end
  def record(test); end
  def record_failure(record); end
  def record_pass(record); end
  def record_skip(record); end
  def report; end
  def start; end
  def to_s; end

  private

  def color?; end
  def colored_for(result, string); end
  def get_source_location(result); end
  def green(string); end
  def location(exception); end
  def message_for(test); end
  def red(string); end
  def relative_path(path); end
  def result_line; end
  def suite_duration(suite); end
  def suite_result; end
  def yellow(string); end
end

# A reporter for generating HTML test reports
# This is recommended to be used with a CI server, where the report is kept as an artifact and is accessible via
# a shared link
#
# The reporter sorts the results alphabetically and then by results
# so that failing and skipped tests are at the top.
#
# When using Minitest Specs, the number prefix is dropped from the name of the test so that it reads well
#
# On each test run all files in the reports directory are deleted, this prevents a build up of old reports
#
# The report is generated using ERB. A custom ERB template can be provided but it is not required
# The default ERB template uses JQuery and Bootstrap, both of these are included by referencing the CDN sites
class Minitest::Reporters::HtmlReporter < ::Minitest::Reporters::BaseReporter
  # The constructor takes a hash, and uses the following keys:
  # :title - the title that will be used in the report, defaults to 'Test Results'
  # :reports_dir - the directory the reports should be written to, defaults to 'test/html_reports'
  # :erb_template - the path to a custom ERB template, defaults to the supplied ERB template
  # :mode - Useful for debugging, :terse suppresses errors and is the default, :verbose lets errors bubble up
  # :output_filename - the report's filename, defaults to 'index.html'
  def initialize(args = T.unsafe(nil)); end

  # Trims off the number prefix on test names when using Minitest Specs
  def friendly_name(test); end

  # The number of tests that passed
  def passes; end

  # The percentage of tests that failed
  def percent_errors_failures; end

  # The percentage of tests that passed, calculated in a way that avoids rounding errors
  def percent_passes; end

  # The percentage of tests that were skipped
  def percent_skipps; end

  # Called by the framework to generate the report
  def report; end

  def start; end

  # The title of the report
  def title; end

  private

  # Test suites are first ordered by evaluating the results of the tests, then by test suite name
  # Test suites which have failing tests are given highest order
  # Tests suites which have skipped tests are given second highest priority
  def compare_suites(suite_a, suite_b); end

  def compare_suites_by_name(suite_a, suite_b); end

  # Tests are first ordered by evaluating the results of the tests, then by tests names
  # Tess which fail are given highest order
  # Tests which are skipped are given second highest priority
  def compare_tests(test_a, test_b); end

  def compare_tests_by_name(test_a, test_b); end
  def html_file; end

  # taken from the JUnit reporter
  def location(exception); end

  # based on message_for(test) from the JUnit reporter
  def message_for(test); end

  # based on analyze_suite from the JUnit reporter
  def summarize_suite(suite, tests); end

  def test_fail_or_error?(test); end
  def total_time_to_hms; end
end

# A reporter for writing JUnit test reports
# Intended for easy integration with CI servers - tested on JetBrains TeamCity
#
# Inspired by ci_reporter (see https://github.com/nicksieger/ci_reporter)
# Also inspired by Marc Seeger's attempt at producing a JUnitReporter (see https://github.com/rb2k/minitest-reporters/commit/e13d95b5f884453a9c77f62bc5cba3fa1df30ef5)
# Also inspired by minitest-ci (see https://github.com/bhenderson/minitest-ci)
class Minitest::Reporters::JUnitReporter < ::Minitest::Reporters::BaseReporter
  def initialize(reports_dir = T.unsafe(nil), empty = T.unsafe(nil), options = T.unsafe(nil)); end

  def get_relative_path(result); end
  def report; end

  # Returns the value of attribute reports_path.
  def reports_path; end

  private

  def analyze_suite(tests); end
  def filename_for(suite); end
  def get_source_location(result); end
  def location(exception); end
  def message_for(test); end
  def parse_xml_for(xml, suite, tests); end
  def xml_message_for(test); end
end

Minitest::Reporters::JUnitReporter::DEFAULT_REPORTS_DIR = T.let(T.unsafe(nil), String)

# This reporter creates a report providing the average (mean), minimum and
# maximum times for a test to run. Running this for all your tests will
# allow you to:
#
# 1) Identify the slowest running tests over time as potential candidates
# for improvements or refactoring.
# 2) Identify (and fix) regressions in test run speed caused by changes to
# your tests or algorithms in your code.
# 3) Provide an abundance of statistics to enjoy.
#
# This is achieved by creating a (configurable) 'previous runs' statistics
# file which is parsed at the end of each run to provide a new
# (configurable) report. These statistics can be reset at any time by using
# a simple rake task:
#
# rake reset_statistics
class Minitest::Reporters::MeanTimeReporter < ::Minitest::Reporters::DefaultReporter
  def initialize(options = T.unsafe(nil)); end

  # Copies the suite times from the
  # {Minitest::Reporters::DefaultReporter#after_suite} method, making them
  # available to this class.
  def after_suite(suite); end

  def on_record(test); end
  def on_report; end
  def on_start; end

  # Runs the {Minitest::Reporters::DefaultReporter#report} method and then
  # enhances it by storing the results to the 'previous_runs_filename' and
  # outputs the parsed results to both the 'report_filename' and the
  # terminal.
  def report; end

  # Resets the 'previous runs' file, essentially removing all previous
  # statistics gathered.
  def reset_statistics!; end

  protected

  # Returns the value of attribute all_suite_times.
  def all_suite_times; end

  # Sets the attribute all_suite_times
  def all_suite_times=(_arg0); end

  private

  def asc?; end
  def avg_label; end
  def column_sorted_body; end

  # Creates a new report file in the 'report_filename'. This file contains
  # a line for each test of the following example format: (this is a single
  # line despite explicit wrapping)
  #
  # Avg: 0.0555555 Min: 0.0498765 Max: 0.0612345 Last: 0.0499421
  # Description: The test name
  #
  # Note however the timings are to 9 decimal places, and padded to 12
  # characters and each label is coloured, Avg (yellow), Min (green),
  # Max (red), Last (multi), and Description (blue). It looks pretty!
  #
  # The 'Last' label is special in that it will be colour coded depending
  # on whether the last run was faster (bright green) or slower (bright red)
  # or inconclusive (purple). This helps to identify changes on a per run
  # basis.
  def create_new_report!; end

  # Creates a new 'previous runs' file, or updates the existing one with
  # the latest timings.
  def create_or_update_previous_runs!; end

  def current_run; end
  def defaults; end
  def des_label; end
  def desc?; end
  def max_label; end
  def min_label; end
  def options; end
  def order; end
  def order_sorted_body; end
  def previous_run; end
  def previous_runs_filename; end

  # Returns a boolean indicating whether a previous runs file exists.
  def previously_ran?; end

  def rate(run, min, max); end

  # The report itself. Displays statistics about all runs, ideal for use
  # with the Unix 'head' command. Listed in slowest average descending
  # order.
  def report_body; end

  def report_filename; end

  # Added to the top of the report file and to the screen output.
  def report_title; end

  def run_label(rating); end

  # A barbaric way to find out how many runs are in the previous runs file;
  # this method takes the first test listed, and counts its samples
  # trusting (naively) all runs to be the same number of samples. This will
  # produce incorrect averages when new tests are added, so it is advised
  # to restart the statistics by removing the 'previous runs' file. A rake
  # task is provided to make this more convenient.
  #
  # rake reset_statistics
  def samples; end

  def show_count; end
  def sort_column; end

  # Writes a number of tests (configured via the 'show_count' option) to the
  # screen after creating the report. See '#create_new_report!' for example
  # output information.
  def write_to_screen!; end

  class << self
    # Reset the statistics file for this reporter. Called via a rake task:
    #
    # rake reset_statistics
    def reset_statistics!; end
  end
end

class Minitest::Reporters::MeanTimeReporter::InvalidOrder < ::StandardError; end
class Minitest::Reporters::MeanTimeReporter::InvalidSortColumn < ::StandardError; end

class Minitest::Reporters::ProgressReporter < ::Minitest::Reporters::BaseReporter
  include ::Minitest::RelativePosition
  include ::ANSI::Constants
  include ::ANSI::Code
  include ::Minitest::Reporters::ANSI::Code

  def initialize(options = T.unsafe(nil)); end

  def before_test(test); end
  def record(test); end
  def report; end
  def start; end

  private

  def color; end
  def color=(color); end
  def print_test_with_time(test); end
  def show; end
end

Minitest::Reporters::ProgressReporter::PROGRESS_MARK = T.let(T.unsafe(nil), String)

# Simple reporter designed for RubyMate.
class Minitest::Reporters::RubyMateReporter < ::Minitest::Reporters::BaseReporter
  include ::Minitest::RelativePosition

  def record(test); end
  def report; end
  def start; end

  private

  def print_test_with_time(test); end
end

Minitest::Reporters::RubyMateReporter::INFO_PADDING = T.let(T.unsafe(nil), Integer)

class Minitest::Reporters::RubyMineReporter < ::Minitest::Reporters::DefaultReporter
  def initialize(options = T.unsafe(nil)); end
end

class Minitest::Reporters::SpecReporter < ::Minitest::Reporters::BaseReporter
  include ::ANSI::Constants
  include ::ANSI::Code
  include ::Minitest::Reporters::ANSI::Code
  include ::Minitest::RelativePosition

  def record(test); end
  def report; end
  def start; end

  protected

  def after_suite(_suite); end
  def before_suite(suite); end
  def record_print_failures_if_any(test); end
  def record_print_status(test); end
end

class Minitest::Reporters::Suite
  def initialize(name); end

  def ==(other); end
  def eql?(other); end
  def hash; end

  # Returns the value of attribute name.
  def name; end

  def to_s; end
end

Minitest::Reporters::VERSION = T.let(T.unsafe(nil), String)
Minitest::VERSION = T.let(T.unsafe(nil), String)

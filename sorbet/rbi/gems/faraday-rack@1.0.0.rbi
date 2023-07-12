# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `faraday-rack` gem.
# Please instead update this file by running `bin/tapioca gem faraday-rack`.

# source://faraday-rack//lib/faraday/adapter/rack.rb#3
module Faraday
  class << self
    # source://faraday/1.10.3/lib/faraday.rb#81
    def default_adapter; end

    # source://faraday/1.10.3/lib/faraday.rb#137
    def default_adapter=(adapter); end

    # source://faraday/1.10.3/lib/faraday.rb#155
    def default_connection; end

    # source://faraday/1.10.3/lib/faraday.rb#84
    def default_connection=(_arg0); end

    # source://faraday/1.10.3/lib/faraday.rb#162
    def default_connection_options; end

    # source://faraday/1.10.3/lib/faraday.rb#169
    def default_connection_options=(options); end

    # source://faraday/1.10.3/lib/faraday.rb#89
    def ignore_env_proxy; end

    # source://faraday/1.10.3/lib/faraday.rb#89
    def ignore_env_proxy=(_arg0); end

    # source://faraday/1.10.3/lib/faraday.rb#72
    def lib_path; end

    # source://faraday/1.10.3/lib/faraday.rb#72
    def lib_path=(_arg0); end

    # source://faraday/1.10.3/lib/faraday.rb#118
    def new(url = T.unsafe(nil), options = T.unsafe(nil), &block); end

    # source://faraday/1.10.3/lib/faraday.rb#128
    def require_lib(*libs); end

    # source://faraday/1.10.3/lib/faraday.rb#128
    def require_libs(*libs); end

    # source://faraday/1.10.3/lib/faraday.rb#142
    def respond_to_missing?(symbol, include_private = T.unsafe(nil)); end

    # source://faraday/1.10.3/lib/faraday.rb#68
    def root_path; end

    # source://faraday/1.10.3/lib/faraday.rb#68
    def root_path=(_arg0); end

    private

    # source://faraday/1.10.3/lib/faraday.rb#178
    def method_missing(name, *args, &block); end
  end
end

# source://faraday-rack//lib/faraday/adapter/rack.rb#4
class Faraday::Adapter
  # source://faraday/1.10.3/lib/faraday/adapter.rb#33
  def initialize(_app = T.unsafe(nil), opts = T.unsafe(nil), &block); end

  # source://faraday/1.10.3/lib/faraday/adapter.rb#60
  def call(env); end

  # source://faraday/1.10.3/lib/faraday/adapter.rb#55
  def close; end

  # source://faraday/1.10.3/lib/faraday/adapter.rb#46
  def connection(env); end

  private

  # source://faraday/1.10.3/lib/faraday/adapter.rb#91
  def request_timeout(type, options); end

  # source://faraday/1.10.3/lib/faraday/adapter.rb#67
  def save_response(env, status, body, headers = T.unsafe(nil), reason_phrase = T.unsafe(nil)); end
end

# Sends requests to a Rack app.
#
# @example
#
#   class MyRackApp
#   def call(env)
#   [200, {'Content-Type' => 'text/html'}, ["hello world"]]
#   end
#   end
#
#   Faraday.new do |conn|
#   conn.adapter :rack, MyRackApp.new
#   end
#
# source://faraday-rack//lib/faraday/adapter/rack.rb#18
class Faraday::Adapter::Rack < ::Faraday::Adapter
  # @return [Rack] a new instance of Rack
  #
  # source://faraday-rack//lib/faraday/adapter/rack.rb#24
  def initialize(faraday_app, rack_app); end

  # source://faraday-rack//lib/faraday/adapter/rack.rb#30
  def call(env); end

  private

  # source://faraday-rack//lib/faraday/adapter/rack.rb#66
  def build_rack_env(env); end

  # source://faraday-rack//lib/faraday/adapter/rack.rb#62
  def execute_request(env, rack_env); end
end

# not prefixed with "HTTP_"
#
# source://faraday-rack//lib/faraday/adapter/rack.rb#22
Faraday::Adapter::Rack::SPECIAL_HEADERS = T.let(T.unsafe(nil), Array)

# Main Faraday::Rack module
#
# source://faraday-rack//lib/faraday/rack/version.rb#4
module Faraday::Rack; end

# source://faraday-rack//lib/faraday/rack/version.rb#5
Faraday::Rack::VERSION = T.let(T.unsafe(nil), String)

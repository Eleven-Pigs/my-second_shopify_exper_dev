# typed: strict
# frozen_string_literal: true

require "json"
require "tempfile"

module Tapioca
  module Compilers
    module SymbolTable
      module SymbolLoader
        class << self
          extend T::Sig
          include SorbetHelper
          include Reflection

          sig { params(paths: T::Array[Pathname]).returns(T::Set[String]) }
          def list_from_paths(paths)
            output = T.cast(Tempfile.create("sorbet") do |file|
              file.write(Array(paths).join("\n"))
              file.flush

              symbol_table_json_from("@#{file.path.shellescape}")
            end, T.nilable(String))

            return Set.new if output.nil? || output.empty?

            SymbolTableParser.parse_json(output)
          end

          sig { returns(T::Set[String]) }
          def payload_symbols
            unless @payload_symbols
              output = symbol_table_json_from("-e ''", table_type: "symbol-table-full-json")
              @payload_symbols = T.let(SymbolTableParser.parse_json(output), T.nilable(T::Set[String]))
            end

            T.must(@payload_symbols)
          end

          sig { returns(T::Set[String]) }
          def engine_symbols
            unless @engine_symbols
              @engine_symbols = T.let(load_engine_symbols, T.nilable(T::Set[String]))
            end
            T.must(@engine_symbols)
          end

          private

          sig { params(input: String, table_type: String).returns(String) }
          def symbol_table_json_from(input, table_type: "symbol-table-json")
            sorbet("--no-config", "--print=#{table_type}", input)
          end

          sig { returns(T::Set[String]) }
          def load_engine_symbols
            return Set.new unless Object.const_defined?("Rails::Engine")

            engine = descendants_of(Object.const_get("Rails::Engine"))
              .reject(&:abstract_railtie?)
              .find do |klass|
                name = name_of(klass)
                !name.nil? && core_symbols.include?(name)
              end

            return Set.new unless engine

            paths = engine.config.eager_load_paths.flat_map do |load_path|
              Pathname.glob("#{load_path}/**/*.rb")
            end

            list_from_paths(paths)
          rescue
            Set.new
          end
        end
      end
    end
  end
end

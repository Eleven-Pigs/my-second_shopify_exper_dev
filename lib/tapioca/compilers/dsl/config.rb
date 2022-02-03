# typed: strict
# frozen_string_literal: true

begin
  require "config"
rescue LoadError
  return
end

module Tapioca
  module Compilers
    module Dsl
      # `Tapioca::Compilers::Dsl::Config` generates RBI files for classes generated by the
      # [`config`](https://github.com/rubyconfig/config) gem.
      #
      # The gem creates a `Config::Options` instance based on the settings files and/or
      # env variables. It then assigns this instance to a constant with a configurable name,
      # by default `Settings`. Application code uses methods on this constant to read off
      # config values.
      #
      # For a setting file like the following:
      # ```yaml
      # ---
      # github:
      #   token: 12345
      #   client_id: 54321
      #   client_secret: super_secret
      # ```
      # and a `Config` setup like:
      # ```ruby
      # Config.setup do |config|
      #   config.const_name = "AppSettings"
      # end
      # ```
      # this compiler will produce the following RBI file:
      # ```rbi
      # AppSettings = T.let(T.unsafe(nil), AppSettingsConfigOptions)
      #
      # class AppSettingsConfigOptions < ::Config::Options
      #   sig { returns(T.untyped) }
      #   def github; end
      #
      #   sig { params(value: T.untyped).returns(T.untyped) }
      #   def github=(value); end
      # end
      # ```
      class Config < Base
        extend T::Sig

        CONFIG_OPTIONS_SUFFIX = "ConfigOptions"

        sig { override.params(root: RBI::Tree, constant: Module).void }
        def decorate(root, constant)
          # The constant we are given is the specialized config options type
          option_class_name = constant.name
          return unless option_class_name

          # Grab the config constant name and the actual config constant
          config_constant_name = option_class_name
            .gsub(/#{CONFIG_OPTIONS_SUFFIX}$/, "")
          config_constant = Object.const_get(config_constant_name)

          # Look up method names from the keys of the config constant
          method_names = config_constant.keys

          return if method_names.empty?

          root.create_constant(config_constant_name, value: "T.let(T.unsafe(nil), #{option_class_name})")

          root.create_class(option_class_name, superclass_name: "::Config::Options") do |mod|
            # We need this to be generic only becuase `Config::Options` is an
            # enumerable and, thus, needs to redeclare the `Elem` type member.
            #
            # We declare it as a fixed member of `T.untyped` so that if anyone
            # enumerates the entries, we don't make any assumptions about their
            # types.
            mod.create_extend("T::Generic")
            mod.create_type_member("Elem", value: "type_member(fixed: T.untyped)")

            method_names.each do |method_name|
              # Create getter method
              mod.create_method(
                method_name.to_s,
                return_type: "T.untyped"
              )

              # Create setter method
              mod.create_method(
                "#{method_name}=",
                parameters: [create_param("value", type: "T.untyped")],
                return_type: "T.untyped"
              )
            end
          end
        end

        sig { override.returns(T::Enumerable[Module]) }
        def gather_constants
          name = ::Config.const_name
          return [] unless Object.const_defined?(name)

          config_object = Object.const_get(name)
          options_class_name = "#{name}#{CONFIG_OPTIONS_SUFFIX}"
          Object.const_set(options_class_name, config_object.singleton_class)

          Array(config_object.singleton_class)
        end
      end
    end
  end
end

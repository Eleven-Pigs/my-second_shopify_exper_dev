# typed: strict
# frozen_string_literal: true

require "erb"
require "etc"
require "fileutils"
require "json"
require "parallel"
require "pathname"
require "set"
require "shellwords"
require "spoom"
require "tempfile"

require "tapioca"
require "tapioca/runtime/reflection"
require "tapioca/runtime/trackers"
require "tapioca/runtime/dynamic_mixin_compiler"
require "tapioca/runtime/loader"
require "tapioca/helpers/sorbet_helper"
require "tapioca/helpers/type_variable_helper"
require "tapioca/sorbet_ext/generic_name_patch"
require "tapioca/sorbet_ext/fixed_hash_patch"
require "tapioca/runtime/generic_type_registry"
require "tapioca/helpers/cli_helper"
require "tapioca/helpers/config_helper"
require "tapioca/helpers/signatures_helper"
require "tapioca/helpers/rbi_helper"
require "tapioca/helpers/shims_helper"
require "tapioca/repo_index"
require "tapioca/commands"
require "tapioca/cli"
require "tapioca/gemfile"
require "tapioca/executor"
require "tapioca/static/symbol_table_parser"
require "tapioca/static/symbol_loader"
require "tapioca/gem/events"
require "tapioca/gem/listeners"
require "tapioca/gem/pipeline"
require "tapioca/dsl/compiler"
require "tapioca/dsl/pipeline"
require "tapioca/static/requires_compiler"

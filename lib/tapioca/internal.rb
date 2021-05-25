# typed: strict
# frozen_string_literal: true

require "tapioca"
require "tapioca/loader"
require "tapioca/constant_locator"
require "tapioca/generic_type_registry"
require "tapioca/sorbet_ext/generic_name_patch"
require "tapioca/sorbet_ext/fixed_hash_patch"
require "tapioca/config"
require "tapioca/config_builder"
require "tapioca/generator"
require "tapioca/cli"
require "tapioca/cli/main"
require "tapioca/gemfile"
require "tapioca/rbi/model"
require "tapioca/rbi/visitor"
require "tapioca/rbi/rewriters/nest_singleton_methods"
require "tapioca/rbi/rewriters/nest_non_public_methods"
require "tapioca/rbi/rewriters/group_nodes"
require "tapioca/rbi/rewriters/sort_nodes"
require "tapioca/rbi/printer"
require "tapioca/compilers/sorbet"
require "tapioca/compilers/requires_compiler"
require "tapioca/compilers/symbol_table_compiler"
require "tapioca/compilers/symbol_table/symbol_generator"
require "tapioca/compilers/symbol_table/symbol_loader"
require "tapioca/compilers/todos_compiler"
require "tapioca/compilers/dsl_compiler"

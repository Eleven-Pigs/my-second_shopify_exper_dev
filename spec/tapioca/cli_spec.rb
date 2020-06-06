# frozen_string_literal: true

require "spec_helper"
require "pathname"
require "shellwords"

module Contents
  FOO_RBI = <<~CONTENTS
    # This file is autogenerated. Do not edit it by hand. Regenerate it with:
    #   generate command

    # typed: true

    module Foo
      def self.bar(a = _, b: _, **opts); end
    end

    Foo::PI = T.let(T.unsafe(nil), Float)
  CONTENTS

  BAR_RBI = <<~CONTENTS
    # This file is autogenerated. Do not edit it by hand. Regenerate it with:
    #   generate command

    # typed: true

    module Bar
      def self.bar(a = _, b: _, **opts); end
    end

    Bar::PI = T.let(T.unsafe(nil), Float)
  CONTENTS

  BAZ_RBI = <<~CONTENTS
    # This file is autogenerated. Do not edit it by hand. Regenerate it with:
    #   generate command

    # typed: true

    module Baz
    end

    class Baz::Test
      def fizz; end
    end
  CONTENTS
end

describe(Tapioca::Cli) do
  attr_reader :outdir
  attr_reader :repo_path

  def execute(command, args = [], flags = {})
    flags = {
      outdir: outdir,
      generate_command: "'generate command'",
    }.merge(flags).flat_map { |k, v| ["--#{k}", v.to_s] }

    exec_command = [
      "bundle",
      "exec",
      "bin/tapioca",
      command,
      *flags,
      *args,
    ]

    Bundler.with_clean_env do
      IO.popen(
        exec_command.join(' '),
        chdir: repo_path,
        err: [:child, :out],
      ).read
    end
  end

  before(:all) do
    @repo_path = (Pathname.new(__dir__) / ".." / "support" / "repo").expand_path
    Bundler.with_clean_env do
      IO.popen(
        ["bundle", "install", "--quiet"],
        chdir: @repo_path
      ).read
    end
  end

  around(:each) do |&blk|
    FileUtils.rm_rf(repo_path / "sorbet")
    Dir.mktmpdir do |outdir|
      @outdir = outdir
      super(&blk)
    end
    FileUtils.rm_rf(repo_path / "sorbet")
  end

  describe("#init") do
    it 'must create proper files' do
      output = execute("init")

      assert_equal(output, <<-OUTPUT)
      create  sorbet/config
      create  sorbet/tapioca/require.rb
      OUTPUT

      assert_path_exists(repo_path / "sorbet/config")
      assert_equal(File.read(repo_path / "sorbet/config"), <<~CONTENTS)
        --dir
        .
      CONTENTS
      assert_path_exists(repo_path / "sorbet/tapioca/require.rb")
      assert_equal(File.read(repo_path / "sorbet/tapioca/require.rb"), <<~CONTENTS)
        # frozen_string_literal: true
        # typed: false

        # Add your extra requires here
      CONTENTS
    end

    it 'must not overwrite files' do
      FileUtils.mkdir_p(repo_path / "sorbet/tapioca")
      FileUtils.touch([
        repo_path / "sorbet/config",
        repo_path / "sorbet/tapioca/require.rb",
      ])

      output = execute("init")

      assert_equal(output, <<-OUTPUT)
        skip  sorbet/config
        skip  sorbet/tapioca/require.rb
      OUTPUT

      assert_empty(File.read(repo_path / "sorbet/config"))
      assert_empty(File.read(repo_path / "sorbet/tapioca/require.rb"))
    end
  end

  describe("#todo") do
    before(:each) do
      execute("init")
    end

    it 'does nothing if all constant are already resolved' do
      output = execute("todo")

      assert_equal(output, <<~OUTPUT)
        Compiling sorbet/rbi/todo.rbi, this may take a few seconds... Nothing to do
      OUTPUT

      refute_path_exists(repo_path / "sorbet/rbi/todo.rbi")
    end

    it 'creates a list of all unresolved constants' do
      File.write(repo_path / "file.rb", <<~RUBY)
        class Foo < ::Undef1
          def foo
            Undef2.new
          end
        end

        ::Undef1::Undef3.foo
        Undef2::Undef4.bar
      RUBY

      output = execute("todo")

      File.delete(repo_path / "file.rb")

      assert_equal(output, <<~CONTENTS)
        Compiling sorbet/rbi/todo.rbi, this may take a few seconds... Done
        All unresolved constants have been written to sorbet/rbi/todo.rbi.
        Please review changes and commit them.
      CONTENTS

      assert_path_exists(repo_path / "sorbet/rbi/todo.rbi")
      assert_equal(File.read(repo_path / "sorbet/rbi/todo.rbi"), <<~CONTENTS)
        # This file is autogenerated. Do not edit it by hand. Regenerate it with:
        #   generate command

        # typed: false

        module ::Undef1; end
        module ::Undef1::Undef3; end
        module ::Undef2::Undef4; end
        module Foo::Undef2; end
      CONTENTS
    end

    it 'deletes the todo.rbi file when everything is resolved' do
      FileUtils.mkdir_p(repo_path / "sorbet/rbi")
      File.write(repo_path / "sorbet/rbi/todo.rbi", <<-RBI)
        # This file is autogenerated. Do not edit it by hand. Regenerate it with:
        #   generate command

        # typed: false

        module ::Undef1; end
        module ::Undef1::Undef2; end
        module ::Undef2::Undef4; end
        module Foo::Undef2; end
      RBI

      output = execute("todo")

      assert_equal(output, <<~OUTPUT)
        Compiling sorbet/rbi/todo.rbi, this may take a few seconds... Nothing to do
      OUTPUT

      refute_path_exists(repo_path / "sorbet/rbi/todo.rbi")
    end
  end

  describe("#require") do
    before(:each) do
      execute("init")
    end

    it 'does nothing if there is nothing to require' do
      File.write(repo_path / "sorbet/config", <<~CONFIG)
        .
        --ignore=postrequire.rb
        --ignore=postrequire_faulty.rb
      CONFIG

      output = execute("require")

      assert_equal(output, <<~OUTPUT)
        Compiling sorbet/tapioca/require.rb, this may take a few seconds... Nothing to do
      OUTPUT

      assert_path_exists(repo_path / "sorbet/tapioca/require.rb")
      assert_equal(File.read(repo_path / "sorbet/tapioca/require.rb"), <<~CONTENTS)
        # frozen_string_literal: true
        # typed: false

        # Add your extra requires here
      CONTENTS
    end

    it 'creates a list of all requires from all Ruby files passed to Sorbet' do
      output = execute("require")

      assert_equal(output, <<~OUTPUT)
        Compiling sorbet/tapioca/require.rb, this may take a few seconds... Done
        All requires from this application have been written to sorbet/tapioca/require.rb.
        Please review changes and commit them, then run tapioca sync.
      OUTPUT

      assert_path_exists(repo_path / "sorbet/tapioca/require.rb")
      assert_equal(File.read(repo_path / "sorbet/tapioca/require.rb"), <<~CONTENTS)
        # This file is autogenerated. Do not edit it by hand. Regenerate it with:
        #   generate command

        # typed: false

        require 'foo/secret'
        require 'foo/will_fail'
      CONTENTS
    end

    it 'takes into account sorbet ignored paths' do
      File.write(repo_path / "sorbet/config", <<~CONFIG)
        .
        --ignore=postrequire_faulty.rb
      CONFIG

      output = execute("require")

      assert_equal(output, <<~OUTPUT)
        Compiling sorbet/tapioca/require.rb, this may take a few seconds... Done
        All requires from this application have been written to sorbet/tapioca/require.rb.
        Please review changes and commit them, then run tapioca sync.
      OUTPUT

      assert_path_exists(repo_path / "sorbet/tapioca/require.rb")
      assert_equal(File.read(repo_path / "sorbet/tapioca/require.rb"), <<~CONTENTS)
        # This file is autogenerated. Do not edit it by hand. Regenerate it with:
        #   generate command

        # typed: false

        require 'foo/secret'
      CONTENTS
    end
  end

  describe("#generate") do
    before(:each) do
      execute("init")
    end

    it 'must generate a single gem RBI' do
      output = execute("generate", "foo")

      assert_includes(output, <<~OUTPUT)
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_equal(File.read("#{outdir}/foo@0.0.1.rbi"), Contents::FOO_RBI)

      refute_path_exists("#{outdir}/bar@0.3.0.rbi")
      refute_path_exists("#{outdir}/baz@0.0.2.rbi")
    end

    it 'must perform postrequire properly' do
      output = execute("generate", "foo", postrequire: repo_path / "postrequire.rb")

      assert_includes(output, <<~OUTPUT)
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_equal(File.read("#{outdir}/foo@0.0.1.rbi"), template(<<~CONTENTS))
        #{Contents::FOO_RBI}
        class Foo::Secret
        end

        <% if ruby_version(">= 2.4.0") %>
        Foo::Secret::VALUE = T.let(T.unsafe(nil), Integer)
        <% else %>
        Foo::Secret::VALUE = T.let(T.unsafe(nil), Fixnum)
        <% end %>
      CONTENTS

      refute_path_exists("#{outdir}/bar@0.3.0.rbi")
      refute_path_exists("#{outdir}/baz@0.0.2.rbi")
    end

    it 'explains what went wrong when it can\'t load the postrequire properly' do
      output = execute("generate", "foo", postrequire: repo_path / "postrequire_faulty.rb")

      output.sub!(%r{/.*/postrequire_faulty\.rb}, "/postrequire_faulty.rb")
      assert_includes(output, <<~OUTPUT)
        Requiring all gems to prepare for compiling... \n
        LoadError: cannot load such file -- foo/will_fail

        Tapioca could not load all the gems required by your application.
        If you populated /postrequire_faulty.rb with tapioca require
        you should probably review it and remove the faulty line.
      OUTPUT
    end

    it 'must generate multiple gem RBIs' do
      output = execute("generate", ["foo", "bar"])

      assert_includes(output, <<~OUTPUT)
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      assert_includes(output, <<~OUTPUT)
        Processing 'bar' gem:
          Compiling bar, this may take a few seconds...   Done
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_path_exists("#{outdir}/bar@0.3.0.rbi")

      assert_equal(File.read("#{outdir}/foo@0.0.1.rbi"), Contents::FOO_RBI)
      assert_equal(File.read("#{outdir}/bar@0.3.0.rbi"), Contents::BAR_RBI)

      refute_path_exists("#{outdir}/baz@0.0.2.rbi")
    end

    it 'must generate RBIs for all gems in the Gemfile' do
      output = execute("generate")

      assert_includes(output, <<~OUTPUT)
        Processing 'bar' gem:
          Compiling bar, this may take a few seconds...   Done
      OUTPUT

      assert_includes(output, <<~OUTPUT)
        Processing 'baz' gem:
          Compiling baz, this may take a few seconds...   Done
      OUTPUT

      assert_includes(output, <<~OUTPUT)
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_path_exists("#{outdir}/bar@0.3.0.rbi")
      assert_path_exists("#{outdir}/baz@0.0.2.rbi")

      assert_equal(File.read("#{outdir}/foo@0.0.1.rbi"), Contents::FOO_RBI)
      assert_equal(File.read("#{outdir}/bar@0.3.0.rbi"), Contents::BAR_RBI)
      assert_equal(File.read("#{outdir}/baz@0.0.2.rbi"), Contents::BAZ_RBI)
    end

    it 'must respect exclude option' do
      output = execute("generate", "", exclude: "foo bar")

      refute_includes(output, <<~OUTPUT)
        Processing 'bar' gem:
          Compiling bar, this may take a few seconds...   Done
      OUTPUT

      assert_includes(output, <<~OUTPUT)
        Processing 'baz' gem:
          Compiling baz, this may take a few seconds...   Done
      OUTPUT

      refute_includes(output, <<~OUTPUT)
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      refute_path_exists("#{outdir}/foo@0.0.1.rbi")
      refute_path_exists("#{outdir}/bar@0.3.0.rbi")
      assert_path_exists("#{outdir}/baz@0.0.2.rbi")

      assert_equal(File.read("#{outdir}/baz@0.0.2.rbi"), Contents::BAZ_RBI)
    end

    it 'does not crash when the extras gem is loaded' do
      File.write(repo_path / "sorbet/tapioca/require.rb", 'require "extras/all"')
      output = execute("generate", "foo")

      assert_includes(output, <<~OUTPUT)
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_equal(File.read("#{outdir}/foo@0.0.1.rbi"), Contents::FOO_RBI)

      File.delete(repo_path / "sorbet/tapioca/require.rb")
    end
  end

  describe("#sync") do
    before(:each) do
      execute("init")
    end

    it 'must perform no operations if everything is up-to-date' do
      execute("generate")

      output = execute("sync")

      refute_includes(output, "-- Removing:")
      refute_includes(output, "++ Adding:")
      refute_includes(output, "-> Moving:")

      assert_includes(output, <<~OUTPUT)
        Removing RBI files of gems that have been removed:

          Nothing to do.
      OUTPUT
      assert_includes(output, <<~OUTPUT)
        Generating RBI files of gems that are added or updated:

          Nothing to do.
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_path_exists("#{outdir}/bar@0.3.0.rbi")
      assert_path_exists("#{outdir}/baz@0.0.2.rbi")
    end

    it 'must respect exclude option' do
      execute("generate")

      output = execute("sync", "", exclude: "foo bar")

      assert_includes(output, "-- Removing: #{outdir}/foo@0.0.1.rbi\n")
      assert_includes(output, "-- Removing: #{outdir}/bar@0.3.0.rbi\n")
      refute_includes(output, "-- Removing: #{outdir}/baz@0.0.2.rbi\n")
      refute_includes(output, "++ Adding:")
      refute_includes(output, "-> Moving:")

      refute_includes(output, <<~OUTPUT)
        Removing RBI files of gems that have been removed:

          Nothing to do.
      OUTPUT
      assert_includes(output, <<~OUTPUT)
        Generating RBI files of gems that are added or updated:

          Nothing to do.
      OUTPUT

      refute_path_exists("#{outdir}/foo@0.0.1.rbi")
      refute_path_exists("#{outdir}/bar@0.3.0.rbi")
      assert_path_exists("#{outdir}/baz@0.0.2.rbi")
    end

    it 'must remove outdated RBIs' do
      execute("generate")
      FileUtils.touch("#{outdir}/outdated@5.0.0.rbi")

      output = execute("sync")

      assert_includes(output, "-- Removing: #{outdir}/outdated@5.0.0.rbi\n")
      refute_includes(output, "++ Adding:")
      refute_includes(output, "-> Moving:")

      assert_includes(output, <<~OUTPUT)
        Generating RBI files of gems that are added or updated:

          Nothing to do.
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_path_exists("#{outdir}/bar@0.3.0.rbi")
      assert_path_exists("#{outdir}/baz@0.0.2.rbi")
      refute_path_exists("#{outdir}/outdated@5.0.0.rbi")
    end

    it 'must add missing RBIs' do
      %w{
        foo@0.0.1.rbi
      }.each do |rbi|
        FileUtils.touch("#{outdir}/#{rbi}")
      end

      output = execute("sync")

      assert_includes(output, "++ Adding: #{outdir}/bar@0.3.0.rbi\n")
      assert_includes(output, "++ Adding: #{outdir}/baz@0.0.2.rbi\n")
      refute_includes(output, "-- Removing:")
      refute_includes(output, "-> Moving:")

      assert_includes(output, <<~OUTPUT)
        Removing RBI files of gems that have been removed:

          Nothing to do.
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_path_exists("#{outdir}/bar@0.3.0.rbi")
      assert_path_exists("#{outdir}/baz@0.0.2.rbi")
    end

    it 'must move outdated RBIs' do
      %w{
        foo@0.0.1.rbi
        bar@0.0.1.rbi
        baz@0.0.1.rbi
      }.each do |rbi|
        FileUtils.touch("#{outdir}/#{rbi}")
      end

      output = execute("sync")

      assert_includes(output, "-> Moving: #{outdir}/bar@0.0.1.rbi to #{outdir}/bar@0.3.0.rbi\n")
      assert_includes(output, "++ Adding: #{outdir}/bar@0.3.0.rbi\n")
      assert_includes(output, "-> Moving: #{outdir}/baz@0.0.1.rbi to #{outdir}/baz@0.0.2.rbi\n")
      assert_includes(output, "++ Adding: #{outdir}/baz@0.0.2.rbi\n")
      refute_includes(output, "-- Removing:")

      assert_includes(output, <<~OUTPUT)
        Removing RBI files of gems that have been removed:

          Nothing to do.
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_path_exists("#{outdir}/bar@0.3.0.rbi")
      assert_path_exists("#{outdir}/baz@0.0.2.rbi")

      refute_path_exists("#{outdir}/bar@0.0.1.rbi")
      refute_path_exists("#{outdir}/baz@0.0.1.rbi")
    end
  end
end

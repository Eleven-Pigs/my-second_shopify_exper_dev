# typed: true
# frozen_string_literal: true

require "spec_helper"
require "pathname"
require "shellwords"

module Contents
  FOO_RBI = <<~CONTENTS
    # DO NOT EDIT MANUALLY
    # This is an autogenerated file for types exported from the `foo` gem.
    # Please instead update this file by running `bin/tapioca sync`.

    # typed: true

    module Foo
      class << self
        def bar(a = T.unsafe(nil), b: T.unsafe(nil), **opts); end
      end
    end

    Foo::PI = T.let(T.unsafe(nil), Float)
  CONTENTS

  BAR_RBI = <<~CONTENTS
    # DO NOT EDIT MANUALLY
    # This is an autogenerated file for types exported from the `bar` gem.
    # Please instead update this file by running `bin/tapioca sync`.

    # typed: true

    module Bar
      class << self
        def bar(a = T.unsafe(nil), b: T.unsafe(nil), **opts); end
      end
    end

    Bar::PI = T.let(T.unsafe(nil), Float)
  CONTENTS

  BAZ_RBI = <<~CONTENTS
    # DO NOT EDIT MANUALLY
    # This is an autogenerated file for types exported from the `baz` gem.
    # Please instead update this file by running `bin/tapioca sync`.

    # typed: true

    module Baz
    end

    class Baz::Role
      include(::SmartProperties)
      extend(::SmartProperties::ClassMethods)
    end

    class Baz::Test
      def fizz; end
    end
  CONTENTS
end

class Tapioca::CliSpec < Minitest::HooksSpec
  include TemplateHelper

  attr_reader :outdir
  attr_reader :repo_path

  def execute(command, args = [], flags = {})
    flags = {
      outdir: outdir,
    }.merge(flags).flat_map { |k, v| ["--#{k}", v.to_s] }

    exec_command = [
      "bundle",
      "exec",
      "tapioca",
      command,
      *flags,
      *args,
    ]

    Bundler.with_unbundled_env do
      process = IO.popen(
        exec_command.join(' '),
        chdir: repo_path,
        err: [:child, :out],
      )
      body = process.read
      process.close
      body
    end
  end

  before(:all) do
    @repo_path = (Pathname.new(__dir__) / ".." / "support" / "repo").expand_path
    Bundler.with_unbundled_env do
      IO.popen(["bundle", "install", "--quiet"], chdir: @repo_path).read
      IO.popen(["bundle", "lock", "--add-platform=ruby"], chdir: @repo_path).read
    end
  end

  around(:each) do |&blk|
    FileUtils.rm_rf(T.unsafe(self).repo_path / "sorbet")
    Dir.mktmpdir do |outdir|
      @outdir = outdir
      super(&blk)
    end
    FileUtils.rm_rf(T.unsafe(self).repo_path / "sorbet")
  end

  describe("#version") do
    it 'must display the version when passing --version' do
      output = execute("--version")
      assert_equal("Tapioca v#{Tapioca::VERSION}", output&.strip)
    end

    it 'must display the version when passing -v' do
      output = execute("-v")
      assert_equal("Tapioca v#{Tapioca::VERSION}", output&.strip)
    end
  end

  describe("#init") do
    it 'must create proper files' do
      FileUtils.rm_f(repo_path / "bin/tapioca")
      output = execute("init")

      assert_equal(<<-OUTPUT, output)
      create  sorbet/config
      create  sorbet/tapioca/require.rb
      create  bin/tapioca
      OUTPUT

      assert_path_exists(repo_path / "sorbet/config")
      assert_equal(<<~CONTENTS, File.read(repo_path / "sorbet/config"))
        --dir
        .
      CONTENTS
      assert_path_exists(repo_path / "sorbet/tapioca/require.rb")
      assert_equal(<<~CONTENTS, File.read(repo_path / "sorbet/tapioca/require.rb"))
        # typed: false
        # frozen_string_literal: true

        # Add your extra requires here
      CONTENTS

      assert_path_exists(repo_path / "bin/tapioca")
    end

    it 'must not overwrite files' do
      FileUtils.mkdir_p(repo_path / "sorbet/tapioca")
      FileUtils.mkdir_p(repo_path / "bin")
      FileUtils.touch([
        repo_path / "bin/tapioca",
        repo_path / "sorbet/config",
        repo_path / "sorbet/tapioca/require.rb",
      ])

      output = execute("init")

      assert_equal(<<-OUTPUT, output)
        skip  sorbet/config
        skip  sorbet/tapioca/require.rb
       force  bin/tapioca
      OUTPUT

      assert_empty(File.read(repo_path / "sorbet/config"))
      assert_empty(File.read(repo_path / "sorbet/tapioca/require.rb"))
    end
  end

  describe("#todo") do
    before do
      execute("init")
    end

    it 'does nothing if all constant are already resolved' do
      output = execute("todo")

      assert_equal(<<~OUTPUT, output)
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

      assert_equal(<<~CONTENTS, output)
        Compiling sorbet/rbi/todo.rbi, this may take a few seconds... Done
        All unresolved constants have been written to sorbet/rbi/todo.rbi.
        Please review changes and commit them.
      CONTENTS

      assert_path_exists(repo_path / "sorbet/rbi/todo.rbi")
      assert_equal(<<~CONTENTS, File.read(repo_path / "sorbet/rbi/todo.rbi"))
        # DO NOT EDIT MANUALLY
        # This is an autogenerated file for unresolved constants.
        # Please instead update this file by running `bin/tapioca todo`.

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
        # DO NOT EDIT MANUALLY
        # This is an autogenerated file for unresolved constants.
        # Please instead update this file by running `bin/tapioca todo`.

        # typed: false

        module ::Undef1; end
        module ::Undef1::Undef2; end
        module ::Undef2::Undef4; end
        module Foo::Undef2; end
      RBI

      output = execute("todo")

      assert_equal(<<~OUTPUT, output)
        Compiling sorbet/rbi/todo.rbi, this may take a few seconds... Nothing to do
      OUTPUT

      refute_path_exists(repo_path / "sorbet/rbi/todo.rbi")
    end
  end

  describe("#require") do
    before do
      execute("init")
    end

    it 'does nothing if there is nothing to require' do
      File.write(repo_path / "sorbet/config", <<~CONFIG)
        .
        --ignore=postrequire.rb
        --ignore=postrequire_faulty.rb
        --ignore=config/
      CONFIG

      output = execute("require")

      assert_equal(<<~OUTPUT, output)
        Compiling sorbet/tapioca/require.rb, this may take a few seconds... Nothing to do
      OUTPUT

      assert_path_exists(repo_path / "sorbet/tapioca/require.rb")
      assert_equal(<<~CONTENTS, File.read(repo_path / "sorbet/tapioca/require.rb"))
        # typed: false
        # frozen_string_literal: true

        # Add your extra requires here
      CONTENTS
    end

    it 'creates a list of all requires from all Ruby files passed to Sorbet' do
      output = execute("require")

      assert_equal(<<~OUTPUT, output)
        Compiling sorbet/tapioca/require.rb, this may take a few seconds... Done
        All requires from this application have been written to sorbet/tapioca/require.rb.
        Please review changes and commit them, then run `bin/tapioca sync`.
      OUTPUT

      assert_path_exists(repo_path / "sorbet/tapioca/require.rb")
      assert_equal(<<~CONTENTS, File.read(repo_path / "sorbet/tapioca/require.rb"))
        # DO NOT EDIT MANUALLY
        # This is an autogenerated file for explicit gem requires.
        # Please instead update this file by running `bin/tapioca require`.

        # typed: false

        require 'active_support/all'
        require 'baz'
        require 'foo/secret'
        require 'foo/will_fail'
        require 'smart_properties'
      CONTENTS
    end

    it 'takes into account sorbet ignored paths' do
      File.write(repo_path / "sorbet/config", <<~CONFIG)
        .
        --ignore=postrequire_faulty.rb
        --ignore=config/
      CONFIG

      output = execute("require")

      assert_equal(<<~OUTPUT, output)
        Compiling sorbet/tapioca/require.rb, this may take a few seconds... Done
        All requires from this application have been written to sorbet/tapioca/require.rb.
        Please review changes and commit them, then run `bin/tapioca sync`.
      OUTPUT

      assert_path_exists(repo_path / "sorbet/tapioca/require.rb")
      assert_equal(<<~CONTENTS, File.read(repo_path / "sorbet/tapioca/require.rb"))
        # DO NOT EDIT MANUALLY
        # This is an autogenerated file for explicit gem requires.
        # Please instead update this file by running `bin/tapioca require`.

        # typed: false

        require 'foo/secret'
      CONTENTS
    end
  end

  describe("#dsl") do
    it 'does not generate anything if there are no matching constants' do
      output = execute("dsl", "User")

      assert_equal(<<~OUTPUT, output)
        Loading Rails application... Done
        Loading DSL generator classes... Done
        Compiling DSL RBI files...

        No classes/modules can be matched for RBI generation.
        Please check that the requested classes/modules include processable DSL methods.
      OUTPUT

      refute_path_exists("#{outdir}/baz/role.rbi")
      refute_path_exists("#{outdir}/post.rbi")
      refute_path_exists("#{outdir}/namespace/comment.rbi")
      refute_path_exists("#{outdir}/user.rbi")
    end

    it 'generates RBI files for only required constants' do
      output = execute("dsl", "Post")

      assert_equal(<<~OUTPUT, output)
        Loading Rails application... Done
        Loading DSL generator classes... Done
        Compiling DSL RBI files...

        Wrote: #{outdir}/post.rbi

        Done
        All operations performed in working directory.
        Please review changes and commit them.
      OUTPUT

      refute_path_exists("#{outdir}/baz/role.rbi")
      assert_path_exists("#{outdir}/post.rbi")
      refute_path_exists("#{outdir}/namespace/comment.rbi")
      refute_path_exists("#{outdir}/user.rbi")

      assert_equal(<<~CONTENTS.chomp, File.read("#{outdir}/post.rbi"))
        # DO NOT EDIT MANUALLY
        # This is an autogenerated file for dynamic methods in `Post`.
        # Please instead update this file by running `bin/tapioca dsl Post`.

        # typed: true
        class Post
          sig { returns(T.nilable(::String)) }
          def title; end

          sig { params(title: T.nilable(::String)).returns(T.nilable(::String)) }
          def title=(title); end
        end
      CONTENTS
    end

    it 'errors for unprocessable required constants' do
      output = execute("dsl", ["NonExistent::Foo", "NonExistent::Bar", "NonExistent::Baz"])

      assert_equal(<<~OUTPUT, output)
        Loading Rails application... Done
        Loading DSL generator classes... Done
        Compiling DSL RBI files...

        Error: Cannot find constant 'NonExistent::Foo'
        Error: Cannot find constant 'NonExistent::Bar'
        Error: Cannot find constant 'NonExistent::Baz'
      OUTPUT

      refute_path_exists("#{outdir}/baz/role.rbi")
      refute_path_exists("#{outdir}/post.rbi")
      refute_path_exists("#{outdir}/namespace/comment.rbi")
      refute_path_exists("#{outdir}/user.rbi")
    end

    it 'removes RBI files for unprocessable required constants' do
      FileUtils.mkdir_p("#{outdir}/non_existent")
      FileUtils.touch("#{outdir}/non_existent/foo.rbi")
      FileUtils.touch("#{outdir}/non_existent/baz.rbi")

      output = execute("dsl", ["NonExistent::Foo", "NonExistent::Bar", "NonExistent::Baz"])

      assert_equal(<<~OUTPUT, output)
        Loading Rails application... Done
        Loading DSL generator classes... Done
        Compiling DSL RBI files...

        Error: Cannot find constant 'NonExistent::Foo'
        -- Removing: #{outdir}/non_existent/foo.rbi
        Error: Cannot find constant 'NonExistent::Bar'
        Error: Cannot find constant 'NonExistent::Baz'
        -- Removing: #{outdir}/non_existent/baz.rbi
      OUTPUT

      refute_path_exists("#{outdir}/non_existent/foo.rbi")
      refute_path_exists("#{outdir}/non_existent/baz.rbi")

      refute_path_exists("#{outdir}/baz/role.rbi")
      refute_path_exists("#{outdir}/post.rbi")
      refute_path_exists("#{outdir}/namespace/comment.rbi")
      refute_path_exists("#{outdir}/user.rbi")
    end

    it 'generates RBI files for all processable constants' do
      output = execute("dsl")

      assert_equal(<<~OUTPUT, output)
        Loading Rails application... Done
        Loading DSL generator classes... Done
        Compiling DSL RBI files...

        Wrote: #{outdir}/baz/role.rbi
        Wrote: #{outdir}/namespace/comment.rbi
        Wrote: #{outdir}/post.rbi

        Done
        All operations performed in working directory.
        Please review changes and commit them.
      OUTPUT

      assert_path_exists("#{outdir}/baz/role.rbi")
      assert_path_exists("#{outdir}/post.rbi")
      assert_path_exists("#{outdir}/namespace/comment.rbi")
      refute_path_exists("#{outdir}/user.rbi")

      assert_equal(<<~CONTENTS.chomp, File.read("#{outdir}/baz/role.rbi"))
        # DO NOT EDIT MANUALLY
        # This is an autogenerated file for dynamic methods in `Baz::Role`.
        # Please instead update this file by running `bin/tapioca dsl Baz::Role`.

        # typed: true
        module Baz
          class Role
            sig { returns(T.nilable(::String)) }
            def title; end

            sig { params(title: T.nilable(::String)).returns(T.nilable(::String)) }
            def title=(title); end
          end
        end
      CONTENTS

      assert_equal(<<~CONTENTS.chomp, File.read("#{outdir}/post.rbi"))
        # DO NOT EDIT MANUALLY
        # This is an autogenerated file for dynamic methods in `Post`.
        # Please instead update this file by running `bin/tapioca dsl Post`.

        # typed: true
        class Post
          sig { returns(T.nilable(::String)) }
          def title; end

          sig { params(title: T.nilable(::String)).returns(T.nilable(::String)) }
          def title=(title); end
        end
      CONTENTS

      assert_equal(<<~CONTENTS.chomp, File.read("#{outdir}/namespace/comment.rbi"))
        # DO NOT EDIT MANUALLY
        # This is an autogenerated file for dynamic methods in `Namespace::Comment`.
        # Please instead update this file by running `bin/tapioca dsl Namespace::Comment`.

        # typed: true
        module Namespace
          class Comment
            sig { returns(::String) }
            def body; end

            sig { params(body: ::String).returns(::String) }
            def body=(body); end
          end
        end
      CONTENTS
    end

    it 'can generates RBI files quietly' do
      output = execute("dsl", "--quiet")

      assert_equal(<<~OUTPUT, output)
        Loading Rails application... Done
        Loading DSL generator classes... Done
        Compiling DSL RBI files...


        Done
        All operations performed in working directory.
        Please review changes and commit them.
      OUTPUT

      assert_path_exists("#{outdir}/baz/role.rbi")
      assert_path_exists("#{outdir}/post.rbi")
      assert_path_exists("#{outdir}/namespace/comment.rbi")
      refute_path_exists("#{outdir}/user.rbi")
    end

    it 'removes stale RBI files' do
      FileUtils.mkdir_p("#{outdir}/to_be_deleted")
      FileUtils.touch("#{outdir}/to_be_deleted/foo.rbi")
      FileUtils.touch("#{outdir}/to_be_deleted/baz.rbi")
      FileUtils.touch("#{outdir}/does_not_exist.rbi")

      output = execute("dsl")

      assert_equal(<<~OUTPUT, output)
        Loading Rails application... Done
        Loading DSL generator classes... Done
        Compiling DSL RBI files...

        Wrote: #{outdir}/baz/role.rbi
        Wrote: #{outdir}/namespace/comment.rbi
        Wrote: #{outdir}/post.rbi

        Removing stale RBI files...
        -- Removing: #{outdir}/does_not_exist.rbi
        -- Removing: #{outdir}/to_be_deleted/baz.rbi
        -- Removing: #{outdir}/to_be_deleted/foo.rbi

        Done
        All operations performed in working directory.
        Please review changes and commit them.
      OUTPUT

      refute_path_exists("#{outdir}/does_not_exist.rbi")
      refute_path_exists("#{outdir}/to_be_deleted/foo.rbi")
      refute_path_exists("#{outdir}/to_be_deleted/baz.rbi")

      assert_path_exists("#{outdir}/baz/role.rbi")
      assert_path_exists("#{outdir}/post.rbi")
      assert_path_exists("#{outdir}/namespace/comment.rbi")
      refute_path_exists("#{outdir}/user.rbi")
    end

    it 'removes stale RBI files of requested constants' do
      FileUtils.touch("#{outdir}/user.rbi")

      output = execute("dsl", ["Post", "User"])

      assert_equal(<<~OUTPUT, output)
        Loading Rails application... Done
        Loading DSL generator classes... Done
        Compiling DSL RBI files...

        Wrote: #{outdir}/post.rbi

        Removing stale RBI files...
        -- Removing: #{outdir}/user.rbi

        Done
        All operations performed in working directory.
        Please review changes and commit them.
      OUTPUT

      assert_path_exists("#{outdir}/post.rbi")
      refute_path_exists("#{outdir}/user.rbi")
    end

    it 'does not generate anything if there are no matching generators' do
      output = execute("dsl", "", generators: "foo")

      assert_equal(<<~OUTPUT, output)
        Loading Rails application... Done
        Loading DSL generator classes... Done
        Compiling DSL RBI files...

        No classes/modules can be matched for RBI generation.
        Please check that the requested classes/modules include processable DSL methods.
      OUTPUT

      refute_path_exists("#{outdir}/post.rbi")
      refute_path_exists("#{outdir}/namespace/comment.rbi")
      refute_path_exists("#{outdir}/user.rbi")
    end

    describe("verify") do
      describe("with no changes") do
        before do
          execute("dsl")
        end

        it 'does nothing and returns exit_status 0' do
          output = execute("dsl", "--verify")

          assert_includes(output, <<~OUTPUT)
            Nothing to do, all RBIs are up-to-date.
          OUTPUT
          assert_includes($?.to_s, "exit 0") # rubocop:disable Style/SpecialGlobalVars
        end
      end

      describe("with new file") do
        before do
          execute("dsl")
          File.write(repo_path / "lib" / "image.rb", <<~RUBY)
            # typed: true
            # frozen_string_literal: true

            class Image
              include(SmartProperties)

              property :title, accepts: String
            end
          RUBY
        end

        after do
          FileUtils.rm_f(repo_path / "lib" / "image.rb")
        end

        it 'advises of new file(s) and returns exit_status 1' do
          output = execute("dsl", "--verify")

          assert_includes(output, <<~OUTPUT)
            RBI files are out-of-date, please run `bin/tapioca dsl` to update.
            Reason: New file(s) introduced.
          OUTPUT
          assert_includes($?.to_s, "exit 1") # rubocop:disable Style/SpecialGlobalVars
        end
      end

      describe("with modified file") do
        before do
          File.write(repo_path / "lib" / "image.rb", <<~RUBY)
            # typed: true
            # frozen_string_literal: true

            class Image
              include(SmartProperties)

              property :title, accepts: String
            end
          RUBY
          execute("dsl")
          File.write(repo_path / "lib" / "image.rb", <<~RUBY)
            # typed: true
            # frozen_string_literal: true

            class Image
              include SmartProperties

              property :title, accepts: String
              property :src, accepts: String
            end
          RUBY
        end

        after do
          FileUtils.rm_f(repo_path / "lib" / "image.rb")
        end

        it 'advises of modified file(s) and returns exit status 1' do
          output = execute("dsl", "--verify")

          assert_includes(output, <<~OUTPUT)
            RBI files are out-of-date, please run `bin/tapioca dsl` to update.
            Reason: File(s) updated:
              - sorbet/rbi/dsl/image.rbi
          OUTPUT
          assert_includes($?.to_s, "exit 1") # rubocop:disable Style/SpecialGlobalVars
        end
      end
    end
  end

  describe("#generate") do
    before do
      execute("init")
    end

    it 'must generate a single gem RBI' do
      output = execute("generate", "foo")

      assert_includes(output, <<~OUTPUT)
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_equal(Contents::FOO_RBI, File.read("#{outdir}/foo@0.0.1.rbi"))

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
      assert_equal(template(<<~CONTENTS), File.read("#{outdir}/foo@0.0.1.rbi"))
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
        If you populated /postrequire_faulty.rb with `bin/tapioca require`
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

      assert_equal(Contents::FOO_RBI, File.read("#{outdir}/foo@0.0.1.rbi"))
      assert_equal(Contents::BAR_RBI, File.read("#{outdir}/bar@0.3.0.rbi"))

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

      assert_equal(Contents::FOO_RBI, File.read("#{outdir}/foo@0.0.1.rbi"))
      assert_equal(Contents::BAR_RBI, File.read("#{outdir}/bar@0.3.0.rbi"))
      assert_equal(Contents::BAZ_RBI, File.read("#{outdir}/baz@0.0.2.rbi"))
    end

    it 'must not generate RBIs for missing gem specs' do
      skip "failure is to be investigated later"
      output = execute("generate")

      assert_includes(output, <<~OUTPUT.strip) if ruby_version(">= 2.5")
        Requiring all gems to prepare for compiling...  Done
          completed with missing specs: mini_portile2
      OUTPUT

      refute_includes(output, <<~OUTPUT.strip)
        Processing 'mini_portile2' gem:
          Compiling mini_portile2, this may take a few seconds...   Done
      OUTPUT
    end

    it 'must generate git gem RBIs with source revision numbers' do
      output = execute("generate", "ast")

      assert_includes(output, <<~OUTPUT)
        Processing 'ast' gem:
          Compiling ast, this may take a few seconds...   Done
      OUTPUT

      assert_path_exists("#{outdir}/ast@2.4.1-e07a4f66e05ac7972643a8841e336d327ea78ae1.rbi")
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

      assert_equal(Contents::BAZ_RBI, File.read("#{outdir}/baz@0.0.2.rbi"))
    end

    it 'does not crash when the extras gem is loaded' do
      File.write(repo_path / "sorbet/tapioca/require.rb", 'require "extras/shell"')
      output = execute("generate", "foo")

      assert_includes(output, <<~OUTPUT)
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      assert_path_exists("#{outdir}/foo@0.0.1.rbi")
      assert_equal(Contents::FOO_RBI, File.read("#{outdir}/foo@0.0.1.rbi"))

      File.delete(repo_path / "sorbet/tapioca/require.rb")
    end
  end

  describe("#sync") do
    before do
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

    it 'generate an empty RBI file' do
      output = execute("sync")

      assert_includes(output, "++ Adding: #{outdir}/qux@0.5.0.rbi\n")
      assert_includes(output, <<~OUTPUT)
        Compiling qux, this may take a few seconds...   Done (empty output)
      OUTPUT

      assert_equal(<<~CONTENTS.chomp, File.read("#{outdir}/qux@0.5.0.rbi"))
        # DO NOT EDIT MANUALLY
        # This is an autogenerated file for types exported from the `qux` gem.
        # Please instead update this file by running `bin/tapioca sync`.

        # typed: true

        # THIS IS AN EMPTY RBI FILE.
        # see https://github.com/Shopify/tapioca/blob/master/README.md#manual-gem-requires

      CONTENTS
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

  describe("deprecations") do
    it "prints the correct deprecation message with -c" do
      output = execute("dsl", ["-c", "foo"])
      assert_includes(output, "DEPRECATION: The `-c` and `--cmd` flags will be removed in a future release.")
    end

    it "prints the correct deprecation message with --cmd" do
      output = execute("dsl", ["--cmd", "foo"])
      assert_includes(output, "DEPRECATION: The `-c` and `--cmd` flags will be removed in a future release.")
    end

    it "doesn't print the correct deprecation message with no flag" do
      output = execute("dsl")
      refute_includes(output, "DEPRECATION: The `-c` and `--cmd` flags will be removed in a future release.")
    end
  end
end

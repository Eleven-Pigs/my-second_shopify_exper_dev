# frozen_string_literal: true

require "spec_helper"
require "pathname"
require "shellwords"

FOO_RBI_CONTENTS = <<~CONTENTS
  # This file is autogenerated. Do not edit it by hand. Regenerate it with:
  #   generate command

  # typed: true

  module Foo
    def self.bar(a = _, b: _, **opts); end
  end

  Foo::PI = T.let(T.unsafe(nil), Float)
CONTENTS

BAR_RBI_CONTENTS = <<~CONTENTS
  # This file is autogenerated. Do not edit it by hand. Regenerate it with:
  #   generate command

  # typed: true

  module Bar
    def self.bar(a = _, b: _, **opts); end
  end

  Bar::PI = T.let(T.unsafe(nil), Float)
CONTENTS

BAZ_RBI_CONTENTS = <<~CONTENTS
  # This file is autogenerated. Do not edit it by hand. Regenerate it with:
  #   generate command

  # typed: true

  module Baz
  end

  class Baz::Test
    def fizz; end
  end
CONTENTS

RSpec.describe(Tapioca::Cli) do
  let(:outdir) { @outdir }
  let(:repo_path) { Pathname.new(__dir__) / ".." / "support" / "repo" }

  def run(command, args = [], flags = {})
    flags = {
      outdir: outdir,
      generate_command: "generate command",
    }.merge(flags).flat_map { |k, v| ["--#{k}", v.to_s] }

    exec_command = [
      "bin/tapioca",
      command,
      *flags,
      *args,
    ]

    IO.popen(
      {
        "BUNDLE_GEMFILE" => (repo_path / "Gemfile").to_s,
      },
      exec_command,
      chdir: repo_path
    ).read
  end

  around(:each) do |example|
    Dir.mktmpdir do |outdir|
      @outdir = outdir
      example.run
    end
  end

  describe("#generate") do
    it 'must generate a single gem RBI' do
      output = run("generate", "foo")

      expect(output).to(include(<<~OUTPUT))
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      expect(File).to(exist("#{outdir}/foo@0.0.1.rbi"))
      expect(File.read("#{outdir}/foo@0.0.1.rbi")).to(eq(FOO_RBI_CONTENTS))

      expect(File).to_not(exist("#{outdir}/bar@0.3.0.rbi"))
      expect(File).to_not(exist("#{outdir}/baz@0.0.2.rbi"))
    end

    it 'must perform postrequire properly' do
      output = run("generate", "foo", postrequire: repo_path / "postrequire.rb")

      expect(output).to(include(<<~OUTPUT))
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      expect(File).to(exist("#{outdir}/foo@0.0.1.rbi"))
      expect(File.read("#{outdir}/foo@0.0.1.rbi")).to(eq(<<~CONTENTS))
        #{FOO_RBI_CONTENTS}
        class Foo::Secret
        end

        Foo::Secret::VALUE = T.let(T.unsafe(nil), Integer)
      CONTENTS

      expect(File).to_not(exist("#{outdir}/bar@0.3.0.rbi"))
      expect(File).to_not(exist("#{outdir}/baz@0.0.2.rbi"))
    end

    it 'must generate multiple gem RBIs' do
      output = run("generate", ["foo", "bar"])

      expect(output).to(include(<<~OUTPUT))
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      expect(output).to(include(<<~OUTPUT))
        Processing 'bar' gem:
          Compiling bar, this may take a few seconds...   Done
      OUTPUT

      expect(File).to(exist("#{outdir}/foo@0.0.1.rbi"))
      expect(File).to(exist("#{outdir}/bar@0.3.0.rbi"))

      expect(File.read("#{outdir}/foo@0.0.1.rbi")).to(eq(FOO_RBI_CONTENTS))
      expect(File.read("#{outdir}/bar@0.3.0.rbi")).to(eq(BAR_RBI_CONTENTS))

      expect(File).to_not(exist("#{outdir}/baz@0.0.2.rbi"))
    end

    it 'must generate RBIs for all gems in the Gemfile' do
      output = run("generate")

      expect(output).to(include(<<~OUTPUT))
        Processing 'bar' gem:
          Compiling bar, this may take a few seconds...   Done
      OUTPUT

      expect(output).to(include(<<~OUTPUT))
        Processing 'baz' gem:
          Compiling baz, this may take a few seconds...   Done
      OUTPUT

      expect(output).to(include(<<~OUTPUT))
        Processing 'foo' gem:
          Compiling foo, this may take a few seconds...   Done
      OUTPUT

      expect(File).to(exist("#{outdir}/foo@0.0.1.rbi"))
      expect(File).to(exist("#{outdir}/bar@0.3.0.rbi"))
      expect(File).to(exist("#{outdir}/baz@0.0.2.rbi"))

      expect(File.read("#{outdir}/foo@0.0.1.rbi")).to(eq(FOO_RBI_CONTENTS))
      expect(File.read("#{outdir}/bar@0.3.0.rbi")).to(eq(BAR_RBI_CONTENTS))
      expect(File.read("#{outdir}/baz@0.0.2.rbi")).to(eq(BAZ_RBI_CONTENTS))
    end
  end

  describe("#bundle") do
    it 'must perform no operations if everything is up-to-date' do
      run("generate")

      output = run("bundle")

      expect(output).to_not(include("-- Removing:"))
      expect(output).to_not(include("++ Adding:"))
      expect(output).to_not(include("-> Moving:"))

      expect(output).to(include(<<~OUTPUT))
        Removing RBI files of gems that have been removed:

          Nothing to do.
      OUTPUT
      expect(output).to(include(<<~OUTPUT))
        Generating RBI files of gems that are added or updated:

          Nothing to do.
      OUTPUT

      expect(File).to(exist("#{outdir}/foo@0.0.1.rbi"))
      expect(File).to(exist("#{outdir}/bar@0.3.0.rbi"))
      expect(File).to(exist("#{outdir}/baz@0.0.2.rbi"))
    end

    it 'must remove outdated RBIs' do
      run("generate")
      FileUtils.touch("#{outdir}/outdated@5.0.0.rbi")

      output = run("bundle")

      expect(output).to(include("-- Removing: #{outdir}/outdated@5.0.0.rbi\n"))
      expect(output).to_not(include("++ Adding:"))
      expect(output).to_not(include("-> Moving:"))

      expect(output).to(include(<<~OUTPUT))
        Generating RBI files of gems that are added or updated:

          Nothing to do.
      OUTPUT

      expect(File).to(exist("#{outdir}/foo@0.0.1.rbi"))
      expect(File).to(exist("#{outdir}/bar@0.3.0.rbi"))
      expect(File).to(exist("#{outdir}/baz@0.0.2.rbi"))
      expect(File).to_not(exist("#{outdir}/outdated@5.0.0.rbi"))
    end

    it 'must add missing RBIs' do
      %w{
        foo@0.0.1.rbi
      }.each do |rbi|
        FileUtils.touch("#{outdir}/#{rbi}")
      end

      output = run("bundle")

      expect(output).to(include("++ Adding: #{outdir}/bar@0.3.0.rbi\n"))
      expect(output).to(include("++ Adding: #{outdir}/baz@0.0.2.rbi\n"))
      expect(output).to_not(include("-- Removing:"))
      expect(output).to_not(include("-> Moving:"))

      expect(output).to(include(<<~OUTPUT))
        Removing RBI files of gems that have been removed:

          Nothing to do.
      OUTPUT

      expect(File).to(exist("#{outdir}/foo@0.0.1.rbi"))
      expect(File).to(exist("#{outdir}/bar@0.3.0.rbi"))
      expect(File).to(exist("#{outdir}/baz@0.0.2.rbi"))
    end

    it 'must move outdated RBIs' do
      %w{
        foo@0.0.1.rbi
        bar@0.0.1.rbi
        baz@0.0.1.rbi
      }.each do |rbi|
        FileUtils.touch("#{outdir}/#{rbi}")
      end

      output = run("bundle")

      expect(output).to(include("-> Moving: #{outdir}/bar@0.0.1.rbi to #{outdir}/bar@0.3.0.rbi\n"))
      expect(output).to(include("++ Adding: #{outdir}/bar@0.3.0.rbi\n"))
      expect(output).to(include("-> Moving: #{outdir}/baz@0.0.1.rbi to #{outdir}/baz@0.0.2.rbi\n"))
      expect(output).to(include("++ Adding: #{outdir}/baz@0.0.2.rbi\n"))
      expect(output).to_not(include("-- Removing:"))

      expect(output).to(include(<<~OUTPUT))
        Removing RBI files of gems that have been removed:

          Nothing to do.
      OUTPUT

      expect(File).to(exist("#{outdir}/foo@0.0.1.rbi"))
      expect(File).to(exist("#{outdir}/bar@0.3.0.rbi"))
      expect(File).to(exist("#{outdir}/baz@0.0.2.rbi"))

      expect(File).to_not(exist("#{outdir}/bar@0.0.1.rbi"))
      expect(File).to_not(exist("#{outdir}/baz@0.0.1.rbi"))
    end
  end
end

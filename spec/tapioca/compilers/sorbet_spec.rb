# typed: strict
# frozen_string_literal: true

require "spec_helper"

class Tapioca::Compilers::SorbetSpec < Minitest::Spec
  def with_custom_sorbet_exe_path(path, &block)
    sorbet_exe_env_value = ENV["TAPIOCA_SORBET_EXE"]
    begin
      ENV["TAPIOCA_SORBET_EXE"] = path
      block.call(path)
    ensure
      ENV["TAPIOCA_SORBET_EXE"] = sorbet_exe_env_value
    end
  end

  it("returns the value of TAPIOCA_SORBET_EXE if set") do
    with_custom_sorbet_exe_path("bin/custom-sorbet-static") do |custom_path|
      assert_equal(Tapioca::Compilers::Sorbet.sorbet_path, custom_path)
    end
  end

  it("returns the default sorbet path if TAPIOCA_SORBET_EXE is empty") do
    default_path = Tapioca::Compilers::Sorbet::SORBET.to_s.shellescape
    with_custom_sorbet_exe_path("") do
      assert_equal(Tapioca::Compilers::Sorbet.sorbet_path, default_path)
    end
  end
end

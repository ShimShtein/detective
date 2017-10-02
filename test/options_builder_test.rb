# frozen_string_literal: true

require 'test_helper'
require 'detective/options_builder'

class LauncherTest < Minitest::Test
  # rubocop:disable Metrics/MethodLength
  def test_builds_options_for_input
    builder = Detective::OptionsBuilder.new(
      content: 'test content',
      filename: 'test_file.rb'
    )

    old_stdin = $stdin

    builder.generate do |params|
      refute_equal old_stdin, $stdin
      assert_equal '-s', params[0]
      assert_equal 'test_file.rb', params[1]
      assert_equal 'test content', $stdin.binmode.read
    end

    assert_equal old_stdin, $stdin
  end

  def test_builds_options_for_empty_output
    builder = Detective::OptionsBuilder.new

    old_stdout = $stdout

    builder.generate do |params, output|
      refute_equal old_stdout, $stdout
      assert_equal '-f', params[0]
      assert_equal 'j', params[1]
      assert output.is_a?(StringIO)
    end

    assert_equal old_stdout, $stdout
  end

  def test_builds_options_for_specified_output
    expected_output = StringIO.new
    builder = Detective::OptionsBuilder.new(output: expected_output)

    old_stdout = $stdout

    builder.generate do |params, output|
      refute_equal old_stdout, $stdout
      assert_equal '-f', params[0]
      assert_equal 'j', params[1]
      assert_equal expected_output, output
    end

    assert_equal old_stdout, $stdout
  end

  def test_builds_options_for_cops_list
    builder = Detective::OptionsBuilder.new(cops: ['a/b', 'd/e'])

    builder.generate do |params, _output|
      assert_equal '--only', params[0]
      assert_equal 'a/b,d/e', params[1]
    end
  end
end

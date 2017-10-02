# frozen_string_literal: true

require 'test_helper'
require 'detective/launcher'

class LauncherTest < Minitest::Test
  def setup
    @test_cops_folder = File.expand_path(
      File.dirname(__FILE__) + '/cops/**/*.rb'
    )
  end

  def test_shows_all_cops
    launcher = Detective::Launcher.new(cops_patterns: [@test_cops_folder])
    actual_cops = launcher.cops

    assert_includes actual_cops, RuboCop::Cop::Detective::AlwaysFail
  end

  # rubocop:disable Metrics/MethodLength
  def test_runs_selected_cops
    launcher = Detective::Launcher.new(cops_patterns: [@test_cops_folder])
    actual_output = launcher.run(
      cops_list: ['Detective/AlwaysFail'],
      content: 'bleh',
      filename: 'bleh.rb'
    )
    actual_json = JSON.parse(actual_output)

    assert_equal(
      'Detective/AlwaysFail',
      actual_json['files'][0]['offenses'][0]['cop_name']
    )
  end
end

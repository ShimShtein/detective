# frozen_string_literal: true

begin
  require 'pry'
# rubocop:disable Lint/HandleExceptions
rescue
  # suppress not loading pry for environments without it
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'detective'

require 'minitest/autorun'

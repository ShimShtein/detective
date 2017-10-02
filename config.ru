# frozen_string_literal: true

begin
  require 'pry'
# rubocop:disable Lint/HandleExceptions
rescue
  # suppress not loading pry for environments without it
end

require 'detective/web/endpoint'

run Detective::Web::Endpoint.new

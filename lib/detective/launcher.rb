# frozen_string_literal: true

require 'rubocop'
require_relative 'options_builder'

module Detective
  # Wrapper around Rubocop::CLI to enble support for custom cops folders and
  # erb support.
  class Launcher
    def initialize(cops_patterns: [])
      @cops_files = cops_patterns.map { |pattern| Dir[pattern] }.flatten
      require_cops(@cops_files)
    end

    # rubocop:disable Metrics/MethodLength
    def run(cops_list: [], output: nil, content: nil, filename: nil)
      cops_list ||= []
      runner = RuboCop::CLI.new
      options_builder = OptionsBuilder.new(
        content: content,
        filename: filename,
        output: output,
        cops: cops_list
      )

      options_builder.generate do |params, result|
        runner.run params
        result.rewind
        output = result.read unless output
      end

      output
    end

    def cops
      @cops ||= begin
        RuboCop::Cop::Cop.registry.cops
      end
    end

    private

    def require_cops(cops_files)
      cops_files.each do |cop_file|
        require cop_file
      end
    end
  end
end

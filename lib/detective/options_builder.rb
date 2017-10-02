# frozen_string_literal: true

module Detective
  # Generates params array to be passed to rubocop's CLI.
  # handles cleanup if options generated temporary objects
  class OptionsBuilder
    attr_reader :options

    def initialize(options_hash = {})
      @options = options_hash
      @cleanup_callbacks = []
    end

    def generate
      params = []

      params.concat(handle_input(options[:content], options[:filename]))
      params.concat(handle_cops_list(options[:cops]))

      out_params, output = handle_output(options[:output])
      params.concat(out_params)

      yield(params, output)
    ensure
      cleanup
    end

    private

    def handle_input(content, filename)
      return [] unless content && filename
      # redirect $stdin to read the contents of content parameter
      @old_stdin = $stdin
      $stdin = StringIO.new(content)

      @cleanup_callbacks << -> { $stdin = @old_stdin }

      ['-s', filename]
    end

    def handle_output(output)
      output ||= StringIO.new

      # redirect $stdout to new stringIO object
      @old_stdout = $stdout
      $stdout = output

      @cleanup_callbacks << -> { $stdout = @old_stdout }
      [['-f', 'j'], output]
    end

    def handle_cops_list(cops = nil)
      return [] unless cops

      ['--only', cops.join(',')]
    end

    def cleanup
      @cleanup_callbacks.each(&:call)
      @cleanup_callbacks = []
    end
  end
end

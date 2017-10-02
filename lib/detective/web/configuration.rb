# frozen_string_literal: true

require_relative '../launcher'

module Detective
  module Web
    # This is factory class responsible for constructing launcher with
    # predefined options.
    module Configuration
      # This module would be included as helper in the application
      module Helpers
        def launcher
          @instance ||= begin
            cops_patterns = []
            if settings.method_defined? :cops_patterns
              cops_patterns = settings.cops_patterns
            end
            Detective::Launcher.new(cops_patterns: cops_patterns)
          end
        end

        def cops_patterns
          @cops_patterns ||= []
        end
      end

      def self.registered(app)
        app.helpers Helpers
      end
    end
  end
end

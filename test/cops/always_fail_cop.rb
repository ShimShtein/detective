# frozen_string_literal: true

module RuboCop
  module Cop
    module Detective
      # This cop checks for calls to foreman_url without params
      class AlwaysFail < Cop
        MSG = 'Test cop always fails'

        def investigate(source)
          add_offense(source.ast, source.ast.source_range, MSG)
        end
      end
    end
  end
end

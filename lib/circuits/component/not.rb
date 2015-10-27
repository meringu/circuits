require 'circuits/component/base'

module Circuits
  module Component
    # Logical NOT Operator
    class Not < Base
      def initialize(opts = {})
        @input_count = 1
        @output_count = 1
        super opts
      end

      # Sets the output to be the result of a logical NOT of the inputs
      def tick
        self[:out].set(!self[:in].get)
      end
    end
  end
end

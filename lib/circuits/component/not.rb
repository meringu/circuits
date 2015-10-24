require 'circuits/component'

module Circuits
  module Component
    # Logical NOT Operator
    class Not
      include Component

      # Sets the output to be the result of a logical NOT of the inputs
      def tick
        outputs[0].set(!inputs[0].get)
      end

      private

      def set_defaults
        @input_count = 1
        @output_count = 1
      end
    end
  end
end

require 'circuits/component'

module Circuits
  module Component
    # Logical XOR Operator
    class Xor
      include Component

      # Sets the output to be the result of a logical XOR of the inputs
      def tick
        outputs[0].set(inputs.map(&:get).inject(:^))
      end

      private

      def set_defaults
        @input_count = 2
        @output_count = 1
      end
    end
  end
end

require 'circuits/component'

module Circuits
  module Component
    # Logical XNOR Operator
    class Xnor
      include Component

      def input_count
        2
      end

      def output_count
        1
      end

      def tick
        outputs[0].set(inputs[0].get == inputs[1].get)
      end
    end
  end
end

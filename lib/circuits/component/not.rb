require 'circuits/component'

module Circuits
  module Component
    # Logical NOT Operator
    class Not
      include Component

      def input_count
        1
      end

      def output_count
        1
      end

      def tick
        outputs[0].set(!inputs[0].get)
      end
    end
  end
end

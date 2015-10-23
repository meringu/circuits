require 'circuits/component'

module Circuits
  module Component
    # Logical OR Operator
    class Or
      include Component

      # Sets the output to be the result of a logical OR of the inputs
      def tick
        outputs[0].set(inputs.map(&:get).inject(:|))
      end

      private

      def input_count
        2
      end

      def output_count
        1
      end
    end
  end
end

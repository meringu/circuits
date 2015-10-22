require 'circuits/component'

module Circuits
  module Component
    # Logical NAND Operator
    class Nand
      include Component

      def input_count
        2
      end

      def output_count
        1
      end

      def tick
        outputs[0].set(!inputs.map(&:get).inject(:&))
      end
    end
  end
end

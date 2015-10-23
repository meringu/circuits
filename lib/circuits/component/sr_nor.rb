require 'circuits/component'

module Circuits
  module Component
    # SR NOR Latch
    class SrNor
      include Component

      # Computes the outputs based on the inputs and previous state
      def tick
        2.times.each do
          sub_components.each(&:tick)
          sub_components.each(&:tock)
        end
        outputs[0].set nor_1.outputs[0].get
        outputs[1].set nor_2.outputs[0].get
      end

      private

      attr_reader :nor_1, :nor_2, :sub_components

      def input_count
        2
      end

      def output_count
        2
      end

      def setup
        @nor_1 = Nor.new(inputs: [inputs[0]])
        @nor_2 = Nor.new(inputs: [inputs[1]])
        @sub_components = [@nor_1, @nor_2]
        nor_1.inputs << nor_2.outputs[0]
        nor_2.inputs << nor_1.outputs[0]
      end
    end
  end
end

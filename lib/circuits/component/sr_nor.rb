require 'circuits/component'

module Circuits
  module Component
    # SR NOR Latch
    class SrNor
      include Component

      # Computes the outputs based on the inputs and previous state
      def tick
        update_internal_components
        self[:q].set nor_1[:out].get
        self[:not_q].set nor_2[:out].get
      end

      private

      attr_reader :nor_1, :nor_2, :sub_components

      def create_internal_components
        @nor_1 = Nor.new
        @nor_2 = Nor.new
        @sub_components = [@nor_1, @nor_2]
      end

      def link_internal_components
        nor_1[:a] = self[:r]
        nor_2[:a] = self[:s]
        nor_1[:b] = nor_2[:out]
        nor_2[:b] = nor_1[:out]
      end

      def set_defaults
        @input_count = 2
        @output_count = 2
        @port_mappings = {
          r: { type: :input, number: 0 },
          s: { type: :input, number: 1 },
          q: { type: :output, number: 0 },
          not_q: { type: :output, number: 1 }
        }
      end

      def setup
        create_internal_components
        link_internal_components
      end

      def update_internal_components
        2.times.each do
          sub_components.each(&:tick)
          sub_components.each(&:tock)
        end
      end
    end
  end
end

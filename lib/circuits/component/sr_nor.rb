require 'circuits/component/base'

module Circuits
  module Component
    # SR NOR Latch
    class SrNor < Base
      def initialize(opts = {})
        set_defaults
        super opts
        create_sub_components
        link_sub_components
        self[:q].set nor_1[:out]
        self[:not_q].set nor_2[:out]
      end

      # Computes the outputs based on the inputs and previous state
      def tick
        2.times.each do
          sub_components.each(&:tick)
          sub_components.each(&:tock)
        end
      end

      private

      attr_reader :nor_1, :nor_2, :sub_components

      def create_sub_components
        @nor_1 = Nor.new
        @nor_2 = Nor.new
        @sub_components = [@nor_1, @nor_2]
      end

      def link_sub_components
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
    end
  end
end

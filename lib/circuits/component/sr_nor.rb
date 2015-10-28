require 'circuits/component/base'
require 'circuits/component/nor'

module Circuits
  module Component
    # SR NOR Latch
    class SrNor < Base
      def initialize
        super(port_mappings: { r: { type: :input, number: 0 },
                               s: { type: :input, number: 1 },
                               q: { type: :output, number: 0 },
                               not_q: { type: :output, number: 1 } })
        create_sub_components
        link_inputs
        link_outputs
        link_sub_components
      end

      # Computes the outputs based on the inputs and previous state
      def tick
        2.times.each do
          sub_components.each(&:tick)
          sub_components.each(&:tock)
        end
      end

      private

      attr_reader :nor_r, :nor_s, :sub_components

      def create_sub_components
        @nor_r = Nor.new
        @nor_s = Nor.new
        @sub_components = [@nor_r, @nor_s]
      end

      def default_input_count
        2
      end

      def default_output_count
        2
      end

      def link_inputs
        nor_r[:a].set self[:r]
        nor_s[:a].set self[:s]
      end

      def link_outputs
        self[:q].set nor_r[:out]
        self[:not_q].set nor_s[:out]
      end

      def link_sub_components
        nor_r[:b].set nor_s[:out]
        nor_s[:b].set nor_r[:out]
      end
    end
  end
end

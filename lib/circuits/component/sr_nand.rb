require 'circuits/component/base'
require 'circuits/component/nand'

module Circuits
  module Component
    # SR NAND Latch
    class SrNand < Base
      def initialize
        super(port_mappings: { not_s: { type: :input, number: 0 },
                               not_r: { type: :input, number: 1 },
                               q: { type: :output, number: 0 },
                               not_q: { type: :output, number: 1 } })
        create_sub_components
        link_sub_components
        reset
      end

      # Computes the outputs based on the inputs and previous state
      def tick
        2.times.each do
          sub_components.each(&:tick)
          sub_components.each(&:tock)
        end
      end

      private

      attr_reader :nand_s, :nand_r, :sub_components

      def create_sub_components
        @nand_s = Nand.new
        @nand_r = Nand.new
        @sub_components = [@nand_s, @nand_r]
      end

      def default_input_count
        2
      end

      def default_output_count
        2
      end

      def link_nand_r
        nand_r[:a].set self[:not_r]
        nand_r[:b].set nand_s[:out]
      end

      def link_nand_s
        nand_s[:a].set self[:not_s]
        nand_s[:b].set nand_r[:out]
      end

      def link_outputs
        self[:q].set nand_s[:out]
        self[:not_q].set nand_r[:out]
      end

      def link_sub_components
        link_nand_s
        link_nand_r
        link_outputs
      end

      def reset
        self[:not_s].set true
        tick
        tock
        self[:not_r].set true
      end
    end
  end
end

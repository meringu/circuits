require 'circuits/component/base'
require 'circuits/component/sr_nand'
require 'circuits/component/and'
require 'circuits/component/nand'

module Circuits
  module Component
    # Positive edge triggered D-type flip flop
    class D < Base
      def initialize
        super(port_mappings: { d: { type: :input, number: 0 },
                               clk: { type: :input, number: 1 },
                               q: { type: :output, number: 0 },
                               not_q: { type: :output, number: 1 } })
        create_sub_components
        link_sub_components
        reset
      end

      # Computes the outputs based on the inputs and previous state
      def tick
        3.times.each do
          sub_components.each(&:tick)
          sub_components.each(&:tock)
        end
      end

      private

      attr_reader :and_gate, :sr_nand_clk, :sr_nand_d, :sr_nand_out,
                  :sub_components

      def create_sub_components
        @and_gate = Circuits::Component::And.new
        @sr_nand_clk = Circuits::Component::SrNand.new
        @sr_nand_d = Circuits::Component::SrNand.new
        @sr_nand_out = Circuits::Component::SrNand.new
        @sub_components = [@and_gate, @sr_nand_clk, @sr_nand_d, @sr_nand_out]
      end

      def default_input_count
        2
      end

      def default_output_count
        2
      end

      def link_and_gate
        and_gate[:a].set sr_nand_clk[:not_q]
        and_gate[:b].set self[:clk]
      end

      def link_outputs
        self[:q].set sr_nand_out[:q]
        self[:not_q].set sr_nand_out[:not_q]
      end

      def link_sr_nand_d
        sr_nand_d[:not_s].set and_gate[:out]
        sr_nand_d[:not_r].set self[:d]
      end

      def link_sr_nand_clk
        sr_nand_clk[:not_s].set sr_nand_d[:not_q]
        sr_nand_clk[:not_r].set self[:clk]
      end

      def link_sr_nand_out
        sr_nand_out[:not_s].set sr_nand_clk[:not_q]
        sr_nand_out[:not_r].set sr_nand_d[:q]
      end

      def link_sub_components
        link_outputs
        link_and_gate
        link_sr_nand_d
        link_sr_nand_clk
        link_sr_nand_out
      end

      def reset
        tick
        tock
      end
    end
  end
end

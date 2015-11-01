require 'circuits/component/base'
require 'circuits/component/and'
require 'circuits/component/sr_nand'

module Circuits
  module Component
    # Positive edge triggered D-type flip flop
    class D < Base
      def initialize
        sub_components = create_sub_components
        super(inputs: [:d, :clk], outputs: [:q, :not_q],
              sub_components: sub_components.map { |_, v| v },
              ticks: 4)
        link sub_components
        reset
      end

      private

      def create_sub_components
        {
          and_gate: Circuits::Component::And.new,
          sr_nand_clk: Circuits::Component::SrNand.new,
          sr_nand_d: Circuits::Component::SrNand.new,
          sr_nand_out: Circuits::Component::SrNand.new
        }
      end

      def link(sub_components)
        link_and_gate sub_components
        link_sr_nand_clk sub_components
        link_sr_nand_d sub_components
        link_sr_nand_out sub_components
        q.set sub_components[:sr_nand_out].q
        not_q.set sub_components[:sr_nand_out].not_q
      end

      def link_and_gate(sc)
        sc[:and_gate].a.set sc[:sr_nand_clk].not_q
        sc[:and_gate].b.set clk
      end

      def link_sr_nand_clk(sc)
        sc[:sr_nand_clk].not_s.set sc[:sr_nand_d].not_q
        sc[:sr_nand_clk].not_r.set clk
      end

      def link_sr_nand_d(sc)
        sc[:sr_nand_d].not_s.set sc[:and_gate].out
        sc[:sr_nand_d].not_r.set d
      end

      def link_sr_nand_out(sc)
        sc[:sr_nand_out].not_s.set sc[:sr_nand_clk].not_q
        sc[:sr_nand_out].not_r.set sc[:sr_nand_d].q
      end

      def reset
        tick
        tock
      end
    end
  end
end

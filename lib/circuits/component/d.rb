# frozen_string_literal: true

require 'circuits/component/base'
require 'circuits/component/and'
require 'circuits/component/sr_nand'

module Circuits
  module Component
    # Positive edge triggered D-type flip flop
    class D < Base
      def initialize
        sub_components = create_sub_components
        super(inputs: %i[d clk], outputs: %i[q not_q],
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

      def link_and_gate(scs)
        scs[:and_gate].a.set scs[:sr_nand_clk].not_q
        scs[:and_gate].b.set clk
      end

      def link_sr_nand_clk(scs)
        scs[:sr_nand_clk].not_s.set scs[:sr_nand_d].not_q
        scs[:sr_nand_clk].not_r.set clk
      end

      def link_sr_nand_d(scs)
        scs[:sr_nand_d].not_s.set scs[:and_gate].out
        scs[:sr_nand_d].not_r.set d
      end

      def link_sr_nand_out(scs)
        scs[:sr_nand_out].not_s.set scs[:sr_nand_clk].not_q
        scs[:sr_nand_out].not_r.set scs[:sr_nand_d].q
      end

      def reset
        tick
        tock
      end
    end
  end
end

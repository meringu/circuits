# frozen_string_literal: true

require 'circuits/component/base'
require 'circuits/component/half_adder'
require 'circuits/component/or'

module Circuits
  module Component
    # Full 1-bit Adder
    class FullAdder < Base
      def initialize
        sub_components = create_sub_components
        super(inputs: %i[a b c_in],
              outputs: %i[s c_out],
              sub_components: sub_components.map { |_, v| v },
              ticks: 3)
        link sub_components
      end

      private

      def create_sub_components
        {
          half_adder_in: HalfAdder.new,
          half_adder_carry: HalfAdder.new,
          or_gate: Or.new
        }
      end

      def link(sub_components)
        link_half_adder_in sub_components
        link_half_adder_carry sub_components
        link_or_gate sub_components
        link_outputs sub_components
      end

      def link_half_adder_in(sub_components)
        sub_components[:half_adder_in].a.set a
        sub_components[:half_adder_in].b.set b
      end

      def link_half_adder_carry(sub_components)
        sub_components[:half_adder_carry].a.set sub_components[:half_adder_in].s
        sub_components[:half_adder_carry].b.set c_in
      end

      def link_or_gate(sub_components)
        sub_components[:or_gate].a.set sub_components[:half_adder_carry].c_out
        sub_components[:or_gate].b.set sub_components[:half_adder_in].c_out
      end

      def link_outputs(sub_components)
        s.set sub_components[:half_adder_carry].s
        c_out.set sub_components[:or_gate].out
      end
    end
  end
end

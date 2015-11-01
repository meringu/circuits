require 'circuits/component/base'
require 'circuits/component/and'
require 'circuits/component/or'
require 'circuits/component/xor'

module Circuits
  module Component
    # Full 1-bit Adder
    class FullAdder < Base
      def initialize
        sub_components = create_sub_components
        super(inputs: [:a, :b, :c_in],
              outputs: [:s, :c_out],
              sub_components: sub_components.map { |_, v| v },
              ticks: 3)
        link sub_components
      end

      private

      def create_sub_components
        {
          and_in: And.new,
          and_carry: And.new,
          or_gate: Or.new,
          xor_in: Xor.new,
          xor_out: Xor.new
        }
      end

      def link(sub_components)
        link_and_in sub_components
        link_and_carry sub_components
        link_or_gate sub_components
        link_xor_in sub_components
        link_xor_out sub_components
        link_outputs sub_components
      end

      def link_and_in(sub_components)
        sub_components[:and_in].a.set a
        sub_components[:and_in].b.set b
      end

      def link_and_carry(sub_components)
        sub_components[:and_carry].a.set sub_components[:xor_in].out
        sub_components[:and_carry].b.set c_in
      end

      def link_or_gate(sub_components)
        sub_components[:or_gate].a.set sub_components[:and_in].out
        sub_components[:or_gate].b.set sub_components[:and_carry].out
      end

      def link_xor_in(sub_components)
        sub_components[:xor_in].a.set a
        sub_components[:xor_in].b.set b
      end

      def link_xor_out(sub_components)
        sub_components[:xor_out].a.set sub_components[:xor_in].out
        sub_components[:xor_out].b.set c_in
      end

      def link_outputs(sub_components)
        s.set sub_components[:xor_out].out
        c_out.set sub_components[:or_gate].out
      end
    end
  end
end

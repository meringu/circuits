# frozen_string_literal: true

require 'circuits/component/base'
require 'circuits/component/and'
require 'circuits/component/xor'

module Circuits
  module Component
    # Half 1-bit Adder
    class HalfAdder < Base
      def initialize
        and_gate = And.new
        xor_gate = Xor.new
        super(inputs: 2,
              outputs: %i[s c_out],
              sub_components: [and_gate, xor_gate],
              ticks: 1)
        link_internals and_gate, xor_gate
        link_outputs and_gate, xor_gate
      end

      private

      def link_internals(and_gate, xor_gate)
        and_gate.a.set a
        and_gate.b.set b
        xor_gate.a.set a
        xor_gate.b.set b
      end

      def link_outputs(and_gate, xor_gate)
        s.set xor_gate.out
        c_out.set and_gate.out
      end
    end
  end
end

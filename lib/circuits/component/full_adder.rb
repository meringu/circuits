require 'circuits/component/base'
require 'circuits/component/and'
require 'circuits/component/or'
require 'circuits/component/xor'

module Circuits
  module Component
    # Full 1-bit Adder
    class FullAdder < Base
      def initialize
        and_in = And.new
        and_carry = And.new
        or_gate = Or.new
        xor_in = Xor.new
        xor_out = Xor.new
        super(inputs: [:a, :b, :c_in],
              outputs: [:s, :c_out],
              sub_components: [and_in, and_carry, or_gate, xor_in, xor_out],
              ticks: 3)
        link and_in, and_carry, or_gate, xor_in, xor_out
      end

      private

      def link(and_in, and_carry, or_gate, xor_in, xor_out)
        and_in.a.set a
        and_in.b.set b

        and_carry.a.set xor_in.out
        and_carry.b.set c_in

        or_gate.a.set and_in.out
        or_gate.b.set and_carry.out

        xor_in.a.set a
        xor_in.b.set b

        xor_out.a.set xor_in.out
        xor_out.b.set c_in

        s.set xor_out.out
        c_out.set or_gate.out
      end
    end
  end
end

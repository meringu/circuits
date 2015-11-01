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
              outputs: [:s, :c],
              sub_components: [and_gate, xor_gate],
              ticks: 1)
        link and_gate, xor_gate
      end

      private

      def link(and_gate, xor_gate)
        and_gate.a.set a
        and_gate.b.set b
        xor_gate.a.set a
        xor_gate.b.set b
        s.set xor_gate.out
        c.set and_gate.out
      end
    end
  end
end

# frozen_string_literal: true

require 'circuits/component/base'
require 'circuits/component/nand'

module Circuits
  module Component
    # SR NAND Latch
    class SrNand < Base
      def initialize
        nand_s = Nand.new
        nand_r = Nand.new
        super(inputs: %i[not_s not_r],
              outputs: %i[q not_q],
              sub_components: [nand_s, nand_r],
              ticks: 2)
        link nand_s, nand_r
        reset
      end

      private

      def link(nand_s, nand_r)
        link_nand_s nand_s, nand_r
        link_nand_r nand_s, nand_r
        q.set nand_s.out
        not_q.set nand_r.out
      end

      def link_nand_s(nand_s, nand_r)
        nand_s.a.set not_s
        nand_s.b.set nand_r.out
      end

      def link_nand_r(nand_s, nand_r)
        nand_r.a.set not_r
        nand_r.b.set nand_s.out
      end

      def reset
        not_s.set true
        tick
        tock
        not_r.set true
      end
    end
  end
end

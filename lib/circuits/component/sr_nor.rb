require 'circuits/component/base'
require 'circuits/component/nor'

module Circuits
  module Component
    # SR NOR Latch
    class SrNor < Base
      def initialize
        nor_s = Nor.new
        nor_r = Nor.new
        super(inputs: [:r, :s],
              outputs: [:q, :not_q],
              sub_components: [nor_s, nor_r],
              ticks: 2)
        link nor_s, nor_r
        reset
      end

      private

      def link(nor_s, nor_r)
        link_nor_s nor_s, nor_r
        link_nor_r nor_s, nor_r
        q.set nor_r.out
        not_q.set nor_s.out
      end

      def link_nor_s(nor_s, nor_r)
        nor_s.a.set s
        nor_s.b.set nor_r.out
      end

      def link_nor_r(nor_s, nor_r)
        nor_r.a.set r
        nor_r.b.set nor_s.out
      end

      def reset
        r.set true
        tick
        tock
        r.set false
      end
    end
  end
end

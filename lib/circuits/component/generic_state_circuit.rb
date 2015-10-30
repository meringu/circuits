require 'circuits/component/base'
require 'circuits/component/and'
require 'circuits/component/or'
require 'circuits/component/d'
require 'circuits/component/not'

module Circuits
  module Component
    class GenericStateCircuit < Base

      def initialize
        super(port_mappings: { i: { type: :input, number: 0 },
                               out: { type: :output, number: 0 } })
        @ands = []
        @ors = []
        @nots = []
        @states = []
      end

      def set_number_of_ands number
        @ands = []
        number.times.each do |_|
          @ands << And.new
        end
      end

      def set_number_of_ors number
        @ors = []
        number.times.each do |_|
          @ors << Or.new
        end
      end

      def set_number_of_states number
        @states = []
        number.times.each do |_|
          @states << D.new
        end
      end

      def set_number_of_nots number
        @nots = []
        number.times.each do |_|
          @nots << Not.new
        end
      end

      def get_and number 
        @ands[number]
      end

        def get_or number 
        @ors[number]
      end

        def get_state number 
        @states[number]
      end

      def get_not number 
        @nots[number]
      end

      def tick
        tick_internal

        @states.each do |s|
          s.clk.set true
        end
        tick_internal

        @states.each do |s|
          s.clk.set false
        end
        tick_internal
      end

      def tick_internal
        number_of_inputs = 0
        number_of_inputs += @ands.length
        number_of_inputs += @ors.length
        number_of_inputs += @nots.length
        number_of_inputs.times.each do |_|
          @ands.each(&:tick)
          @ors.each(&:tick)
          @nots.each(&:tick)
          @states.each(&:tick)
          @states.each(&:tock)
          @ands.each(&:tock)
          @ors.each(&:tock)
          @nots.each(&:tock)
        end
      end
      private

      def default_input_count
        1
      end

      def default_output_count
        1
      end  
    end
  end
end
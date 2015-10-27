require 'circuits/component/base'

module Circuits
  module Component
    # Logical AND Operator
    class And < Base
      def initialize(opts = {})
        @input_count = 2
        @output_count = 1
        super opts
      end

      # Sets the output to be the result of a logical AND of the inputs
      def tick
        self[:out].set(inputs.map(&:get).inject(:&))
      end
    end
  end
end

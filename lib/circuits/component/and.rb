require 'circuits/component/base'

module Circuits
  module Component
    # Logical AND Operator
    class And < Base
      # Sets the output to be the result of a logical AND of the inputs
      def tick
        self[:out].set(inputs.map(&:get).inject(:&))
      end

      private

      def default_input_count
        2
      end

      def default_output_count
        1
      end
    end
  end
end

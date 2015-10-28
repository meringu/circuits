require 'circuits/component/base'

module Circuits
  module Component
    # Logical NOT Operator
    class Not < Base
      # Sets the output to be the result of a logical NOT of the inputs
      def tick
        self[:out].set(!self[:in].get)
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

# frozen_string_literal: true

require 'circuits/component/base'

module Circuits
  module Component
    # Logical NOT Operator
    class Not < Base
      def initialize
        super(inputs: 1, outputs: 1)
      end

      # Sets the output to be the result of a logical NOT of the inputs
      def tick
        out.set(!self[:in].get)
      end
    end
  end
end

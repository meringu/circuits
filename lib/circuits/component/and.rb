# frozen_string_literal: true

require 'circuits/component/base'

module Circuits
  module Component
    # Logical AND Operator
    class And < Base
      def initialize(opts = {})
        inputs = opts[:inputs] || 2
        super(inputs: inputs, outputs: 1)
      end

      # Sets the output to be the result of a logical AND of the inputs
      def tick
        self[:out].set(inputs.map(&:get).inject(:&))
      end
    end
  end
end

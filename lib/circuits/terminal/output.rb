require 'circuits/terminal'

module Circuits
  module Terminal
    # Belongs to a single component, gets set for reading by inputs
    class Output
      # Creates the output
      # @param opts [Hash] Options to create the Output with
      # @option opts [Boolean] :state The initial state of the Output
      def initialize(opts = {})
        @next_state = opts[:state] || false
        @state = opts[:state] || false
      end

      # Gets the state of the output
      # @return [Boolean] The state of the output
      def get
        state
      end

      # Saves the state
      # @param [Boolean] s The next desired state of the output
      def set(s)
        @next_state = s
      end

      # Sets the state to be the last state passed by #set
      def tock
        @state = next_state
      end

      private

      attr_reader :state, :next_state
    end
  end
end

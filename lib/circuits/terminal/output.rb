module Circuits
  # An input or an output to read from and set
  module Terminal
    # Gets set tcked then read
    class Output
      # Creates the output
      # @param opts [Hash] Options to create the Output with
      # @option opts [Boolean] :state The initial state of the Output
      # @option opts [Input, Output] :terminal The terminal to read from
      def initialize(opts = {})
        @next_state = opts[:terminal] || opts[:state] || false
        tock
      end

      # Gets the state of the terminal
      # @return [Boolean] The state of the output
      def get
        @state
      end

      # The next state
      # @param [Boolean, Terminal] state The terminal or state to output
      def set(state)
        @next_state = state
      end

      # Sets the state what was last set
      def tock
        if [Input, Output].include? @next_state.class
          @state = @next_state.get
        else
          @state = @next_state
        end
      end
    end
  end
end

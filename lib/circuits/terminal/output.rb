module Circuits
  # An input or an output to read from and set
  module Terminal
    # Gets set tcked then read
    class Output
      # Creates the output
      # @param opts [Hash] Options to create the Output with
      # @option opts [Boolean] :state The initial state of the Output
      def initialize(opts = {})
        @state = @next_state = opts[:state] || false
      end

      # Gets the state of the terminal
      # @return [Boolean] The state of the output
      def get
        return @state if [true, false].include? @state
        @state.get
      end

      # The next state
      # @param [Boolean, Terminal] terminal The terminal or state to output
      def set(state)
        if [true, false].include? state
          @next_state = state
        else
          @next_state = nil
          @state = state
        end
      end

      # Sets the state what was last set
      def tock
        @state = @next_state unless @next_state.nil?
      end
    end
  end
end

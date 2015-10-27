require 'circuits/terminal/output'

module Circuits
  # An input or an output to read from and set
  module Terminal
    # Reads from a single output
    class Input
      # Creates the input
      # @param opts [Hash] Options to create the Input with
      # @option opts [Component::Output] :output The output to read from
      def initialize(opts = {})
        @terminal = opts[:terminal] || Output.new(state: opts[:state])
      end

      # Forward get to the output
      # @return [Boolean] The state of the output
      def get
        @terminal.get
      end

      # Output to use or state to make a dummy output with
      # @param [Output, Boolean] output The output to read from, or state
      def set(output)
        @terminal = output
        @terminal = Output.new(state: output) unless [Input, Output].include? output.class
      end
    end
  end
end

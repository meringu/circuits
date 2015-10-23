require 'circuits/terminal'

module Circuits
  module Terminal
    # Reads from a single output, only assigned to one component
    class Input
      # Creates the input
      # @param opts [Hash] Options to create the Input with
      # @option opts [Component::Output] :output The output to read from
      def initialize(opts = {})
        @output = opts[:output] || Circuits::Terminal::Output.new
      end

      attr_accessor :output

      # Forward get to the output
      # @return [Boolean] The state of the output
      def get
        output.get
      end

      # Create a new output to use
      # @param [Boolean] s The state of the output to create
      def set(s)
        @output = Circuits::Terminal::Output.new(state: s)
      end
    end
  end
end

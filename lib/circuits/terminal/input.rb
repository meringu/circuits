module Circuits
  module Terminal
    # Reads from a single output, only assigned to one component
    class Input
      def initialize(opts = {})
        @output = opts[:output] || Circuits::Terminal::Output.new
      end

      attr_accessor :output

      def get
        output.get
      end

      def set(s)
        @output = Circuits::Terminal::Output.new(state: s)
      end
    end
  end
end

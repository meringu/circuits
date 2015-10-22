module Circuits
  module Terminal
    # Owned by a single component, gets set for reading by inputs
    class Output
      def initialize(opts = {})
        @next_state = opts[:state] || false
        @state = opts[:state] || false
      end

      def get
        state
      end

      def set(s)
        @next_state = s
      end

      def tock
        @state = next_state
      end

      private

      attr_reader :state, :next_state
    end
  end
end

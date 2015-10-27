module Circuits
  # A terminal holds a logical state, it can be attatched to components
  class Terminal
    # Creates the terminal
    # @param opts [Hash] Options to create the Output with
    # @option opts [Boolean] :state The initial state of the Output
    def initialize(opts = {})
      @terminal = opts[:terminal]
      @next_state = opts[:state] || false
      @state = opts[:state] || false
    end

    # Gets the state of the terminal
    # @return [Boolean] The state of the output
    def get
      @state
    end

    # The other terminal to read from next {#tock} or a state to be in now
    # @param [Boolean, Terminal] terminal The terminal or state to output
    def set(terminal)
      if terminal.class == Terminal
        @terminal = terminal
      else
        @terminal = nil
        @state = @next_state = terminal
      end
    end

    # Sets the state to be that of the terminal or state last passed by {#set}
    def tock
      @state = @terminal.nil? ? @next_state : @terminal.get
    end
  end
end

require 'circuits/terminal/input'
require 'circuits/terminal/output'

module Circuits
  # A component has a set of inputs an outputs. Every `tick` a componnent
  # computes its outputs, but the componnent will wait for the `tock` before the
  # componnent updates its own outputs
  module Component
    # Creates the Component with inputs and outputs
    # @param opts [Hash] options to create the Component with
    # @option opts [Array<Input>, FixNum] :inputs The array of inputs to use, or
    #   the number of inputs to create
    def initialize(opts = {})
      @inputs = opts[:inputs] if opts[:inputs].is_a? Array
      @inputs = create_inputs opts[:inputs] if opts[:inputs].is_a? Integer
      @inputs = create_inputs input_count if opts[:inputs].nil?

      @outputs = output_count.times.collect { Circuits::Terminal::Output.new }
      setup
    end

    # Does the internal computation and sets the outputs
    def tick
      fail NotImplementedError
    end

    # Sets all the outputs expose what was set in #tick
    def tock
      outputs.each(&:tock)
    end

    # the inputs of this component
    attr_reader :inputs

    # the outputs of this component
    attr_reader :outputs

    private

    def input_count
      fail NotImplementedError
    end

    def output_count
      fail NotImplementedError
    end

    # Creates an array of N inputs, where N is equal to or greater than the
    #   default number of inputs for this component
    # @param n [FixNum] The number of inputs to create
    # @return [Array<Input>] An array of inputs
    def create_inputs(n)
      if n < input_count
        fail ArgumentError, "Invalid number of inputs, #{self.class} requires at least #{input_count} inputs"
      end
      n.times.collect { Circuits::Terminal::Input.new }
    end

    def setup
    end
  end
end

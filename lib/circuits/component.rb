require 'circuits/terminal/input'
require 'circuits/terminal/output'

module Circuits
  # A component has a set of inputs an outputs. Every `tick` a componnent
  # computes its outputs, but the componnent will wait for the `tock` before the
  # componnent updates its own outputs
  module Component
    # Creates the Component with inputs and outputs
    # @param opts [Hash] options to create the Component with
    # @option opts [Array<Input>] :inputs The array of inputs to use
    def initialize(opts = {})
      @inputs = opts[:inputs] ||
                input_count.times.collect { Circuits::Terminal::Input.new }
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

    def setup
    end
  end
end

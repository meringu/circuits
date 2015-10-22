require 'circuits/terminal/input'
require 'circuits/terminal/output'

module Circuits
  # A component has a set of inputs an outputs. Every `tick` a componnent
  # computes its outputs, but the componnent will wait for the `tock` before the
  # componnent updates its own outputs
  module Component
    def initialize(opts = {})
      @inputs = opts[:inputs] ||
                input_count.times.collect { Circuits::Terminal::Input.new }
      @outputs = output_count.times.collect { Circuits::Terminal::Output.new }
      setup
    end

    attr_reader :inputs, :outputs

    def input_count
      fail NotImplementedError
    end

    def output_count
      fail NotImplementedError
    end

    def setup
    end

    def tick
      fail NotImplementedError
    end

    def tock
      outputs.each(&:tock)
    end
  end
end

require 'circuits/terminal/input'
require 'circuits/terminal/output'

module Circuits
  # A component has a set of inputs an outputs. Every `tick` a componnent
  # computes its outputs, but the componnent will wait for the `tock` before the
  # componnent updates its own outputs
  module Component
    # Base class to extend
    class Base
      # Creates the Component with inputs and outputs
      # @param opts [Hash] options to create the Component with
      # @option opts [FixNum] :input_count The number of inputs
      # @option opts [FixNum] :ouput_count The number of outputs
      # @option opts [Hash] :port_mappings The port_mappings to use
      def initialize(opts = {})
        input_count = opts[:input_count] || default_input_count
        output_count = opts[:output_count] || default_output_count
        @inputs = input_count.times.collect { Circuits::Terminal::Input.new }
        @outputs = output_count.times.collect { Circuits::Terminal::Output.new }
        @port_mappings = opts[:port_mappings] || default_port_mappings
      end

      # the inputs of this component
      attr_reader :inputs

      # the outputs of this component
      attr_reader :outputs

      def method_missing(method_name, *arguments, &block)
        res = self[method_name]
        super if res.nil?
        res
      end

      # Sets all the outputs expose what was set in #tick
      def tock
        outputs.each(&:tock)
      end

      def respond_to_missing?(method_name, include_private = false)
        self[method_name].nil? || super
      end

      # Gets the teminal assigned to the port
      # @param port [Symbol] The symbol that represents the terminal
      # @return [Input, Output] The terminal
      def [](port)
        port_mapping = port_mappings[port]
        port_number = port_mapping[:number]
        case port_mapping[:type]
        when :input
          inputs[port_number]
        when :output
          outputs[port_number]
        end
      end

      private

      attr_reader :port_mappings

      def default_port_mappings
        res = {}
        (input_mappings + output_mappings).each do |mapping|
          res.merge!(mapping)
        end
        res
      end

      def input_mappings
        input_count = inputs.length
        return [{ in: { type: :input, number: 0 } }] if input_count == 1
        input_count.times.collect do |num|
          { num_to_port(num) => { type: :input, number: num } }
        end
      end

      def output_mappings
        output_count = outputs.length
        return[{ out: { type: :output, number: 0 } }] if output_count == 1
        output_count.times.collect do |num|
          { num_to_port(num + inputs.length) => { type: :output, number: num } }
        end
      end

      def num_to_port(num)
        (num + 'a'.ord).chr.to_sym
      end
    end
  end
end

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
      # @option opts [FixNum, Array<Symbol>] :inputs The number of inputs or an
      # array of their names
      # @option opts [FixNum, Array<Symbol>] :ouputs The number of outputs or an
      # array of their names
      # @option opts [Hash] :port_mappings The port_mappings to use
      def initialize(opts = {})
        @inputs = create_inputs opts[:inputs]
        @outputs = create_outputs opts[:outputs]
        @port_mappings = create_port_mappings opts
        @sub_components = opts[:sub_components] || []
        @ticks = opts[:ticks] || 0
        declare_ports_as_methods
      end

      # the inputs of this component
      attr_reader :inputs

      # the outputs of this component
      attr_reader :outputs

      # Computes the outputs based on the inputs and previous state
      def tick
        @ticks.times.each do
          @sub_components.each(&:tick)
          @sub_components.each(&:tock)
        end
      end

      # Sets all the outputs expose what was set in #tick
      def tock
        outputs.each(&:tock)
      end

      # Gets the teminal assigned to the port
      # @param port [Symbol] The symbol that represents the terminal
      # @return [Input, Output] The terminal
      def [](port)
        port_mapping = @port_mappings[port]
        return nil if port_mapping.nil?
        port_number = port_mapping[:number]
        case port_mapping[:type]
        when :input
          inputs[port_number]
        when :output
          outputs[port_number]
        end
      end

      private

      def create_inputs(inputs)
        input_count = inputs.class == Fixnum ? inputs : inputs.length
        input_count.times.map { Circuits::Terminal::Input.new }
      end

      def create_outputs(outputs)
        output_count = outputs.class == Fixnum ? outputs : outputs.length
        output_count.times.map { Circuits::Terminal::Output.new }
      end

      def create_port_mappings(opts = {})
        res = {}
        (input_mappings(opts[:inputs]) +
         output_mappings(opts[:outputs])).each do |mapping|
          res.merge!(mapping)
        end
        res
      end

      def declare_ports_as_methods
        @port_mappings.each do |method, _|
          (class << self; self; end).class_eval do
            define_method method do
              self[method]
            end
          end
        end
      end

      def input_mappings(input_names)
        return default_input_mappings unless input_names.class == Array
        input_names.map.each_with_index do |input_name, num|
          { input_name => { type: :input, number: num } }
        end
      end

      def default_input_mappings
        input_count = inputs.length
        return [{ in: { type: :input, number: 0 } }] if input_count == 1
        input_count.times.collect do |num|
          { num_to_port(num) => { type: :input, number: num } }
        end
      end

      def output_mappings(output_names)
        return default_output_mappings unless output_names.class == Array
        output_names.map.each_with_index do |output_name, num|
          { output_name => { type: :output, number: num } }
        end
      end

      def default_output_mappings
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

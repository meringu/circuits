require 'circuits/terminal'

module Circuits
  # A component has a set of inputs an outputs. Every `tick` a componnent
  # computes its outputs, but the componnent will wait for the `tock` before the
  # componnent updates its own outputs
  module Component
    # Base class to extend
    class Base
      # Creates the Component with inputs and outputs
      # @param opts [Hash] options to create the Component with
      # @option opts [Array<Input>, FixNum] :inputs The array of inputs to use,
      # or the number of inputs to create
      def initialize(opts = {})
        create_inputs opts
        create_outputs opts
      end

      # Does the internal computation and sets the outputs
      def tick
        fail NotImplementedError
      end

      # Sets all the outputs expose what was set in #tick
      def tock
        outputs.each(&:tock)
      end

      # Gets the teminal assigned to the port
      # @param port [Symbol] The symbol that represents the terminal
      # @return [Input, Output] The terminal
      def [](port)
        p = port_mappings[port]
        case p[:type]
        when :input
          inputs[p[:number]]
        when :output
          outputs[p[:number]]
        end
      end

      # Assigns to an input or output
      # @param port [Symbol] The symbol that represents the terminal
      # @param terminal [Input, Output] The terminal to assign
      # @return [Input, Output] The terminal that was passed in
      def []=(port, terminal)
        p = port_mappings[port]
        case p[:type]
        when :input
          inputs[p[:number]] = terminal
        when :output
          outputs[p[:number]] = terminal
        end
      end

      # the inputs of this component
      attr_reader :inputs

      # the outputs of this component
      attr_reader :outputs

      private

      def create_inputs(opts)
        if opts[:inputs].class == Array
          @inputs = opts[:inputs]
          @input_count = @inputs.length
        elsif opts[:inputs].class == Fixnum
          @input_count = opts[:inputs]
        end
        @inputs ||= @input_count.times.collect { Circuits::Terminal.new }
      end

      def create_outputs(opts)
        if opts[:outputs].class == Array
          @outputs = opts[:outputs]
          @output_count = @outputs.length
        elsif opts[:outputs].class == Fixnum
          @output_count = opts[:outputs]
        end
        @outputs ||= @output_count.times.collect do
          Circuits::Terminal.new
        end
      end

      def port_mappings
        return @port_mappings unless @port_mappings.nil?
        @port_mappings = {}
        input_mappings.each { |x| @port_mappings.merge!(x) }
        output_mappings.each { |x| @port_mappings.merge!(x) }
        @port_mappings
      end

      def input_mappings
        return [{ in: { type: :input, number: 0 } }] if @input_count == 1
        @input_count.times.collect do |i|
          { num_to_port(i) => { type: :input, number: i } }
        end
      end

      def output_mappings
        return[{ out: { type: :output, number: 0 } }] if @output_count == 1
        @output_count.times.collect do |i|
          { num_to_port(i + @input_count) => { type: :output, number: i } }
        end
      end

      def num_to_port(i)
        (i + 'a'.ord).chr.to_sym
      end
    end
  end
end

require 'spec_helper'
require 'circuits/component'

# Mock component to include Circuits::Component for function accessability
class MockComponent1
  include Circuits::Component

  def set_defaults
    @input_count = 1
    @output_count = 1
  end
end

# Mock component to include Circuits::Component for function accessability
class MockComponent2
  include Circuits::Component
end

describe Circuits::Component do
  context 'when using defaults' do
    subject { MockComponent1.new }

    it 'has one input' do
      expect(subject.inputs.count).to eq(1)
    end

    it 'has one output' do
      expect(subject.outputs.count).to eq(1)
    end

    describe '#[]=' do
      let(:new_input) { double('new_input') }
      let(:new_output) { double('new_output') }

      before do
        subject[:in] = new_input
        subject[:out] = new_output
      end

      it 'has the new input available as :in' do
        expect(subject[:in]).to eq(new_input)
      end

      it 'has the new output available as :out' do
        expect(subject[:out]).to eq(new_output)
      end
    end
  end

  context 'when specifying input and output count' do
    subject { MockComponent1.new(inputs: 2, outputs: 2) }

    it 'has one input' do
      expect(subject.inputs.count).to eq(2)
    end

    it 'has one output' do
      expect(subject.outputs.count).to eq(2)
    end
  end

  context 'when supplying inputs and outputs' do
    let(:inputs) { [double('input')] }
    let(:outputs) { [double('output')] }

    subject { MockComponent1.new(inputs: inputs, outputs: outputs) }

    describe '#tick' do
      it 'raises NotImplementedError' do
        expect { subject.tick }.to raise_error(NotImplementedError)
      end
    end

    describe '#tock' do
      it 'tocks the outputs' do
        expect(outputs[0]).to receive(:tock)
        subject.tock
      end
    end

    describe '#[]' do
      context 'one input and one output' do
        it 'has the input available as :in' do
          expect(subject[:in]).to eq(inputs[0])
        end

        it 'has the output available as :out' do
          expect(subject[:out]).to eq(outputs[0])
        end
      end

      context 'two inputs and two outputs' do
        let(:inputs) { [double('input_1'), double('input_2')] }
        let(:outputs) { [double('output_1'), double('output_2')] }

        it 'has the inputs available as :a and :b' do
          expect(subject[:a]).to eq(inputs[0])
          expect(subject[:b]).to eq(inputs[1])
        end

        it 'has the outputs available as :c and :d' do
          expect(subject[:c]).to eq(outputs[0])
          expect(subject[:d]).to eq(outputs[1])
        end
      end
    end
  end

  context 'when you do not override #set_defaults' do
    it 'raises NotImplementedError' do
      expect { MockComponent2.new }.to raise_error(NotImplementedError)
    end
  end
end

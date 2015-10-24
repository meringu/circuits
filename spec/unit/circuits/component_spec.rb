require 'spec_helper'
require 'circuits/component'

# Mock component to include Circuits::Component for function accessability
class MockComponent
  include Circuits::Component

  def initialize(opts = {})
    @outputs = opts[:outputs]
  end

  def mock_input_count
    input_count
  end

  def mock_output_count
    output_count
  end

  def mock_create_inputs(n)
    create_inputs(n)
  end
end

describe Circuits::Component do
  let(:outputs) { [double('output')] }

  subject { MockComponent.new(outputs: outputs) }

  describe '#input_count' do
    it 'is not implemented' do
      expect { subject.mock_input_count }.to raise_error(NotImplementedError)
    end
  end

  describe '#output_count' do
    it 'is not implemented' do
      expect { subject.mock_output_count }.to raise_error(NotImplementedError)
    end
  end

  describe '#tick' do
    it 'is not implemented' do
      expect { subject.tick }.to raise_error(NotImplementedError)
    end
  end

  describe '#tock' do
    it 'tocks the outputs' do
      expect(outputs[0]).to receive(:tock)
      subject.tock
    end
  end

  describe '#create_inputs' do
    before :each do
      allow(subject).to receive(:input_count).and_return(2)
    end

    context 'when the given argument is less than the value of input count' do
      it 'fails with an argument error' do
        expect { subject.mock_create_inputs(0) }.to raise_error(ArgumentError)
      end
    end

    context 'when given a valid number of inputs' do
      [2, 4, 6].each do |n|
        it "creates #{n} inputs" do
          expect(subject.mock_create_inputs(n).size).to eq(n)
        end
      end
    end
  end
end

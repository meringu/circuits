require 'spec_helper'
require 'circuits/component'

# Mock component to include Circuits::Component for function accessability
class MockComponent
  include Circuits::Component

  def initialize(opts = {})
    @outputs = opts[:outputs]
  end
end

describe Circuits::Component do
  subject { MockComponent.new }

  describe '#input_count' do
    it 'is not implemented' do
      expect { subject.input_count }.to raise_error(NotImplementedError)
    end
  end

  describe '#output_count' do
    it 'is not implemented' do
      expect { subject.output_count }.to raise_error(NotImplementedError)
    end
  end

  describe '#tick' do
    it 'is not implemented' do
      expect { subject.tick }.to raise_error(NotImplementedError)
    end
  end

  describe '#tock' do
    let(:outputs) { [double('output')] }

    subject { MockComponent.new(outputs: outputs) }

    it 'tocks the outputs' do
      expect(outputs[0]).to receive(:tock)
      subject.tock
    end
  end
end

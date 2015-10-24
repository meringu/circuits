require 'spec_helper'
require 'circuits/component'

# Mock component to include Circuits::Component for function accessability
class MockComponent
  include Circuits::Component

  def initialize(opts = {})
    @outputs = opts[:outputs]
  end

  def mock_set_defaults
    set_defaults
  end

  def mock_create_inputs(n)
    create_inputs(n)
  end
end

describe Circuits::Component do
  let(:outputs) { [double('output')] }

  subject { MockComponent.new(outputs: outputs) }

  describe '#set_defaults' do
    it 'is not implemented' do
      expect { subject.mock_set_defaults }.to raise_error(NotImplementedError)
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
end

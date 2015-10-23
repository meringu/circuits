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
  describe '#tock' do
    let(:outputs) { [double('output')] }

    subject { MockComponent.new(outputs: outputs) }

    it 'tocks the outputs' do
      expect(outputs[0]).to receive(:tock)
      subject.tock
    end
  end
end

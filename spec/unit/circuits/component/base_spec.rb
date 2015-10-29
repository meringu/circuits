require 'spec_helper'
require 'circuits/component/base'

# Mock component to include Circuits::Component::Base
class MockComponent1 < Circuits::Component::Base
  def default_input_count
    1
  end

  def default_output_count
    1
  end
end

# Mock component to include Circuits::Component::Base
class MockComponent2 < Circuits::Component::Base
  def default_input_count
    2
  end

  def default_output_count
    2
  end
end

describe Circuits::Component::Base do
  describe '#[]' do
    context 'one input and one output' do
      subject { MockComponent1.new }

      it 'has the input available as #in' do
        expect(subject[:in]).to eq(subject.inputs[0])
      end

      it 'has the output available as #out' do
        expect(subject[:out]).to eq(subject.outputs[0])
      end

      it 'has the input available as :in' do
        expect(subject.in).to eq(subject.inputs[0])
      end

      it 'has the output available as :out' do
        expect(subject.out).to eq(subject.outputs[0])
      end

      it 'gets nil when invalid' do
        expect(subject[:a]).to eq(nil)
      end

      it 'responds to #in' do
        expect(subject.respond_to? :in).to eq true
      end

      it 'responds to #out' do
        expect(subject.respond_to? :out).to eq true
      end

      it 'does not respond to #a' do
        expect(subject.respond_to? :a).to eq false
      end
    end

    context 'two inputs and two outputs' do
      subject { MockComponent2.new }

      it 'has the inputs available as #a and #b' do
        expect(subject.a).to eq(subject.inputs[0])
        expect(subject.b).to eq(subject.inputs[1])
      end

      it 'has the outputs available as #c and #d' do
        expect(subject.c).to eq(subject.outputs[0])
        expect(subject.d).to eq(subject.outputs[1])
      end
    end
  end
end

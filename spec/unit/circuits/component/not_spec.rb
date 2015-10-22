require 'spec_helper'
require 'circuits/component/not'

describe Circuits::Component::Not do
  describe '#tick' do
    subject { Circuits::Component::Not.new }

    before { subject.inputs[0].set input }

    context '!false' do
      let(:input) { false }

      it '= true' do
        subject.tick
        subject.tock
        expect(subject.outputs[0].get).to eq(true)
      end
    end

    context '!true' do
      let(:input) { true }

      it '= false' do
        subject.tick
        subject.tock
        expect(subject.outputs[0].get).to eq(false)
      end
    end
  end
end

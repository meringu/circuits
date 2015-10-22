require 'spec_helper'
require 'circuits/component/sr_nor'

describe Circuits::Component::SrNor do
  describe '#tick' do
    subject { Circuits::Component::SrNor.new }

    context 'is set' do
      before do
        subject.inputs[0].set false
        subject.inputs[1].set true
        subject.tick
        subject.tock
        subject.inputs[1].set false
      end

      it 'is set' do
        expect(subject.outputs[0].get).to eq(true)
        expect(subject.outputs[1].get).to eq(false)
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject.outputs[0].get).to eq(true)
        expect(subject.outputs[1].get).to eq(false)
      end

      it 'can be reset' do
        subject.inputs[0].set true
        subject.tick
        subject.tock
        expect(subject.outputs[0].get).to eq(false)
        expect(subject.outputs[1].get).to eq(true)
      end
    end

    context 'is reset' do
      before do
        subject.inputs[0].set true
        subject.inputs[1].set false
        subject.tick
        subject.tock
        subject.inputs[0].set false
      end

      it 'is reset' do
        expect(subject.outputs[0].get).to eq(false)
        expect(subject.outputs[1].get).to eq(true)
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject.outputs[0].get).to eq(false)
        expect(subject.outputs[1].get).to eq(true)
      end

      it 'can be set' do
        subject.inputs[1].set true
        subject.tick
        subject.tock
        expect(subject.outputs[0].get).to eq(true)
        expect(subject.outputs[1].get).to eq(false)
      end
    end
  end
end

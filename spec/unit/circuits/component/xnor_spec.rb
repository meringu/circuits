require 'spec_helper'
require 'circuits/component/xnor'

describe Circuits::Component::Xnor do
  describe '#tick' do
    context 'default input count' do
      subject { Circuits::Component::Xnor.new }

      before do
        subject.inputs[0].set input_1
        subject.inputs[1].set input_2
      end

      context 'false + false' do
        let(:input_1) { false }
        let(:input_2) { false }

        it '= true' do
          subject.tick
          subject.tock
          expect(subject.outputs[0].get).to eq(true)
        end
      end

      context 'true + false' do
        let(:input_1) { true }
        let(:input_2) { false }

        it '= false' do
          subject.tick
          subject.tock
          expect(subject.outputs[0].get).to eq(false)
        end
      end

      context 'false + true' do
        let(:input_1) { false }
        let(:input_2) { true }

        it '= false' do
          subject.tick
          subject.tock
          expect(subject.outputs[0].get).to eq(false)
        end
      end

      context 'true + true' do
        let(:input_1) { true }
        let(:input_2) { true }

        it '= true' do
          subject.tick
          subject.tock
          expect(subject.outputs[0].get).to eq(true)
        end
      end
    end
  end
end

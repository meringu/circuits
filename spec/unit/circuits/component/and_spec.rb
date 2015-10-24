require 'spec_helper'
require 'circuits/component/and'

describe Circuits::Component::And do
  describe '#tick' do
    context 'default input count' do
      subject { Circuits::Component::And.new }

      before do
        subject.inputs[0].set input_1
        subject.inputs[1].set input_2
      end

      context 'false + false' do
        let(:input_1) { false }
        let(:input_2) { false }

        it '= false' do
          subject.tick
          subject.tock
          expect(subject.outputs[0].get).to eq(false)
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

    [3, 4, 8].each do |n|
      context "with #{n} inputs" do
        subject { Circuits::Component::And.new inputs: n }

        before do
          n.times { |x| subject.inputs[x].set inputs[x] }
        end

        context 'when all inputs are true' do
          let(:inputs) { n.times.collect { true } }

          it '= true' do
            subject.tick
            subject.tock
            expect(subject.outputs[0].get).to eq(true)
          end
        end

        context 'when all inputs are false' do
          let(:inputs) { n.times.collect { false } }

          it '= false' do
            subject.tick
            subject.tock
            expect(subject.outputs[0].get).to eq(false)
          end
        end

        context 'when any input is false' do
          n.times do |x|
            context "when input #{x} is false" do
              let(:inputs) do
                inputs =  n.times.collect { true }
                inputs[x] = false
                inputs
              end

              it '= false' do
                subject.tick
                subject.tock
                expect(subject.outputs[0].get).to eq(false)
              end
            end
          end
        end
      end
    end
  end
end

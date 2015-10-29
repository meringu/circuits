require 'spec_helper'
require 'circuits/component/xnor'

describe Circuits::Component::Xnor do
  describe '#tick' do
    context 'default input count' do
      subject { Circuits::Component::Xnor.new }

      context 'false + false' do
        it '= true' do
          subject.a.set false
          subject.b.set false
          subject.tick
          subject.tock
          expect(subject.out.get).to eq true
        end
      end

      context 'true + false' do
        it '= false' do
          subject.a.set true
          subject.b.set false
          subject.tick
          subject.tock
          expect(subject.out.get).to eq false
        end
      end

      context 'false + true' do
        it '= false' do
          subject.a.set false
          subject.b.set true
          subject.tick
          subject.tock
          expect(subject.out.get).to eq false
        end
      end

      context 'true + true' do
        it '= true' do
          subject.a.set true
          subject.b.set true
          subject.tick
          subject.tock
          expect(subject.out.get).to eq true
        end
      end
    end

    context 'when the number of inputs is even' do
      [2, 4, 8].each do |n|
        context "with #{n} inputs" do
          subject { Circuits::Component::Xnor.new input_count: n }

          before do
            n.times { |x| subject.inputs[x].set inputs[x] }
          end

          context 'when all inputs are true' do
            let(:inputs) { n.times.collect { true } }

            it '= true' do
              subject.tick
              subject.tock
              expect(subject.out.get).to eq true
            end
          end

          context 'when all inputs are false' do
            let(:inputs) { n.times.collect { false } }

            it '= true' do
              subject.tick
              subject.tock
              expect(subject.out.get).to eq true
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
                  expect(subject.out.get).to eq false
                end
              end
            end
          end
        end
      end
    end
    context 'when the number of inputs is odd' do
      [3, 5, 7].each do |n|
        context "with #{n} inputs" do
          subject { Circuits::Component::Xnor.new input_count: n }

          before do
            n.times { |x| subject.inputs[x].set inputs[x] }
          end

          context 'when all inputs are true' do
            let(:inputs) { n.times.collect { true } }

            it '= false' do
              subject.tick
              subject.tock
              expect(subject.out.get).to eq false
            end
          end

          context 'when all inputs are false' do
            let(:inputs) { n.times.collect { false } }

            it '= true' do
              subject.tick
              subject.tock
              expect(subject.out.get).to eq true
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

                it '= true' do
                  subject.tick
                  subject.tock
                  expect(subject.out.get).to eq true
                end
              end
            end
          end

          context 'when any input is true' do
            n.times do |x|
              context "when input #{x} is true" do
                let(:inputs) do
                  inputs =  n.times.collect { false }
                  inputs[x] = true
                  inputs
                end

                it '= false' do
                  subject.tick
                  subject.tock
                  expect(subject.out.get).to eq false
                end
              end
            end
          end
        end
      end
    end
  end
end

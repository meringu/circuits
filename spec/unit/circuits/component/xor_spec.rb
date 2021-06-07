# frozen_string_literal: true

require 'spec_helper'
require 'circuits/component/xor'

describe Circuits::Component::Xor do
  describe '#tick' do
    context 'with default input count' do
      subject(:component) { described_class.new }

      context 'when false + false' do
        it '= false' do
          component.a.set false
          component.b.set false
          component.tick
          component.tock
          expect(component.out.get).to eq false
        end
      end

      context 'when true + false' do
        it '= true' do
          component.a.set true
          component.b.set false
          component.tick
          component.tock
          expect(component.out.get).to eq true
        end
      end

      context 'when false + true' do
        it '= true' do
          component.a.set false
          component.b.set true
          component.tick
          component.tock
          expect(component.out.get).to eq true
        end
      end

      context 'when true + true' do
        it '= false' do
          component.a.set true
          component.b.set true
          component.tick
          component.tock
          expect(component.out.get).to eq false
        end
      end
    end

    context 'when the number of inputs is even' do
      [2, 4, 8].each do |n|
        context "with #{n} inputs" do
          subject(:component) { described_class.new inputs: n }

          before do
            n.times { |x| component.inputs[x].set inputs[x] }
          end

          context 'when all inputs are true' do
            let(:inputs) { n.times.collect { true } }

            it '= false' do
              component.tick
              component.tock
              expect(component.out.get).to eq false
            end
          end

          context 'when all inputs are false' do
            let(:inputs) { n.times.collect { false } }

            it '= false' do
              component.tick
              component.tock
              expect(component.out.get).to eq false
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
                  component.tick
                  component.tock
                  expect(component.out.get).to eq true
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
          subject(:component) { described_class.new inputs: n }

          before do
            n.times { |x| component.inputs[x].set inputs[x] }
          end

          context 'when all inputs are true' do
            let(:inputs) { n.times.collect { true } }

            it '= true' do
              component.tick
              component.tock
              expect(component.out.get).to eq true
            end
          end

          context 'when all inputs are false' do
            let(:inputs) { n.times.collect { false } }

            it '= false' do
              component.tick
              component.tock
              expect(component.out.get).to eq false
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
                  component.tick
                  component.tock
                  expect(component.out.get).to eq false
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

                it '= true' do
                  component.tick
                  component.tock
                  expect(component.out.get).to eq true
                end
              end
            end
          end
        end
      end
    end
  end
end

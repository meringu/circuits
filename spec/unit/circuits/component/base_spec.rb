# frozen_string_literal: true

require 'spec_helper'
require 'circuits/component/base'

describe Circuits::Component::Base do
  describe '#[]' do
    context 'one input and one output' do
      subject(:component) { described_class.new(inputs: 1, outputs: 1) }

      it 'has the input available as #in' do
        expect(component[:in]).to eq(component.inputs[0])
      end

      it 'has the output available as #out' do
        expect(component[:out]).to eq(component.outputs[0])
      end

      it 'has the input available as :in' do
        expect(component.in).to eq(component.inputs[0])
      end

      it 'has the output available as :out' do
        expect(component.out).to eq(component.outputs[0])
      end

      it 'gets nil when invalid' do
        expect(component[:a]).to eq(nil)
      end

      it 'responds to #in' do
        expect(component.respond_to?(:in)).to eq true
      end

      it 'responds to #out' do
        expect(component.respond_to?(:out)).to eq true
      end

      it 'does not respond to #a' do
        expect(component.respond_to?(:a)).to eq false
      end
    end

    context 'two inputs and two outputs' do
      subject(:component) { described_class.new(inputs: 2, outputs: 2) }

      it 'has the inputs available as #a and #b' do
        expect(component.a).to eq(component.inputs[0])
        expect(component.b).to eq(component.inputs[1])
      end

      it 'has the outputs available as #c and #d' do
        expect(component.c).to eq(component.outputs[0])
        expect(component.d).to eq(component.outputs[1])
      end
    end
  end
end

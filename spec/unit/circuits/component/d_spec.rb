# frozen_string_literal: true

require 'spec_helper'
require 'circuits/component/d'

describe Circuits::Component::D do
  describe '#tick' do
    subject(:component) { described_class.new }

    context 'it has just been initialized' do
      it 'is unset' do
        expect(component.q.get).to eq false
        expect(component.not_q.get).to eq true
      end

      it 'is stable' do
        component.tick
        component.tock
        expect(component.q.get).to eq false
        expect(component.not_q.get).to eq true
      end
    end

    context 'has just been set' do
      before do
        component.clk.set false
        component.tick
        component.tock
        component.d.set true
        component.clk.set true
        component.tick
        component.tock
        component.d.set false
        component.clk.set false
      end

      it 'is set' do
        expect(component.q.get).to eq true
        expect(component.not_q.get).to eq false
      end

      it 'is stable' do
        component.tick
        component.tock
        expect(component.q.get).to eq true
        expect(component.not_q.get).to eq false
      end

      it 'd high has no effect' do
        component.d.set true
        component.tick
        component.tock
        expect(component.q.get).to eq true
        expect(component.not_q.get).to eq false
      end

      it 'clock has to be positive edge' do
        component.d.set false
        component.clk.set true
        component.tick
        component.tock
        expect(component.q.get).to eq true
        expect(component.not_q.get).to eq false
      end

      it 'can be reset' do
        component.tick
        component.tock
        component.clk.set true
        component.tick
        component.tock
        expect(component.q.get).to eq false
        expect(component.not_q.get).to eq true
      end
    end

    context 'has just been reset' do
      before do
        component.clk.set false
        component.tick
        component.tock
        component.d.set false
        component.clk.set true
        component.tick
        component.tock
        component.clk.set false
      end

      it 'is reset' do
        expect(component.q.get).to eq false
        expect(component.not_q.get).to eq true
      end

      it 'is stable' do
        component.tick
        component.tock
        expect(component.q.get).to eq false
        expect(component.not_q.get).to eq true
      end

      it 'd high has no effect' do
        component.d.set true
        component.tick
        component.tock
        expect(component.q.get).to eq false
        expect(component.not_q.get).to eq true
      end

      it 'clock has to be positive edge' do
        component.d.set true
        component.clk.set true
        component.tick
        component.tock
        expect(component.q.get).to eq false
        expect(component.not_q.get).to eq true
      end

      it 'can be set' do
        component.tick
        component.tock
        component.d.set true
        component.clk.set true
        component.tick
        component.tock
        expect(component.q.get).to eq true
        expect(component.not_q.get).to eq false
      end
    end
  end
end

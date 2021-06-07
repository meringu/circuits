# frozen_string_literal: true

require 'spec_helper'
require 'circuits/component/sr_nand'

describe Circuits::Component::SrNand do
  describe '#tick' do
    subject(:component) { described_class.new }

    context 'it has just been initialized' do
      it 'is unset' do
        expect(component[:q].get).to eq false
        expect(component[:not_q].get).to eq true
      end

      it 'is stable' do
        component.tick
        component.tock
        expect(component[:q].get).to eq false
        expect(component[:not_q].get).to eq true
      end
    end

    context 'is set' do
      before do
        component[:not_s].set false
        component[:not_r].set true
        component.tick
        component.tock
        component[:not_s].set true
      end

      it 'is set' do
        expect(component[:q].get).to eq true
        expect(component[:not_q].get).to eq false
      end

      it 'is stable' do
        component.tick
        component.tock
        expect(component[:q].get).to eq true
        expect(component[:not_q].get).to eq false
      end

      it 'can be reset' do
        component[:not_r].set false
        component.tick
        component.tock
        expect(component[:q].get).to eq false
        expect(component[:not_q].get).to eq true
      end
    end

    context 'is reset' do
      before do
        component[:not_s].set true
        component[:not_r].set false
        component.tick
        component.tock
        component[:not_r].set true
      end

      it 'is reset' do
        expect(component[:q].get).to eq false
        expect(component[:not_q].get).to eq true
      end

      it 'is stable' do
        component.tick
        component.tock
        expect(component[:q].get).to eq false
        expect(component[:not_q].get).to eq true
      end

      it 'can be set' do
        component[:not_s].set false
        component.tick
        component.tock
        expect(component[:q].get).to eq true
        expect(component[:not_q].get).to eq false
      end
    end
  end
end

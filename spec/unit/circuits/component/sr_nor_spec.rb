# frozen_string_literal: true

require 'spec_helper'
require 'circuits/component/sr_nor'

describe Circuits::Component::SrNor do
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

    context 'when set' do
      before do
        component[:r].set false
        component[:s].set true
        component.tick
        component.tock
        component[:s].set false
      end

      it 'is set' do
        expect(component[:q].get).to eq true
        expect(component[:not_q].get).to eq false
      end

      context 'when clock is cycled' do
        before do
          component.tick
          component.tock
        end

        it 'q is stable' do
          expect(component[:q].get).to eq true
        end

        it 'not_q is stable' do
          expect(component[:not_q].get).to eq false
        end
      end

      context 'when reset' do
        before do
          component[:r].set true
          component.tick
          component.tock
        end

        it 'q is reset' do
          expect(component[:q].get).to eq false
        end

        it 'not_q is reset' do
          expect(component[:not_q].get).to eq true
        end
      end
    end

    context 'when reset' do
      before do
        component[:r].set true
        component[:s].set false
        component.tick
        component.tock
        component[:r].set false
      end

      it 'q is reset' do
        expect(component[:q].get).to eq false
      end

      it 'not_q is reset' do
        expect(component[:not_q].get).to eq true
      end

      context 'when clock is cycled' do
        before do
          component.tick
          component.tock
        end

        it 'q is stable' do
          expect(component[:q].get).to eq false
        end

        it 'not_q is stable' do
          expect(component[:not_q].get).to eq true
        end
      end

      context 'when set' do
        before do
          component[:s].set true
          component.tick
          component.tock
        end

        it 'q is set' do
          expect(component[:q].get).to eq true
        end

        it 'not_q is set' do
          expect(component[:not_q].get).to eq false
        end
      end
    end
  end
end

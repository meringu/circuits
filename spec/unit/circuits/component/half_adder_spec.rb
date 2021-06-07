# frozen_string_literal: true

require 'spec_helper'
require 'circuits/component/half_adder'

describe Circuits::Component::HalfAdder do
  describe '#tick' do
    subject(:component) { described_class.new }

    context '0 + 0' do
      it '= 0' do
        component.a.set false
        component.b.set false
        component.tick
        component.tock
        expect(component.s.get).to eq false
        expect(component.c_out.get).to eq false
      end
    end

    context '0 + 1' do
      it '= 1' do
        component.a.set false
        component.b.set true
        component.tick
        component.tock
        expect(component.s.get).to eq true
        expect(component.c_out.get).to eq false
      end
    end

    context '1 + 0' do
      it '= 1' do
        component.a.set true
        component.b.set false
        component.tick
        component.tock
        expect(component.s.get).to eq true
        expect(component.c_out.get).to eq false
      end
    end

    context '1 + 1' do
      it '= 10' do
        component.a.set true
        component.b.set true
        component.tick
        component.tock
        expect(component.s.get).to eq false
        expect(component.c_out.get).to eq true
      end
    end
  end
end

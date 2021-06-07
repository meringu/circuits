# frozen_string_literal: true

require 'spec_helper'
require 'circuits/component/not'

describe Circuits::Component::Not do
  describe '#tick' do
    subject(:component) { described_class.new }

    context '!false' do
      it '= true' do
        component.in.set false
        component.tick
        component.tock
        expect(component.out.get).to eq true
      end
    end

    context '!true' do
      it '= false' do
        component.in.set true
        component.tick
        component.tock
        expect(component.out.get).to eq false
      end
    end
  end
end

require 'spec_helper'
require 'circuits/component/half_adder'

describe Circuits::Component::HalfAdder do
  describe '#tick' do
    subject { Circuits::Component::HalfAdder.new }

    context '0 + 0' do
      it '= 0' do
        subject.a.set false
        subject.b.set false
        subject.tick
        subject.tock
        expect(subject.s.get).to eq false
        expect(subject.c_out.get).to eq false
      end
    end

    context '0 + 1' do
      it '= 1' do
        subject.a.set false
        subject.b.set true
        subject.tick
        subject.tock
        expect(subject.s.get).to eq true
        expect(subject.c_out.get).to eq false
      end
    end

    context '1 + 0' do
      it '= 1' do
        subject.a.set true
        subject.b.set false
        subject.tick
        subject.tock
        expect(subject.s.get).to eq true
        expect(subject.c_out.get).to eq false
      end
    end

    context '1 + 1' do
      it '= 10' do
        subject.a.set true
        subject.b.set true
        subject.tick
        subject.tock
        expect(subject.s.get).to eq false
        expect(subject.c_out.get).to eq true
      end
    end
  end
end

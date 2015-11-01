require 'spec_helper'
require 'circuits/component/full_adder'

describe Circuits::Component::FullAdder do
  describe '#tick' do
    subject { Circuits::Component::FullAdder.new }

    context 'no overflow' do
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

    context 'overflow' do
      context '0 + 0 (+ 1)' do
        it '= 1' do
          subject.a.set false
          subject.b.set false
          subject.c_in.set true
          subject.tick
          subject.tock
          expect(subject.s.get).to eq true
          expect(subject.c_out.get).to eq false
        end
      end

      context '0 + 1 (+ 1)' do
        it '= 10' do
          subject.a.set false
          subject.b.set true
          subject.c_in.set true
          subject.tick
          subject.tock
          expect(subject.s.get).to eq false
          expect(subject.c_out.get).to eq true
        end
      end

      context '1 + 0 (+ 1)' do
        it '= 10' do
          subject.a.set true
          subject.b.set false
          subject.c_in.set true
          subject.tick
          subject.tock
          expect(subject.s.get).to eq false
          expect(subject.c_out.get).to eq true
        end
      end

      context '1 + 1 (+ 1)' do
        it '= 11' do
          subject.a.set true
          subject.b.set true
          subject.c_in.set true
          subject.tick
          subject.tock
          expect(subject.s.get).to eq true
          expect(subject.c_out.get).to eq true
        end
      end
    end
  end
end

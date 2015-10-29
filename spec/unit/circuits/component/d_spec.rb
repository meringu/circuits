require 'spec_helper'
require 'circuits/component/d'

describe Circuits::Component::D do
  describe '#tick' do
    subject { Circuits::Component::D.new }

    context 'it has just been initialized' do
      it 'is unset' do
        expect(subject.q.get).to eq false
        expect(subject.not_q.get).to eq true
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject.q.get).to eq false
        expect(subject.not_q.get).to eq true
      end
    end

    context 'has just been set' do
      before do
        subject.clk.set false
        subject.tick
        subject.tock
        subject.d.set true
        subject.clk.set true
        subject.tick
        subject.tock
        subject.d.set false
        subject.clk.set false
      end

      it 'is set' do
        expect(subject.q.get).to eq true
        expect(subject.not_q.get).to eq false
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject.q.get).to eq true
        expect(subject.not_q.get).to eq false
      end

      it 'd high has no effect' do
        subject.d.set true
        subject.tick
        subject.tock
        expect(subject.q.get).to eq true
        expect(subject.not_q.get).to eq false
      end

      it 'clock has to be positive edge' do
        subject.d.set false
        subject.clk.set true
        subject.tick
        subject.tock
        expect(subject.q.get).to eq true
        expect(subject.not_q.get).to eq false
      end

      it 'can be reset' do
        subject.tick
        subject.tock
        subject.clk.set true
        subject.tick
        subject.tock
        expect(subject.q.get).to eq false
        expect(subject.not_q.get).to eq true
      end
    end

    context 'has just been reset' do
      before do
        subject.clk.set false
        subject.tick
        subject.tock
        subject.d.set false
        subject.clk.set true
        subject.tick
        subject.tock
        subject.clk.set false
      end

      it 'is reset' do
        expect(subject.q.get).to eq false
        expect(subject.not_q.get).to eq true
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject.q.get).to eq false
        expect(subject.not_q.get).to eq true
      end

      it 'd high has no effect' do
        subject.d.set true
        subject.tick
        subject.tock
        expect(subject.q.get).to eq false
        expect(subject.not_q.get).to eq true
      end

      it 'clock has to be positive edge' do
        subject.d.set true
        subject.clk.set true
        subject.tick
        subject.tock
        expect(subject.q.get).to eq false
        expect(subject.not_q.get).to eq true
      end

      it 'can be set' do
        subject.tick
        subject.tock
        subject.d.set true
        subject.clk.set true
        subject.tick
        subject.tock
        expect(subject.q.get).to eq true
        expect(subject.not_q.get).to eq false
      end
    end
  end
end

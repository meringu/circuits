require 'spec_helper'
require 'circuits/terminal'

describe Circuits::Terminal do
  describe '#get' do
    let(:state) { double('state') }

    context 'when given no state' do
      subject { Circuits::Terminal.new }

      it 'is false' do
        expect(subject.get).to eq(false)
      end
    end

    context 'when given a state' do
      subject { Circuits::Terminal.new(state: state) }

      it 'has that state' do
        expect(subject.get).to eq(state)
      end
    end

    context 'when given terminal' do
      let(:terminal) { Circuits::Terminal.new(state: state) }

      subject { Circuits::Terminal.new(terminal: terminal) }

      it 'is false' do
        expect(subject.get).to eq(false)
      end
    end
  end

  describe '#set' do
    let(:state_1) { double('state_1') }
    let(:state_2) { double('state_2') }

    context 'when given a state' do
      subject { Circuits::Terminal.new(state: state_1) }

      it 'gets set immediately' do
        subject.set state_2
        expect(subject.get).to eq(state_2)
      end
    end

    context 'when given a terminal' do
      let(:terminal) { Circuits::Terminal.new(state: state_2) }

      subject { Circuits::Terminal.new(state: state_1) }

      it 'gets does not get set immediately' do
        subject.set terminal
        expect(subject.get).to eq(state_1)
      end
    end
  end

  describe '#tock' do
    let(:state) { double('state') }

    context 'when passed a state' do
      subject { Circuits::Terminal.new }

      it 'moves next set to get' do
        subject.set state
        subject.tock
        expect(subject.get).to eq(state)
      end
    end

    context 'when given terminal' do
      let(:terminal) { Circuits::Terminal.new(state: state) }

      subject { Circuits::Terminal.new(terminal: terminal) }

      it 'is has that state' do
        subject.tock
        expect(subject.get).to eq(state)
      end
    end
  end
end

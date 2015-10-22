require 'spec_helper'
require 'circuits/terminal/output'

describe Circuits::Terminal::Output do
  describe '#get' do
    context 'when given no state' do
      subject { Circuits::Terminal::Output.new }

      it 'is false' do
        expect(subject.get).to eq(false)
      end
    end

    context 'when given false state' do
      subject { Circuits::Terminal::Output.new(state: false) }

      it 'is false' do
        expect(subject.get).to eq(false)
      end
    end

    context 'when given true state' do
      subject { Circuits::Terminal::Output.new(state: true) }

      it 'is true' do
        expect(subject.get).to eq(true)
      end
    end
  end

  describe '#set' do
    let(:state_1) { double('state_1') }
    let(:state_2) { double('state_2') }

    subject { Circuits::Terminal::Output.new(state: state_1) }

    it 'does not set get immediately' do
      subject.set state_2
      expect(subject.get).to eq(state_1)
    end
  end

  describe '#tock' do
    let(:state) { double('state') }

    subject { Circuits::Terminal::Output.new }

    it 'moves next set to get' do
      subject.set state
      subject.tock
      expect(subject.get).to eq(state)
    end
  end
end

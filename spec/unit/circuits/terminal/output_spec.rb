require 'spec_helper'
require 'circuits/terminal/output'

describe Circuits::Terminal::Output do
  describe '#get' do
    let(:state) { double('state') }

    context 'when given no state' do
      subject { Circuits::Terminal::Output.new }

      it 'is false' do
        expect(subject.get).to eq(false)
      end
    end

    context 'when given a state' do
      subject { Circuits::Terminal::Output.new(state: state) }

      it 'has that state' do
        expect(subject.get).to eq(state)
      end
    end

    context 'when given an input' do
      let(:input) { Circuits::Terminal::Input.new(state: state) }

      subject { Circuits::Terminal::Output.new(terminal: input) }

      it 'has the input state' do
        expect(subject.get).to eq(state)
      end
    end

    context 'when given an output' do
      let(:output) { Circuits::Terminal::Output.new(state: state) }

      subject { Circuits::Terminal::Output.new(terminal: output) }

      it 'has the output state' do
        expect(subject.get).to eq(state)
      end
    end
  end

  describe '#set' do
    let(:state_1) { double('state_1') }
    let(:state_2) { double('state_2') }

    subject { Circuits::Terminal::Output.new(state: state_1) }

    context 'when given a state' do
      it 'gets does not get set immediately' do
        subject.set state_2
        expect(subject.get).to eq(state_1)
      end
    end

    context 'when given an input' do
      let(:input) { Circuits::Terminal::Input.new(state: state_2) }

      it 'gets does not get set immediately' do
        subject.set input
        expect(subject.get).to eq(state_1)
      end
    end

    context 'when given an output' do
      let(:output) { Circuits::Terminal::Output.new(state: state_2) }

      it 'gets does not get set immediately' do
        subject.set output
        expect(subject.get).to eq(state_1)
      end
    end
  end

  describe '#tock' do
    let(:state_1) { double('state_1') }
    let(:state_2) { double('state_2') }

    subject { Circuits::Terminal::Output.new(state: state_1) }

    context 'when given a state' do
      it 'updates the state' do
        subject.set state_2
        subject.tock
        expect(subject.get).to eq(state_2)
      end
    end

    context 'when given an input' do
      let(:input) { Circuits::Terminal::Input.new(state: state_2) }

      it 'updates the state' do
        subject.set input
        subject.tock
        expect(subject.get).to eq(state_2)
      end
    end

    context 'when given an output' do
      let(:output) { Circuits::Terminal::Output.new(state: state_2) }

      it 'updates the state' do
        subject.set output
        subject.tock
        expect(subject.get).to eq(state_2)
      end
    end
  end
end

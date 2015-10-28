require 'spec_helper'
require 'circuits/terminal/input'

describe Circuits::Terminal::Input do
  describe '#get' do
    context 'when given no state' do
      subject { Circuits::Terminal::Input.new }

      it 'is false' do
        expect(subject.get).to eq(false)
      end
    end
  end

  describe '#set' do
    let(:state) { double('state') }

    context 'when given a state' do
      subject { Circuits::Terminal::Input.new(state: state) }

      it 'has that state' do
        subject.set state
        expect(subject.get).to eq(state)
      end
    end

    context 'when given an input' do
      let(:input) { Circuits::Terminal::Input.new(state: state) }

      subject { Circuits::Terminal::Input.new }

      it 'has the input state' do
        subject.set input
        expect(subject.get).to eq(state)
      end
    end

    context 'when given an output' do
      let(:output) { Circuits::Terminal::Output.new(state: state) }

      subject { Circuits::Terminal::Input.new }

      it 'has the output state' do
        subject.set output
        expect(subject.get).to eq(state)
      end
    end
  end
end

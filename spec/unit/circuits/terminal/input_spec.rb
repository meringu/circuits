# frozen_string_literal: true

require 'spec_helper'
require 'circuits/terminal/input'

describe Circuits::Terminal::Input do
  describe '#get' do
    context 'when given no state' do
      subject(:terminal) { described_class.new }

      it 'is false' do
        expect(terminal.get).to eq(false)
      end
    end
  end

  describe '#set' do
    let(:state) { 'state' }

    context 'when given a state' do
      subject(:terminal) { described_class.new(state: state) }

      it 'has that state' do
        terminal.set state
        expect(terminal.get).to eq(state)
      end
    end

    context 'when given an input' do
      subject(:terminal) { described_class.new }

      let(:input) { described_class.new(state: state) }

      it 'has the input state' do
        terminal.set input
        expect(terminal.get).to eq(state)
      end
    end

    context 'when given an output' do
      subject(:terminal) { described_class.new }

      let(:output) { Circuits::Terminal::Output.new(state: state) }

      it 'has the output state' do
        terminal.set output
        expect(terminal.get).to eq(state)
      end
    end
  end
end

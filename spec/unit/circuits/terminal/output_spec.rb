# frozen_string_literal: true

require 'spec_helper'
require 'circuits/terminal/output'

describe Circuits::Terminal::Output do
  describe '#get' do
    let(:state) { 'state' }

    context 'when given no state' do
      subject(:terminal) { described_class.new }

      it 'is false' do
        expect(terminal.get).to eq(false)
      end
    end

    context 'when given a state' do
      subject(:terminal) { described_class.new(state: state) }

      it 'has that state' do
        expect(terminal.get).to eq(state)
      end
    end

    context 'when given an input' do
      subject(:terminal) { described_class.new(terminal: input) }

      let(:input) { Circuits::Terminal::Input.new(state: state) }

      it 'has the input state' do
        expect(terminal.get).to eq(state)
      end
    end

    context 'when given an output' do
      subject(:terminal) { described_class.new(terminal: output) }

      let(:output) { described_class.new(state: state) }

      it 'has the output state' do
        expect(terminal.get).to eq(state)
      end
    end
  end

  describe '#set' do
    subject(:terminal) { described_class.new(state: state1) }

    let(:state1) { 'state1' }
    let(:state2) { 'state2' }

    context 'when given a state' do
      it 'gets does not get set immediately' do
        terminal.set state2
        expect(terminal.get).to eq(state1)
      end
    end

    context 'when given an input' do
      let(:input) { Circuits::Terminal::Input.new(state: state2) }

      it 'gets does not get set immediately' do
        terminal.set input
        expect(terminal.get).to eq(state1)
      end
    end

    context 'when given an output' do
      let(:output) { described_class.new(state: state2) }

      it 'gets does not get set immediately' do
        terminal.set output
        expect(terminal.get).to eq(state1)
      end
    end
  end

  describe '#tock' do
    subject(:terminal) { described_class.new(state: state1) }

    let(:state1) { 'state1' }
    let(:state2) { 'state2' }

    context 'when given a state' do
      it 'updates the state' do
        terminal.set state2
        terminal.tock
        expect(terminal.get).to eq(state2)
      end
    end

    context 'when given an input' do
      let(:input) { Circuits::Terminal::Input.new(state: state2) }

      it 'updates the state' do
        terminal.set input
        terminal.tock
        expect(terminal.get).to eq(state2)
      end
    end

    context 'when given an output' do
      let(:output) { described_class.new(state: state2) }

      it 'updates the state' do
        terminal.set output
        terminal.tock
        expect(terminal.get).to eq(state2)
      end
    end
  end
end

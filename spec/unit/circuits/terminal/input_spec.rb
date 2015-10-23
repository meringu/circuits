require 'spec_helper'
require 'circuits/terminal/input'

module Circuits
  module Terminal
    class Output
    end
  end
end

describe Circuits::Terminal::Input do
  let(:output) { double('output') }

  describe '#initialize' do
    context 'when given an output' do

      subject { Circuits::Terminal::Input.new(output: output) }

      it 'sets the output' do
        expect(subject.output).to eq(output)
      end
    end

    context 'when not given an output' do
      subject { Circuits::Terminal::Input.new }

      before do
        expect(Circuits::Terminal::Output).to receive(:new).and_return(output)
      end

      it 'sets the output' do
        expect(subject.output).to eq(output)
      end
    end
  end

  describe '#get' do
    let(:res) { double('res') }

    subject { Circuits::Terminal::Input.new(output: output) }

    it 'forwards the request to output' do
      expect(output).to receive(:get).and_return(res)
      expect(subject.get).to eq(res)
    end
  end

  describe '#set' do
    let(:state) { double('state') }
    let(:new_output) { double('new_output', get: state) }

    subject { Circuits::Terminal::Input.new(output: output) }

    it 'sets the output to the passed output' do
      expect(Circuits::Terminal::Output).to receive(:new)
        .with(state: state).and_return(new_output)
      subject.set state
      expect(subject.get).to eq(state)
    end
  end
end

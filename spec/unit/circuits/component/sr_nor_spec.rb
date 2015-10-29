require 'spec_helper'
require 'circuits/component/sr_nor'

describe Circuits::Component::SrNor do
  describe '#tick' do
    subject { Circuits::Component::SrNor.new }

    context 'it has just been initialized' do
      it 'is unset' do
        expect(subject[:q].get).to eq false
        expect(subject[:not_q].get).to eq true
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject[:q].get).to eq false
        expect(subject[:not_q].get).to eq true
      end
    end

    context 'is set' do
      before do
        subject[:r].set false
        subject[:s].set true
        subject.tick
        subject.tock
        subject[:s].set false
      end

      it 'is set' do
        expect(subject[:q].get).to eq true
        expect(subject[:not_q].get).to eq false
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject[:q].get).to eq true
        expect(subject[:not_q].get).to eq false
      end

      it 'can be reset' do
        subject[:r].set true
        subject.tick
        subject.tock
        expect(subject[:q].get).to eq false
        expect(subject[:not_q].get).to eq true
      end
    end

    context 'is reset' do
      before do
        subject[:r].set true
        subject[:s].set false
        subject.tick
        subject.tock
        subject[:r].set false
      end

      it 'is reset' do
        expect(subject[:q].get).to eq false
        expect(subject[:not_q].get).to eq true
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject[:q].get).to eq false
        expect(subject[:not_q].get).to eq true
      end

      it 'can be set' do
        subject[:s].set true
        subject.tick
        subject.tock
        expect(subject[:q].get).to eq true
        expect(subject[:not_q].get).to eq false
      end
    end
  end
end

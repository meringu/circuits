require 'spec_helper'
require 'circuits/component/sr_nand'

describe Circuits::Component::SrNand do
  describe '#tick' do
    subject { Circuits::Component::SrNand.new }

    context 'is set' do
      before do
        subject[:not_s].set false
        subject[:not_r].set true
        subject.tick
        subject.tock
        subject[:not_s].set true
      end

      it 'is set' do
        expect(subject[:q].get).to eq(true)
        expect(subject[:not_q].get).to eq(false)
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject[:q].get).to eq(true)
        expect(subject[:not_q].get).to eq(false)
      end

      it 'can be reset' do
        subject[:not_r].set false
        subject.tick
        subject.tock
        expect(subject[:q].get).to eq(false)
        expect(subject[:not_q].get).to eq(true)
      end
    end

    context 'is reset' do
      before do
        subject[:not_s].set true
        subject[:not_r].set false
        subject.tick
        subject.tock
        subject[:not_r].set true
      end

      it 'is reset' do
        expect(subject[:q].get).to eq(false)
        expect(subject[:not_q].get).to eq(true)
      end

      it 'is stable' do
        subject.tick
        subject.tock
        expect(subject[:q].get).to eq(false)
        expect(subject[:not_q].get).to eq(true)
      end

      it 'can be set' do
        subject[:not_s].set false
        subject.tick
        subject.tock
        expect(subject[:q].get).to eq(true)
        expect(subject[:not_q].get).to eq(false)
      end
    end
  end
end

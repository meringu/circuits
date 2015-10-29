require 'spec_helper'
require 'circuits/component/not'

describe Circuits::Component::Not do
  describe '#tick' do
    subject { Circuits::Component::Not.new }

    context '!false' do
      it '= true' do
        subject.in.set false
        subject.tick
        subject.tock
        expect(subject.out.get).to eq true
      end
    end

    context '!true' do
      it '= false' do
        subject.in.set true
        subject.tick
        subject.tock
        expect(subject.out.get).to eq false
      end
    end
  end
end

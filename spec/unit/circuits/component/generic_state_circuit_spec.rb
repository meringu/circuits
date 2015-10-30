require 'spec_helper'
require 'circuits/component/generic_state_circuit'

describe Circuits::Component::GenericStateCircuit do
  before ':each' do
    @state_circuit = Circuits::Component::GenericStateCircuit.new
    @state_circuit.set_number_of_states 2
    @state_circuit.set_number_of_ors 2
    @state_circuit.set_number_of_ands 3
    @state_circuit.set_number_of_nots 2

    # a = !ab!i + a

    @state_circuit.get_not(0).in.set @state_circuit.get_state(0).q
    @state_circuit.get_not(1).in.set @state_circuit.i

    @state_circuit.get_and(0).a.set @state_circuit.get_not(0).out
    @state_circuit.get_and(0).b.set @state_circuit.get_state(1).q
    @state_circuit.get_and(1).a.set @state_circuit.get_and(0).out
    @state_circuit.get_and(1).b.set @state_circuit.get_not(1).out

    @state_circuit.get_or(0).a.set @state_circuit.get_state(0).q
    @state_circuit.get_or(0).b.set @state_circuit.get_and(1).out

    @state_circuit.get_state(0).d.set @state_circuit.get_or(0).out

    # b = i + b

    @state_circuit.get_or(1).a.set @state_circuit.i
    @state_circuit.get_or(1).b.set @state_circuit.get_state(1).q

    @state_circuit.get_state(1).d.set @state_circuit.get_or(1).out

    # out = ab

    @state_circuit.get_and(2).a.set @state_circuit.get_state(0).q
    @state_circuit.get_and(2).b.set @state_circuit.get_state(1).q
    
    @state_circuit.out.set @state_circuit.get_and(2).out

    def @state_circuit.do_cycle input
       i.set input
       tick
       tock
    end
    
  end

  describe 'one cycle' do
    context 'when the input is false' do
      it 'the output is false' do
        @state_circuit.do_cycle false
        expect(@state_circuit.out.get).to eq false
      end
    end

    context 'when the input is true' do
      it 'the output is false' do
        @state_circuit.do_cycle true
        expect(@state_circuit.out.get).to eq false
      end
    end
  end


   describe 'two cycles' do
    context 'when the input is false, false' do
      it 'the output is false' do
        @state_circuit.do_cycle false
        @state_circuit.do_cycle false
        expect(@state_circuit.out.get).to eq false
      end
    end

    context 'when the input is false, true' do
      it 'the output is false' do
        @state_circuit.do_cycle false
        @state_circuit.do_cycle true
        expect(@state_circuit.out.get).to eq false
      end
    end

    context 'when the input is true, false' do
      it 'the output is true' do
        @state_circuit.do_cycle true
        @state_circuit.do_cycle false
        expect(@state_circuit.out.get).to eq true
      end
    end

    context 'when the input is true, true' do
      it 'the output is false' do
        @state_circuit.do_cycle true
        @state_circuit.do_cycle true
        expect(@state_circuit.out.get).to eq false
      end
    end
  end

  describe 'three cycles' do
    context 'when the input is false, false, false' do
      it 'the output is false' do
        @state_circuit.do_cycle false
        @state_circuit.do_cycle false
        @state_circuit.do_cycle false
        expect(@state_circuit.out.get).to eq false
      end
    end

    context 'when the input is false, false, true' do
      it 'the output is false' do
        @state_circuit.do_cycle false
        @state_circuit.do_cycle false
        @state_circuit.do_cycle true
        expect(@state_circuit.out.get).to eq false
      end
    end

    context 'when the input is false, true, false' do
      it 'the output is true' do
        @state_circuit.do_cycle false
        @state_circuit.do_cycle true
        @state_circuit.do_cycle false
        expect(@state_circuit.out.get).to eq true
      end
    end

    context 'when the input is false, true, true' do
      it 'the output is false' do
        @state_circuit.do_cycle false
        @state_circuit.do_cycle true
        @state_circuit.do_cycle true
        expect(@state_circuit.out.get).to eq false
      end
    end

    context 'when the input is true, false, false' do
      it 'the output is true' do
        @state_circuit.do_cycle true
        @state_circuit.do_cycle false
        @state_circuit.do_cycle false
        expect(@state_circuit.out.get).to eq true
      end
    end

    context 'when the input is true, false, true' do
      it 'the output is true' do
        @state_circuit.do_cycle true
        @state_circuit.do_cycle false
        @state_circuit.do_cycle true
        expect(@state_circuit.out.get).to eq true
      end
    end

    context 'when the input is true, true, false' do
      it 'the output is true' do
        @state_circuit.do_cycle true
        @state_circuit.do_cycle true
        @state_circuit.do_cycle false
        expect(@state_circuit.out.get).to eq true
      end
    end

    context 'when the input is true, true, true' do
      it 'the output is false' do
        @state_circuit.do_cycle true
        @state_circuit.do_cycle true
        @state_circuit.do_cycle true
        expect(@state_circuit.out.get).to eq false
      end
    end
  end
end

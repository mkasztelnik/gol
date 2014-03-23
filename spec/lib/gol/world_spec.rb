require 'spec_helper'

describe World do

  before do
    subject.create_life_at(1, 1)
  end

  context 'Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do

    it 'cell is dead when no neighbours' do
      subject.tick!

      expect(subject.has_life_at?(1, 1)).to be_false
    end

    it 'cell is dead when has 1 neighbour' do
      subject.create_life_at(0, 0)

      subject.tick!

      expect(subject.has_life_at?(1, 1)).to be_false
    end
  end

  context 'Rule #2: Any live cell with two or three live neighbours lives on to the next generation.' do
    it 'cell stays alife when has 2 neighbour' do
      subject.create_life_at(1, 0)
      subject.create_life_at(1, 2)

      subject.tick!

      expect(subject.has_life_at?(1, 1)).to be_true
    end

    it 'cell stays alife when has 3 neighbour' do
      subject.create_life_at(1, 0)
      subject.create_life_at(1, 2)
      subject.create_life_at(0, 0)

      subject.tick!

      expect(subject.has_life_at?(1, 1)).to be_true
    end
  end
end
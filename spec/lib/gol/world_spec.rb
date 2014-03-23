require 'spec_helper'

describe World do

  context 'Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do

    before do
      subject.create_life_at(1, 1)
    end

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
end
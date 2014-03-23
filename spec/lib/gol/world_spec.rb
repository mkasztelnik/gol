require 'spec_helper'

describe World do

  context 'with living cell' do
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

    context 'Rule #3: Any live cell with more than three live neighbours dies, as if by overcrowding.' do
      it 'cell is dead when has 4 neighbour' do
        subject.create_life_at(0, 0)
        subject.create_life_at(0, 1)
        subject.create_life_at(0, 2)
        subject.create_life_at(1, 0)

        subject.tick!

        expect(subject.has_life_at?(1, 1)).to be_false
      end

      it 'cell is dead when has 5 neighbour' do
        subject.create_life_at(0, 0)
        subject.create_life_at(0, 1)
        subject.create_life_at(0, 2)
        subject.create_life_at(1, 0)
        subject.create_life_at(1, 2)

        subject.tick!

        expect(subject.has_life_at?(1, 1)).to be_false
      end

      it 'cell is dead when has 6 neighbour' do
        subject.create_life_at(0, 0)
        subject.create_life_at(0, 1)
        subject.create_life_at(0, 2)
        subject.create_life_at(1, 0)
        subject.create_life_at(1, 2)
        subject.create_life_at(2, 0)


        subject.tick!

        expect(subject.has_life_at?(1, 1)).to be_false
      end

      it 'cell is dead when has 7 neighbour' do
        subject.create_life_at(0, 0)
        subject.create_life_at(0, 1)
        subject.create_life_at(0, 2)
        subject.create_life_at(1, 0)
        subject.create_life_at(1, 2)
        subject.create_life_at(2, 0)
        subject.create_life_at(2, 1)


        subject.tick!

        expect(subject.has_life_at?(1, 1)).to be_false
      end

      it 'cell is dead when has 8 neighbour' do
        subject.create_life_at(0, 0)
        subject.create_life_at(0, 1)
        subject.create_life_at(0, 2)
        subject.create_life_at(1, 0)
        subject.create_life_at(1, 2)
        subject.create_life_at(2, 0)
        subject.create_life_at(2, 1)
        subject.create_life_at(2, 2)

        subject.tick!

        expect(subject.has_life_at?(1, 1)).to be_false
      end
    end
  end

  context 'with dead cell' do
    context 'Rule #4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.' do

      it 'brings cell to life if cell has 3 neighbours' do
        subject.create_life_at(0, 0)
        subject.create_life_at(1, 0)
        subject.create_life_at(0, 1)

        subject.tick!

        expect(subject.has_life_at?(1, 1)).to be_true
      end
    end
  end
end
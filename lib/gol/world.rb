class World

  def initialize
    @alife_cells = Set.new
  end

  def create_life_at(x, y)
    @alife_cells.add([x, y])
  end

  def tick!
    @alife_cells = (
        cells_alife_in_next_gen +
        cells_binged_to_life_in_next_gen
      ).to_set
  end

  def has_life_at?(x, y)
    @alife_cells.include?([x, y])
  end

  private

  def cells_alife_in_next_gen
    @alife_cells.select do |point|
      neighbours_count(point).between?(2, 3)
    end
  end

  def cells_binged_to_life_in_next_gen
    new_generation = []
    @alife_cells.each do |point|
      new_generation = new_generation
        + new_lifes_around_point(*point)
    end
    new_generation
  end

  def new_lifes_around_point(x, y)
    dead_neighbours_for(x, y).select do |point|
      neighbours_count(point) == 3
    end
  end

  def neighbours_count(point)
    NEIGHBOURS_OFFSETS.inject(0) do |sum, offset|
      sum += 1 if has_life_at?(*offset_point(point, offset))
      sum
    end
  end

  def dead_neighbours_for(x, y)
    NEIGHBOURS_OFFSETS
      .collect { |offset| offset_point([x, y], offset) }
        .select { |point| !has_life_at?(*point) }
  end

  def offset_point(point, offset)
    [point[0] + offset[0], point[0] + offset[1]]
  end

  NEIGHBOURS_OFFSETS = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1]
  ]
end
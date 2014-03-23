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
      dead_neighbours_for(*point).each do |point|
        new_generation << point if neighbours_count(point) == 3
      end
    end
    new_generation
  end

  def dead_neighbours_for(x, y)
    NEIGHBOURS_OFFSETS
      .collect { |offset| offset_point([x, y], offset) }
        .select { |point| !has_life_at?(*point) }
  end

  NEIGHBOURS_OFFSETS = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1]
  ]

  def neighbours_count(point)
    NEIGHBOURS_OFFSETS.inject(0) do |sum, offset|
      sum += 1 if has_life_at?(*offset_point(point, offset))
      sum
    end
  end

  def offset_point(point, offset)
    [point[0] + offset[0], point[0] + offset[1]]
  end
end
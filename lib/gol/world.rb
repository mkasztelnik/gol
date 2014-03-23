class World

  def initialize
    @alife_cells = Set.new
  end

  def create_life_at(x, y)
    @alife_cells.add(Point.new(x, y))
  end

  def tick!
    @alife_cells = cells_alife_in_next_gen
      .concat(cells_binged_to_life_in_next_gen).to_set
  end

  def has_life_at?(x, y)
    @alife_cells.include?(Point.new(x, y))
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
      dead_neighbours = @@neighbours_offset.select do |offset|
        point_with_offset = offset_point(point, offset)

        !has_life_at?(point_with_offset[0], point_with_offset[1])
      end.collect do |offset|
        Point.new(*offset_point(point, offset))
      end

      dead_neighbours_for(point).each do |point|
        new_generation << point if neighbours_count(point) == 3
      end
    end
    new_generation
  end

  def dead_neighbours_for(point)
    @@neighbours_offset.select do |offset|
      point_with_offset = offset_point(point, offset)

      !has_life_at?(point_with_offset[0], point_with_offset[1])
    end.collect do |offset|
      Point.new(*offset_point(point, offset))
    end
  end

  @@neighbours_offset = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1]
  ]

  def neighbours_count(point)
    @@neighbours_offset.select do |offset|
      has_life_at?(*offset_point(point, offset))
    end.size
  end

  def offset_point(point, offset)
    [point.x + offset[0], point.y + offset[1]]
  end

  class Point
    attr_reader :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def eql?(point)
      x == point.x && y == point.y
    end

    def hash
      [x, y].hash
    end
  end
end
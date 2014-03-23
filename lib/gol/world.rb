class World

  def initialize
    @alife_cells = Set.new
  end

  def create_life_at(x, y)
    @alife_cells.add(Point.new(x, y))
  end

  def tick!
    new_generation = @alife_cells.select do |point|
      neighbours_count(point).between?(2, 3)
    end

    @alife_cells = new_generation.to_set
  end

  def has_life_at?(x, y)
    @alife_cells.include?(Point.new(x, y))
  end

  private

  @@neighbours_offset = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1]
  ]

  def neighbours_count(point)
    @@neighbours_offset.select do |offset|
      has_life_at?(point.x + offset[0], point.y + offset[1])
    end.size
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
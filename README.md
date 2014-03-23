# Gol

Simple implementation of [Conway's Game of Life](http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) kata.

## Installation

Add this line to your application's Gemfile:

    gem 'gol'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gol

## Usage

```ruby
require 'gol'

world = World.new
world.create_life_at(1, 1)
...
world.tick!
world.has_life_at?(1, 1)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

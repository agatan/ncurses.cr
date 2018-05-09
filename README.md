# ncurses

`ncurses.cr` is a Crystal binding to the C ncurses library.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  ncurses:
    github: agatan/ncurses.cr
```

You also need to install the ncurses library.
e.g. in ubuntu, `sudo apt install libncursesw5-dev`


## Usage

```crystal
require "ncurses"

NCurses.open do
  # initialize
  NCurses.cbreak
  NCurses.noecho
  NCurses.start_color

  # define background color
  pair = NCurses::ColorPair.new(1).init(NCurses::Color::RED, NCurses::Color::BLACK)
  NCurses.bkgd(pair)

  NCurses.erase
  # move the cursor
  NCurses.move(x: 0, y: 1)
  # longname returns the verbose description of the current terminal
  NCurses.addstr(NCurses.longname)

  NCurses.move(x: 0, y: 2)
  NCurses.addstr(NCurses.curses_version)

  NCurses.move(y: 10, x: 20)
  NCurses.addstr("Hello, world!")
  NCurses.refresh

  NCurses.notimeout(true)
  NCurses.getch
end
```

### Examples

See `example/` for more examples.

## Contributing

1. Fork it ( https://github.com/[your-github-name]/ncurses/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [agatan](https://github.com/agatan) Naomichi Agata - creator, maintainer

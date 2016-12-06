require "./ncurses/*"

module NCurses
  extend self

  alias KeyCode = LibNCurses::KeyCode

  @@stdscr : Window | Nil = nil

  def open
    @@stdscr = Window.new(LibNCurses.initscr)
    begin
      yield
    ensure
      LibNCurses.endwin
    end
  end

  def stdscr
    scr = @@stdscr
    raise "ncurses not yet initialized" unless scr
    scr
  end

  macro ncurses_bits(mask, shift)
    ({{mask}} << ({{shift}} + LibNCurses::ATTR_SHIFT))
  end

  macro color_pair(i)
    NCurses.ncurses_bits({{i}}, 0)
  end

  macro defwrapper(*names)
    {% for name in names %}
    def {{name}}
      result = LibNCurses.{{name}}
      if result == LibNCurses::Result::ERR
        raise "ncurses failure: #{ {{name.stringify}} }"
      end
      result
    end
    {% end %}
  end

  defwrapper raw, noraw, echo, noecho, cbreak, nocbreak, start_color

  macro def_stdscr(name, *args)
    def {{name}}({{*args}})
      stdscr.{{name}}({{*args}})
    end
  end

  def_stdscr keypad, enable
  def_stdscr notimeout, enable
  def_stdscr getch
  def_stdscr addch, ch
  def_stdscr addch, ch, attr
  def_stdscr mvaddch, ch, y, x
  def_stdscr mvaddch, ch, attr, y, x
  def_stdscr erase
  def_stdscr move, x, y
  def_stdscr addstr, s
  def_stdscr refresh
  def_stdscr getmaxx
  def_stdscr getmaxy
  def_stdscr getmaxyx
  def_stdscr attron, attr
  def_stdscr attroff, attr
  def_stdscr attrset, attr

  def attron(attr : Attribute, &blk)
    stdscr.attron(attr, &blk)
  end

  # Color
  def init_pair(id, fg, bg)
    result = LibNCurses.init_pair(id, fg, bg)
    if result == LibNCurses::Result::ERR
      raise "ncurses failure: init_color"
    end
    result
  end

  def bkgd(cpair : ColorPair)
    stdscr.bkgd(cpair)
  end

end


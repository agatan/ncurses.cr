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
  def_stdscr erase

  # Color
  def init_pair(id, fg, bg)
    result = LibNCurses.init_pair(id, fg, bg)
    if result == LibNCurses::Result::ERR
      raise "ncurses failure: init_color"
    end
    result
  end

  def bkgd(color_id)
    stdscr.bkgd(color_id)
  end

end

NCurses.open do
  NCurses.cbreak
  NCurses.noecho
  NCurses.keypad(true)
  NCurses.notimeout(true)
  NCurses.start_color
  NCurses.init_pair(1, LibNCurses::Color::RED, LibNCurses::Color::BLUE)
  NCurses.bkgd(NCurses.color_pair(1))
  loop do
    x = NCurses.getch
    if x == 0x04 # CTRL_D
      break
    elsif x == LibNCurses::KeyCode::LEFT.value
      NCurses.erase
    end
    NCurses.addch(x)
  end
end


require "./libncurses"

module NCurses
  class Window
    def initialize(@win : LibNCurses::Window)
      @closed = false
    end

    def to_unsafe
      @win
    end

    def finalize
      close
    end

    def close
      return if @closed
      LibNCurses.delwin(@win)
      @closed = true
    end

    private def check_error(r, msg)
      if r == LibNCurses::Result::ERR
        raise "ncurses failure: #{msg}"
      end
      r
    end

    def keypad(enable)
      check_error(LibNCurses.keypad(@win, enable), "keypad")
    end

    def notimeout(enable : Bool)
      check_error(LibNCurses.notimeout(@win, enable), "notimeout")
    end

    def getch
      key = check_error(LibNCurses.wgetch(@win), "wgetch")
      KeyCode.from_value?(key) || key
    end

    def erase
      check_error(LibNCurses.werase(@win), "werase")
    end

    private def addch(ch : LibNCurses::Chtype)
      check_error(LibNCurses.waddch(@win, ch), "waddch")
    end

    private def mvaddch(y, x, ch : LibNCurses::Chtype)
      check_error(LibNCurses.mvwaddch(@win, y, x, ch), "mvwaddch")
    end

    def addch(ch : Char)
      addch(ch.ord.to_u32)
    end

    def addch(ch : Char, attr : Attribute)
      addch((ch.ord | attr.value).to_u32)
    end

    def mvaddch(ch : Char, y, x)
      mvaddch(y, x, ch.ord.to_u32)
    end

    def mvaddch(ch : Char, attr : Attribute, y, x)
      mvaddch(y, x, (ch.ord | attr.value).to_u32)
    end

    def bkgd(cpair : ColorPair)
      check_error(LibNCurses.wbkgd(@win, cpair.attr), "wbkgd")
    end

    def move(y, x)
      check_error(LibNCurses.wmove(@win, y, x), "wmove")
    end

    def addstr(s)
      check_error(LibNCurses.waddnstr(@win, s.to_unsafe, s.bytesize), "waddnstr")
    end

    def refresh
      check_error(LibNCurses.wrefresh(@win), "wrefresh")
    end

    macro def_w(name, *args)
      def {{name}}({{*args}})
        check_error(LibNCurses.w{{name}}(@win, {{*args}}), {{name.stringify}})
      end
    end

    def attron(attr : Attribute)
      check_error(LibNCurses.wattron(@win, attr.value), "wattron")
    end

    def attron(attr : Attribute, &blk)
      check_error(LibNCurses.wattron(@win, attr.value), "wattron")
      begin
        yield
      ensure
        attroff(attr)
      end
    end

    def attroff(attr : Attribute)
      check_error(LibNCurses.wattroff(@win, attr.value), "wattron")
    end

    def attrset(attr : Attribute)
      check_error(LibNCurses.wattrset(@win, attr.value), "wattron")
    end

    macro defcurses(name, *args)
      def {{name}}({{*args}})
        check_error(LibNCurses.{{name}}(@win, {{*args}}), {{name.stringify}})
      end
    end

    defcurses getmaxx
    defcurses getmaxy

    def getmaxyx
      [getmaxy, getmaxx]
    end

  end
end

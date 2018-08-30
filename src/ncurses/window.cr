require "./libncurses"
require "./raw_window"

module NCurses
  class Window
    include RawWindow

    def initialize(@win : LibNCurses::Window)
      @closed = false
    end

    def initialize(height, width, y, x)
      @win = LibNCurses.newwin(height, width, y, x)
      @closed = false
    end

    def self.open(height, width, y, x, &blk)
      win = new(height, width, y, x)
      begin
        yield win
      ensure
        win.close
      end
    end

    def self.subwin(height, width, y, x, parent, &blk)
      win = new(LibNCurses.subwin(parent, height, width, y, x))
      begin
        yield win
      ensure
        win.close
      end
    end

    def self.derwin(height, width, y, x, parent, &blk)
      win = new(LibNCurses.derwin(parent, height, width, y, x))
      begin
        yield win
      ensure
        win.close
      end
    end

    def finalize
      close
    end

    def close
      return if @closed
      LibNCurses.delwin(@win)
      @closed = true
    end

    def to_unsafe
      @win
    end

    protected def raw_win
      @win
    end

    def refresh
      check_error(LibNCurses.wrefresh(@win), "wrefresh")
    end
  end
end

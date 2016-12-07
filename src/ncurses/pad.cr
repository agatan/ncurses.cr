require "./libncurses"
require "./raw_window"

module NCurses
  class Pad
    include RawWindow

    def initialize(height, width)
      @win = LibNCurses.newpad(height, width)
      @closed = false
    end

    def self.open(height, width)
      pad = new(height, width)
      begin
        yield pad
      ensure
        pad.close
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

    def refresh(px, py, sminrow, smincol, smaxrow, smaxcol)
      check_error(
        LibNCurses.prefresh(@win, px, py, sminrow, smincol, smaxrow, smaxcol),
        "prefresh")
    end
  end
end

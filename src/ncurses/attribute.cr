require "./libncurses"

module NCurses
  alias Attribute = LibNCurses::Attribute
  alias Color = LibNCurses::Color

  struct ColorPair
    def initialize(@id : Int32)
    end

    def init(fg : Color, bg : Color)
      if LibNCurses.init_pair(@id, fg.value, bg.value) == LibNCurses::Result::ERR
        raise "ncurses failure: init_pair"
      end
      self
    end

    def attr
      Attribute.new(NCurses.ncurses_bits(@id, 0).to_u32)
    end
  end

  def max_color_pairs
    LibNCurses.color_pairs.as(Int32)
  end

  def colors
    (1...LibNCurses.colors).map { |c| Color.new(c.to_u32) }
  end

  def use_default_colors
    if LibNCurses.use_default_colors == LibNCurses::Result::ERR
      raise "ncurses failure: use_default_colors"
    end
  end
end

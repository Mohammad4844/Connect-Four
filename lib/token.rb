class Token
  attr_reader :color

  def initialize(color = 'empty')
    @color = color
  end

  def ==(other)
    self.color == other.color
  end

  def to_s
    color_code
  end

  private 

  def color_code
    case @color
    when 'empty' then "\e[0m\u25CB\e[0m"
    when 'red' then "\e[31m\u25CF\e[0m"
    when 'green' then "\e[32m\u25CF\e[0m"
    when 'yellow' then "\e[33m\u25CF\e[0m"
    when 'blue' then "\e[34m\u25CF\e[0m"
    when 'pink' then "\e[35m\u25CF\e[0m"
    when 'cyan' then "\e[36m\u25CF\e[0m"
    end
  end
end

class Cell

  attr_accessor :num
  attr_accessor :edges
  attr_accessor :dist
  attr_accessor :pred
  attr_accessor :coor

  def initialize (coor, arg, num, cols)
    @coor=coor
    @arg=arg
    @num=num
    @cols=cols
    @col_nums=2*@cols+1
    @top=coor-@col_nums
    @bottom=coor+@col_nums
    @left=coor-1
    @right=coor+1
    @edges=[]
    @dist=Float::INFINITY
    @pred=nil
  end

  def add_edges
    if @arg[@top]=="0"
      @edges.push(Cell.new(@top-@col_nums, @arg, @num-@cols, @cols))
    end
    if @arg[@bottom]=="0"
      @edges.push(Cell.new(@bottom+@col_nums, @arg, @num+@cols, @cols))
    end
    if @arg[@left]=="0"
      @edges.push(Cell.new(@coor-2, @arg, @num-1, @cols))
    end
    if @arg[@right]=="0"
      @edges.push(Cell.new(@coor+2, @arg, @num+1, @cols))
    end
    if @edges.empty?
      puts "Warning: Detected closed cell"
    elsif @edges.size == 4
      puts "Warning: Detected floating cell"
    end
  end

  def to_s
    @num.to_s
  end

  def ==(other)
    other.class == self.class && other.state == state
  end

  def state
    [@coor, @num]
  end

end

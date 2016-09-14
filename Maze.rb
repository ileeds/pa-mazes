require_relative 'Cell.rb'
require_relative 'Graph.rb'

class Maze

  def initialize (n, m)
    @rows = n
    @cols = m
    @row_nums=2*n+1
    @col_nums=2*@cols+1
    @arg
    @graph=Graph.new
    @cell_num=0
    @trace_path=[]
  end

  def load (arg)
    @arg=arg
    size = @row_nums*@col_nums
    check_valid(size)
  end

  def display (solved=false)
    (0..@row_nums*@col_nums-1).each do |i|
      if i % @col_nums == 0
        puts ""
      end
      if (@trace_path.include? i) && (solved==true)
        print "+"
      elsif @arg[i]=="1"
        print "X"
      else
        print " "
      end
    end
    puts ""
    puts ""
  end

  def solve (begX, begY, endX, endY)
    beg_num=begX*@cols+begY
    end_num=endX*@cols+endY
    beg_cell = @graph.cells[beg_num]
    end_cell = @graph.cells[end_num]
    beg_cell.dist=0
    s=[]
    q=@graph.cells.values
    while !q.empty?
      u=q.min_by(&:dist)
      q.delete(u)
      s.push(u)
      @graph.cells[u.num].edges.each do |i|
        if @graph.cells[i.num].dist > @graph.cells[u.num].dist+1
          @graph.cells[i.num].dist = @graph.cells[u.num].dist+1
          @graph.cells[i.num].pred = @graph.cells[u.num]
        end
      end
    end
    if end_cell.dist != Float::INFINITY
      puts "\nIt is solvable!\n\n"
      return true
    else
      puts "\nIt is not solvable!\n\n"
      return false
    end
  end

  def trace (begX, begY, endX, endY)
    worked=solve(begX, begY, endX, endY)
    if worked==true
      beg_num=begX*@cols+begY
      end_num=endX*@cols+endY
      end_cell = @graph.cells[end_num]
      @trace_path.push(@graph.cells[end_num].coor)
      end_num=coordinate(end_num)
      path="(In reverse) #{end_num}, "
      while end_cell.pred.num != beg_num
        @trace_path.push(@graph.cells[end_cell.pred.num].coor)
        path+="#{coordinate(end_cell.pred.num)}, "
        end_cell=end_cell.pred
      end
      puts path+coordinate(beg_num)
      @trace_path.push(@graph.cells[beg_num].coor)
      display(true)
    end
  end

  #makes sure maze has 1's for outer walls and 0's for center of cells
  #calls make_cell
  def check_valid (size)
    #checks length of string correct according to n x m
    if @arg.length != size
      puts "String length incorrect"
    end
    #checks if outer wall is all 1's
    string=''
    @col_nums.times do
      string+='1'
    end
    if !@arg[0..@col_nums-1].eql? string
      puts "Invalid maze (outer wall)"
    end
    (0..@row_nums*@col_nums-1).step(@col_nums) do |i|
      if @arg[i] != "1" || @arg[i-1] != "1"
        puts "Invalid maze (outer wall)"
        break
      end
    end
    #cell centers should be 0's
    #takes values of cell centers and uses coordinates for make_cell method
    (@col_nums..@row_nums*@col_nums-1).step(@col_nums*2) do |i|
      (1..@col_nums-2).step(2) do |j|
        if @arg[i+j]!="0"
          puts "Invalid maze (cell center)"
          break
        else
          make_cell(i+j)
        end
      end
    end
    #cell corners should be 1's
    (0..@row_nums*@col_nums-1).step(@col_nums*2) do |i|
      (0..@col_nums-2).step(2) do |j|
        if @arg[i+j]!="1"
          puts "Invalid maze (cell corner)"
          break
        end
      end
    end
  end

  def make_cell (coor)
    a=Cell.new(coor, @arg, @cell_num, @cols)
    @graph.add_cell(a)
    @cell_num+=1
  end

  def coordinate (num)
    x_coor=(num / @cols)
    y_coor=(num % @cols)
    return "(#{x_coor}, #{y_coor})"
  end


end

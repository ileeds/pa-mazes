require_relative 'Cell.rb'

class Graph

  attr_accessor :cells

  def initialize
    @cells={}
  end

  def add_cell (cell)
    cell.add_edges
    @cells[cell.num] = cell
  end

end

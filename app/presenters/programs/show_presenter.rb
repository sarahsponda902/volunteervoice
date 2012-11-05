class Programs::ShowPresenter
  def initialize(program_id)
    @program = Program.find(program_id)
  end
  
  #returns the program
  def this_program
    @program
  end
  
  # table entries for cost & length table on program profile
  def entries
    @entries = []
    @program.program_cost_length_maps.sort_by(&:length).each do |p|
      @entries << [(p.length / 604800).round, p.cost]
    end
    @entries
  end

  # reviews on program profile
  def results
    Review.where(:program_id => @program.id).sort_by(&:created_at).reverse
  end
  
  # overall review average for program
  def overall
    @overall = 0
    @results = @program.reviews
    @results.each do |f|
      @overall = @overall + f.overall
    end
    if @results.count != 0
      @overall = @overall / @results.count
    else
      @overall = 0
    end
  end
end
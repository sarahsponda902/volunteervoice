module ProgramsHelper

  # creates program_subject objects corresponding to @program.program_subjects
  # called by #create & #update in programs_controller
  [[ProgramSubject, :subject], [ProgramSize, :size], [ProgramCostLengthMap, :cost]].each do |klass, type|
    define_method "make_program_#{type.to_s}s" do |objs, org_id, program_id = nil|
      @objects = []
      unless objs.nil?
        objs.split(", ").each do |obj|
          @p = klass.new(type => obj, :organization_id => org_id, :program_id => program_id)
          @objects << @p
        end
      end
      @objects
    end
  end


  # creates program_cost_length_map objects corresponding to @program.costs & @program.lengths
  # called by #create & #update in programs_controller
  def make_program_cost_length_maps(costs, lengths, org_id, program_id = nil)     
    @cost_lengths = make_program_costs(costs, org_id, program_id)
    count = 0
    if !lengths.nil?
      # SECOND: add the corresponding lengths to each cost-only cost_length_map
      lengths.each do |lngth|
        @p = @cost_lengths[count]
        @length = lngth.split(" ") # split '1 week' into ["1", "week"]
        @p.length = @length[0].to_i.send(@length[1]).to_f # save 1.week (length of time in miliseconds)
        @p.length_name = @length[1] # save 'week'
        @p.length_number = @length[0] # save '1'
        @cost_lengths[count] = @p # add new length object to array in spot corresponding to its cost
        count = count + 1
      end
    end
    #return:
    @cost_lengths
  end
end

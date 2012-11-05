module ProgramsHelper

  # creates program_subject objects corresponding to @program.program_subjects
  # called by #create & #update in programs_controller
  def make_program_subjects(subjects, org_id, program_id = nil)
    @subjects = []
    if !subjects.nil?
      subjects.split(", ").each do |subj| #subjects passed in string & separated by comma (string created by autocomplete)
        # ProgramSubject object created WITHOUT program_id, and updated WITH program_id
        @p = ProgramSubject.new(:subject => subj, :organization_id => org_id, :program_id => program_id)
        @subjects << @p
      end
    end
    @subjects
  end


  # creates program_size objects corresponding to @program.program_sizes
  # called by #create & #update in programs_controller
  def make_program_sizes(sizes, org_id, program_id = nil) 
    @sizes = []
    if !sizes.nil?
      sizes.each do |size|
        if size[1] != 0
          # ProgramSize object created WITHOUT program_id, and updated WITH program_id
          @p = ProgramSize.new(:size => f[1], :organization_id => org_id, :program_id => program_id)
          @sizes << @p
        end
      end
      @sizes
    end


    # creates program_cost_length_map objects corresponding to @program.costs & @program.lengths
    # called by #create & #update in programs_controller
    def make_program_cost_length_maps(costs, lengths, org_id, program_id = nil)     
      @cost_lengths = []
      if !costs.nil?
        # FIRST: create cost_length_maps with ONLY cost, org_id, and (if update) program_id parameters
        costs.each do |cost|
          # ProgramCostLengthMap object created WITHOUT program_id, and updated WITH program_id
          @p = ProgramCostLengthMap.new(:cost => cost.to_f, :organization_id => org_id, :program_id => program_id)
          @cost_lengths << @p
        end
      end

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
end

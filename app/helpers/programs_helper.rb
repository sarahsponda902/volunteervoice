module ProgramsHelper
  

  def make_program_subjects(subjects, org_id, program_id = nil)
    @subjects = []
    if !subjects.nil?
      subjects.split(", ").each do |f|
        @p = ProgramSubject.new(:subject => f, :organization_id => org_id, :program_id => program_id)
        @subjects << @p
      end
    end
    @subjects
  end

  def make_program_sizes(sizes, org_id, program_id = nil) 
    @sizes = []
    if !sizes.nil?
      sizes.each do |f|
        if f[1] != 0
          @p = ProgramSize.new(:size => f[1], :organization_id => org_id, :program_id => program_id)
          @sizes << @p
        end
      end
      @sizes
    end


    def make_program_cost_length_maps(costs, lengths, org_id, program_id = nil)     
      @cost_lengths = []
      if !costs.nil?
        costs.each do |f|
          @p = ProgramCostLengthMap.new(:cost => f.to_f, :organization_id => org_id, :program_id => program_id)
          @cost_lengths << @p
        end
      end

      count = 0
      if !lengths.nil?
        lengths.each do |f|
          @p = @cost_lengths[count]
          @length = f.split(" ")
          @p.length = @length[0].to_i.send(@length[1]).to_f
          @p.length_name = @length[1]
          @p.length_number = @length[0]
          @cost_lengths[count] = @p
          count = count + 1
        end
      end
      @cost_lengths
    end
  end
end

class Organizations::ShowPresenter
  def initialize(org_id)
    @organization = Organization.find(org_id)
    # saving page views count
    @organization.page_views = (@organization.page_views + 1)
    @organization.save
  end
  
  # returns organization
  def this_organization
    @organization
  end

  # for cost chart table
  def cost_length_table_entries
    # getting sorted, unique cost-lengths for this organization
    @sorted = ProgramCostLengthMap.where(:organization_id => @organization.id).sort_by(&:length)
    @unique_cost_lengths = @sorted.uniq

    # grouping cost-lengths by length
    @grouped = []
    @unique_cost_lengths.each do |u|
      @grouped << ProgramCostLengthMap.where(:organization_id => @organization.id, :length => u.length)
    end

    # sort each group by cost
    #  then add (length, lowest cost, highest cost) to table entries
    @entries = []
    @grouped.each do |g|
      unless g.empty?
        @sorted_group = g.sort_by(&:cost)
        @entries << [(g.first.length / 604800).round, g.first.cost, g.last.cost]
      end
    end

    #return the table entries
    @entries
  end

  # return all organization's reviews ordered by created_at
  def reviews_of_organization
    Review.where(:organization_id => @organization.id).sort_by(&:created_at).reverse
  end

  #return overall = (total overall score) / (total # reviews)
  def overall
    @overall = 0
    if (num_reviews = @organization.reviews.count) != 0 # can't divide by zero
      @organization.reviews.each do |r|
        @overall = @overall + r.overall
      end
      @overall = @overall / num_reviews.count
    end
    @overall
  end

  # returns all program_subjects associated with that org
  def program_subjects
    @organization.program_subjects.map(&:subject).uniq
  end

  # returns all group_sizes associated with that org
  def group_sizes
    @organization.program_sizes.map(&:size).uniq
  end

  # returns all program_lengths associated with that org
  def program_lengths
    @organization.program_cost_length_maps.uniq.sort_by(&:length).map{|f| [f.length_number, f.length_name].join(" ")}
  end
  
  # returns all program_subjects associated with that org
  def types_of_programs
    @organization.programs.map(&:subject).uniq
  end

end
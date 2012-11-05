# == Schema Information
#
# Table name: searches
#
#  id                :integer          not null, primary key
#  regions           :text
#  subjects          :text
#  sizes             :text
#  price_min         :integer
#  price_max         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  showing           :string(255)
#  sort_by           :string(255)
#  keywords          :string(255)
#  sent_from         :string(255)
#  length_min_number :integer
#  length_min_param  :string(255)
#  length_max_number :integer
#  length_max_param  :string(255)
#

class Search < ActiveRecord::Base
  # does all the searching and returns results based on the parameters above
  # searches through 3 models: programs, organizations, and cost-length-maps
  def self.search_results
    
    # set the search parameters for sunspot to use
    keys = self.keywords
    subjects = self.subjects.nil? ? [] : self.subjects.split("; ")
    regions = self.regions.nil? ? [] : self.regions.split("; ")
    sizes = self.sizes.nil? ? [] : self.sizes.split("; ")
    price_max = self.price_max.nil? ? 0 : self.price_max
    price_min = self.price_min.nil? ? 99999 : self.price_min
    
      # set the minimum length
    self.length_min_number ||= 0
    self.length_min_param ||= "weeks"
    length_min = self.length_min_number.to_i.send(self.length_min_param).to_f
    
      # set the maximum length
    self.length_max_number ||= 2
    self.length_max_param ||= "years"
    length_max = self.length_max_number.to_i.send(self.length_max_param).to_f

    # search for programs with the given params
    @program_search = Program.search do
      keywords keys unless keys.blank?

      with(:program_subjects).any_of(subjects)

      with(:location).any_of(:regions)

      with(:program_sizes).any_of(:sizes)

    end
    @program_results = @program_search.results


    # if the user has changed the default prices, search through cost-length maps
    if (price_max != 99999 || price_min != 0 || length_min != 0.weeks.to_f || length_max != 2.years.to_f )

      # Cost Length search
      @cost_length_search = ProgramCostLengthMap.search do
        all_of do
          with(:length).greater_than(:length_min)
          with(:length).less_than(:length_max)
          with(:cost).greater_than(:price_min)
          with(:cost).less_than(:price_max)
        end      
      end

      # iterate through cost length maps and get the programs associated with them
      @program_cost_length_results = @cost_length_search.results.map {|res| Program.find(res.program_id)}.uniq

      # union (without duplicates) of program_cost_length_results and program_results
      @final_results = @program_cost_length_results | @program_results
    else # if no search through cost_length_maps
      @final_results = @program_results
    end

    # set self.showing if nil to 'Organizations'
    self.showing ||= "Organizations"

    # if showing organizations, switch results over to orgs (by mapping progs => orgs)
    if showing == "Organizations"
      @final_results = results.map{|res| Organization.find(p.organization_id)}.uniq
    end

    # do a third search, to determine if there are organizations we missed because they have no programs
    @second_search = Organization.search do 
      keywords :keys unless :keys.nil?
    end

    #just in case second_search is nil
    @second_search ||= []

    # add second_search results to final_results
    @final_results = @final_results | @second_search.results

    #sort results given self.sort_by   
    @final_results.sort_by!(&:overall).reverse! if self.sort_by == "ratinghigh"
    @final_results.sort_by!(&:overall) if self.sort_by == "ratinglow"
    @final_results.sort_by!(&:name) if self.sort_by == "alphabetical"
    @final_results.sort_by!(&:weekly_cost) if self.sort_by == "pricelow"
    @final_results.sort_by!(&:weekly_cost).reverse! if self.sort_by == "pricehigh"

    # return results... WE'RE DONE!!!
    @final_results

  end
    
end

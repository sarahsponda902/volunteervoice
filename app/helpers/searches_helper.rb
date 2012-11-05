module SearchesHelper
  
  ##### See config/initializers/constants.rb for constant definitions #####
  
  
  # called by #places method in searches_controller
  # creates a hash of all countries in a given continent that has programs
  # an array of region_numbers (ids) make up a continent
  def make_program_country_hash(region_numbers)
    @continent_hash = Hash.new
    region_numbers.each do |region_number|
      THEREGIONS[region_number].each do |reg| # THEREGIONS is a hash of region_number => all_countries_in_that_region
        if Program.where(:location => reg).present? # if there is a program in that location
          @continent_hash[reg] = THECOUNTRIES[reg] # THECOUNTRIES is a hash of country_abbrev => full_country_name
        end 
      end
    end
    #return:
    @continent_hash
  end
  
  
end

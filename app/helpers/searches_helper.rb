module SearchesHelper
  
  def make_program_country_hash(region_numbers)
    @continent_hash = Hash.new
    region_numbers.each do |region_number|
      THEREGIONS[region_number].each do |f|
        if !(Program.where(:location => f).empty?) # if there is a program in that location
          @continent_hash[f] = THECOUNTRIES[f]
        end 
      end
    end
    @continent_hash
  end
  
  
  
  
end

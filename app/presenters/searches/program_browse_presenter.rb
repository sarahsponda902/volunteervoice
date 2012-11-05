class Searches::ProgramBrowsePresenter
  
  def initialize()
  end
  
  def organic_farming 
    ProgramSubject.where(:subject => "Organic Farming")
  end
  
  def sustainable_development 
    ProgramSubject.where(:subject => "Sustainable Development")
  end
  
  def animal_rights 
    ProgramSubject.where(:subject => "Animal Rights")
  end
  
  def wildlife_conservation 
    ProgramSubject.where(:subject => "Wildlife Conservation")
  end
  
  def elder_care 
    ProgramSubject.where(:subject => "Elder Care")
  end
  
  def child_orphan_care 
    ProgramSubject.where(:subject => "Child/Orphan Care")
  end
  
  def disabled_care 
    ProgramSubject.where(:subject => "Disabled Care")
  end
  
  def feed_the_homeless 
    ProgramSubject.where(:subject => "Feed the Homeless")
  end
  
  def youth_development_and_outreach 
    ProgramSubject.where(:subject => "Youth Development and Outreach")
  end
  
  def performing_arts 
    ProgramSubject.where(:subject => "Performing Arts")
  end
  
  def fashion 
    ProgramSubject.where(:subject => "Fashion")
  end
  
  def music 
    ProgramSubject.where(:subject => "Music")
  end
  
  def sports_and_recreation 
    ProgramSubject.where(:subject => "Sports & Recreation")
  end
  
  def journalism 
    ProgramSubject.where(:subject => "Journalism")
  end
  
  def economics 
    ProgramSubject.where(:subject => "Economics")
  end
  
  def microfinance 
    ProgramSubject.where(:subject => "Microfinance")
  end
  
  def teaching_english 
    ProgramSubject.where(:subject => "Teaching English")
  end
  
  def teaching_buddhist_monks 
    ProgramSubject.where(:subject => "Teaching Buddhist Monks")
  end
  
  def teaching_children 
    ProgramSubject.where(:subject => "Teaching Children")
  end
  
  def teaching_computer_literacy 
    ProgramSubject.where(:subject => "Teaching Computer Literacy")
  end
  
  def ecological_conservation 
    ProgramSubject.where(:subject => "Ecological Conservation")
  end
  
  def habitat_restoration 
    ProgramSubject.where(:subject => "Habitat Resotration")
  end
  
  def hiv_aids 
    ProgramSubject.where(:subject => "HIV/AIDS")
  end
  
  def nutrition 
    ProgramSubject.where(:subject => "Nutrition")
  end
  
  def family_planning 
    ProgramSubject.where(:subject => "Family Planning")
  end
  
  def veterinary_medicine 
    ProgramSubject.where(:subject => "Veterinary Medicine")
  end
  
  def clinical_work 
    ProgramSubject.where(:subject => "Clinical Work")
  end
  
  def dental_work 
    ProgramSubject.where(:subject => "Dental Work")
  end
  
  def medical_research 
    ProgramSubject.where(:subject => "Medical Research")
  end
  
  def health_education 
    ProgramSubject.where(:subject => "Health Education")
  end
  
  def public_health 
    ProgramSubject.where(:subject => "Public Health")
  end
  
  def hospital_care_giving 
    ProgramSubject.where(:subject => "Hospital Care-giving")
  end
  
  def womens_initiatives 
    ProgramSubject.where(:subject => "Women's Initiatives")
  end
  
  def adventure_travel 
    ProgramSubject.where(:subject => "Adventure Travel")
  end
  
  def archaeology 
    ProgramSubject.where(:subject => "Archaeology")
  end
  
  def environmental_biology 
    ProgramSubject.where(:subject => "Environmental Biology")
  end
  
  def media_marketing_and_graphic_design 
    ProgramSubject.where(:subject => "Media, Marketing, and Graphic Design")
  end



  # start of main subject categories
  def agriculture 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["Agriculture"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def animal_care 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["AnimalCare"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def caregiving 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["Caregiving"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten 
  end
  
  def community_development 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["CommunityDevelopment"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def construction 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["Construction"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def culture_and_community 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["CultureandCommunity"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def disaster_relief 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["DisasterRelief"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def education 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["Education"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def engineering_and_infrastructure 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["EngineeringandInfrastructure"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def environmental 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["Environmental"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def health_and_medicine 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["HealthandMedicine"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def human_rights 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["HumanRights"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def international_work_camp 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["InternationalWorkCamp"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def recreation 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["Recreation"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def scientific_research 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["ScientificResearch"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
  def technology 
    @subjects = []
    HASH_OF_SUBJECT_GROUPS["Technology"].each do |subj|
      @subjects << ProgramSubject.where(:subject => subj)
    end
    @subjects.flatten
  end
  
end
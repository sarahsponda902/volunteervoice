class PagesController < ApplicationController
  
  def home
    @feedbacks = Feedback.where(:show => true)
    @reviews = Review.where(:show => true)
    @organizations = Organization.where(:show => true)
    if !(@reviews.nil?)
    @show_reviews_all = @reviews.sort_by(&:created_at).reverse
    @show_reviews = @show_reviews_all[0..2]
    end
    if !(@organizations.nil?)
    @show_organizations_all = @organizations.sort_by(&:page_views)
    @show_organizations = @show_organizations_all[0..1]
    end
    if !(@feedbacks.nil?)
    @show_feedbacks_all = @feedbacks.shuffle
    @show_feedbacks = @show_feedbacks_all[0..2]
    end
    @feedback = Feedback.new
  end
  
  def program_listing
  	@programs = Program.all
  end
  
  def test
    
  end
  	
  	def profile
  	  ##Profile_Reviews
  	  if (user_signed_in?)
  	  @user = User.find(current_user.id)
  	  @reviews = @user.reviews.order("created_at DESC")
  	  @favorites = @user.favorites
  	  @messages = @user.received_messages
  	  @sent_messages = Message.where(:sender_id => current_user.id, :sender_deleted => nil)
  	  
  	  @theCountries = Hash["AF" => "Afghanistan", 
      "AX" => "Aland Islands", 
      "AL"=> "Albania", 
      "DZ"=> "Algeria", 
      "AS"=> "American Samoa", 
      "AD"=> "Andorra", 
      "AO"=> "Angola", 
      "AI"=> "Anguilla", 
      "AQ"=> "Antarctica", 
      "AG"=> "Antigua and Barbuda", 
      "AR"=> "Argentina", 
      "AM"=> "Armenia", 
      "AW"=> "Aruba", 
      "AU"=> "Australia", 
      "AT"=> "Austria", 
      "AZ"=> "Azerbaijan", 
      "BS"=> "Bahamas", 
      "BH"=> "Bahrain", 
      "BD"=> "Bangladesh", 
      "BB"=> "Barbados", 
      "BY"=> "Belarus", 
      "BE"=> "Belgium", 
      "BZ"=> "Belize", 
      "BJ"=> "Benin", 
      "BM"=> "Bermuda", 
      "BT"=> "Bhutan", 
      "BO"=> "Bolivia, Plurinational State of", 
      "BQ"=> "Bonaire, Sint Eustatius and Saba", 
      "BA"=> "Bosnia and Herzegovina", 
      "BW"=> "Botswana", 
      "BV"=> "Bouvet Island", 
      "BR"=> "Brazil", 
      "IO"=> "British Indian Ocean Territory", 
      "BN"=> "Brunei Darussalam", 
      "BG"=> "Bulgaria", 
      "BF"=> "Burkina Faso", 
      "BI"=> "Burundi", 
      "KH"=> "Cambodia", 
      "CM"=> "Cameroon", 
      "CA"=> "Canada", 
      "CV"=> "Cape Verde", 
      "KY"=> "Cayman Islands", 
      "CF"=> "Central African Republic", 
      "TD"=> "Chad", 
      "CL"=> "Chile", 
      "CN"=> "China", 
      "CX"=> "Christmas Island", 
      "CC"=> "Cocos (Keeling) Islands", 
      "CO"=> "Colombia", 
      "KM"=> "Comoros", 
      "CG"=> "Congo", 
      "CD"=> "Congo, the Democratic Republic of the", 
      "CK"=> "Cook Islands", 
      "CR"=> "Costa Rica", 
      "CI"=> "Cote d'Ivoire", 
      "HR"=> "Croatia", 
      "CU"=> "Cuba", 
      "CW"=> "Curacao", 
      "CY"=> "Cyprus", 
      "CZ"=> "Czech Republic", 
      "DK"=> "Denmark", 
      "DJ"=> "Djibouti", 
      "DM"=> "Dominica", 
      "DO"=> "Dominican Republic", 
      "EC"=> "Ecuador", 
      "EG"=> "Egypt", 
      "SV"=> "El Salvador", 
      "GQ"=> "Equatorial Guinea", 
      "ER"=> "Eritrea", 
      "EE"=> "Estonia", 
      "ET"=> "Ethiopia", 
      "FK"=> "Falkland Islands (Malvinas)", 
      "FO"=> "Faroe Islands", 
      "FJ"=> "Fiji", 
      "FI"=> "Finland", 
      "FR"=> "France", 
      "GF"=> "French Guiana", 
      "PF"=> "French Polynesia", 
      "TF"=> "French Southern Territories", 
      "GA"=> "Gabon", 
      "GM"=> "Gambia", 
      "GE"=> "Georgia", 
      "DE"=> "Germany", 
      "GH"=> "Ghana", 
      "GI"=> "Gibraltar", 
      "GR"=> "Greece", 
      "GL"=> "Greenland", 
      "GD"=> "Grenada", 
      "GP"=> "Guadeloupe", 
      "GU"=> "Guam", 
      "GT"=> "Guatemala", 
      "GG"=> "Guernsey", 
      "GN"=> "Guinea", 
      "GW"=> "Guinea-Bissau", 
      "GY"=> "Guyana", 
      "HT"=> "Haiti", 
      "HM"=> "Heard Island and McDonald Islands", 
      "VA"=> "Holy See (Vatican City State)", 
      "HN"=> "Honduras", 
      "HK"=> "Hong Kong", 
      "HU"=> "Hungary", 
      "IS"=> "Iceland", 
      "IN"=> "India", 
      "ID"=> "Indonesia", 
      "IR"=> "Iran, Islamic Republic of", 
      "IQ"=> "Iraq", 
      "IE"=> "Ireland", 
      "IM"=> "Isle of Man", 
      "IL"=> "Israel", 
      "IT"=> "Italy", 
      "JM"=> "Jamaica", 
      "JP"=> "Japan", 
      "JE"=> "Jersey", 
      "JO"=> "Jordan", 
      "KZ"=> "Kazakhstan", 
      "KE"=> "Kenya", 
      "KI"=> "Kiribati", 
      "KP"=> "Korea, Democratic People's Republic of", 
      "KR"=> "Korea, Republic of", 
      "KW"=> "Kuwait", 
      "KG"=> "Kyrgyzstan", 
      "LA"=> "Lao People's Democratic Republic", 
      "LV"=> "Latvia", 
      "LB"=> "Lebanon", 
      "LS"=> "Lesotho", 
      "LR"=> "Liberia", 
      "LY"=> "Libya", 
      "LI"=> "Liechtenstein", 
      "LT"=> "Lithuania", 
      "LU"=> "Luxembourg", 
      "MO"=> "Macao", 
      "MK"=> "Macedonia, the former Yugoslav Republic of", 
      "MG"=> "Madagascar", 
      "MW"=> "Malawi", 
      "MY"=> "Malaysia", 
      "MV"=> "Maldives", 
      "ML"=> "Mali", 
      "MT"=> "Malta", 
      "MH"=> "Marshall Islands", 
      "MQ"=> "Martinique", 
      "MR"=> "Mauritania", 
      "MU"=> "Mauritius", 
      "YT"=> "Mayotte", 
      "MX"=> "Mexico", 
      "FM"=> "Micronesia, Federated States of", 
      "MD"=> "Moldova, Republic of", 
      "MC"=> "Monaco", 
      "MN"=> "Mongolia", 
      "ME"=> "Montenegro", 
      "MS"=> "Montserrat", 
      "MA"=> "Morocco", 
      "MZ"=> "Mozambique", 
      "MM"=> "Myanmar", 
      "NA"=> "Namibia", 
      "NR"=> "Nauru", 
      "NP"=> "Nepal", 
      "NL"=> "Netherlands", 
      "NC"=> "New Caledonia", 
      "NZ"=> "New Zealand", 
      "NI"=> "Nicaragua", 
      "NE"=> "Niger", 
      "NG"=> "Nigeria", 
      "NU"=> "Niue", 
      "NF"=> "Norfolk Island", 
      "MP"=> "Northern Mariana Islands", 
      "NO"=> "Norway", 
      "OM"=> "Oman", 
      "PK"=> "Pakistan", 
      "PW"=> "Palau", 
      "PS"=> "Palestinian Territory, Occupied", 
      "PA"=> "Panama", 
      "PG"=> "Papua New Guinea", 
      "PY"=> "Paraguay", 
      "PE"=> "Peru", 
      "PH"=> "Philippines", 
      "PN"=> "Pitcairn", 
      "PL"=> "Poland", 
      "PT"=> "Portugal", 
      "PR"=> "Puerto Rico", 
      "QA"=> "Qatar", 
      "RE"=> "Reunion", 
      "RO"=> "Romania", 
      "RU"=> "Russian Federation", 
      "RW"=> "Rwanda", 
      "BL"=> "Saint Barthelemy", 
      "SH"=> "Saint Helena, Ascension and Tristan da Cunha", 
      "KN"=> "Saint Kitts and Nevis", 
      "LC"=> "Saint Lucia", 
      "MF"=> "Saint Martin (French part)", 
      "PM"=> "Saint Pierre and Miquelon", 
      "VC"=> "Saint Vincent and the Grenadines", 
      "WS"=> "Samoa", 
      "SM"=> "San Marino", 
      "ST"=> "Sao Tome and Principe", 
      "SA"=> "Saudi Arabia", 
      "SN"=> "Senegal", 
      "RS"=> "Serbia", 
      "SC"=> "Seychelles", 
      "SL"=> "Sierra Leone", 
      "SG"=> "Singapore", 
      "SX"=> "Sint Maarten (Dutch part)", 
      "SK"=> "Slovakia", 
      "SI"=> "Slovenia", 
      "SB"=> "Solomon Islands", 
      "SO"=> "Somalia", 
      "ZA"=> "South Africa", 
      "GS"=> "South Georgia and the South Sandwich Islands", 
      "SS"=> "South Sudan", 
      "ES"=> "Spain", 
      "LK"=> "Sri Lanka", 
      "SD"=> "Sudan", 
      "SR"=> "Suriname", 
      "SJ"=> "Svalbard and Jan Mayen", 
      "SZ"=> "Swaziland", 
      "SE"=> "Sweden", 
      "CH"=> "Switzerland", 
      "SY"=> "Syrian Arab Republic", 
      "TW"=> "Taiwan, Province of China", 
      "TJ"=> "Tajikistan", 
      "TZ"=> "Tanzania, United Republic of", 
      "TH"=> "Thailand", 
      "TL"=> "Timor-Leste", 
      "TG"=> "Togo", 
      "TK"=> "Tokelau", 
      "TO"=> "Tonga", 
      "TT"=> "Trinidad and Tobago", 
      "TN"=> "Tunisia", 
      "TR"=> "Turkey", 
      "TM"=> "Turkmenistan", 
      "TC"=> "Turks and Caicos Islands", 
      "TV"=> "Tuvalu", 
      "UG"=> "Uganda", 
      "UA"=> "Ukraine", 
      "AE"=> "United Arab Emirates", 
      "GB"=> "United Kingdom", 
      "US"=> "United States", 
      "UM"=> "United States Minor Outlying Islands", 
      "UY"=> "Uruguay", 
      "UZ"=> "Uzbekistan", 
      "VU"=> "Vanuatu", 
      "VE"=> "Venezuela, Bolivarian Republic of", 
      "VN"=> "Viet Nam", 
      "VG"=> "Virgin Islands, British", 
      "VI"=> "Virgin Islands, U.S.", 
      "WF"=> "Wallis and Futuna", 
      "EH"=> "Western Sahara", 
      "YE"=> "Yemen", 
      "ZM"=> "Zambia", 
      "ZW"=> "Zimbabwe"]
    else
      redirect_to :controller => "registrations", :action => "mustBe"
    end
    end
    
    def blogs
      @interesting = BlogPost.where(:is_our_blog => false).sort_by{|e| e[:published_at]}.reverse
      
      @our_blog = BlogPost.where(:is_our_blog => true).sort_by{|e| e[:published_at]}.reverse
  
      @boolA = true
      @boolV = true
    end
    
    def blog_search
      @search_words = params[:search] 
      
      @interesting_search = Sunspot.search(BlogPost) do
        keywords params[:search]
        with :is_our_blog, false
      end
      @our_blog_search = Sunspot.search(BlogPost) do
        keywords params[:search]
        with :is_our_blog, true 
      end
      @interesting_tags_search = Sunspot.search(BlogTag) do
        with :tag, params[:search].gsub(/[^0-9A-Za-z]/, "").split(" ")
        with :is_our_blog, false
      end
      @our_blog_tags_search = Sunspot.search(BlogTag) do
        with :tag, params[:search].gsub(/[^0-9A-Za-z]/, "").split(" ")
        with :is_our_blog, true
      end
      @interesting = []
      @our_blog = []
      @interesting_tags_search.results.each do |f|
        @interesting << BlogPost.find(f.blog_post_id)
      end
      @interesting_search.results.each do |f|
        @interesting << f unless @interesting.include?(f)
      end
      @interesting = @interesting.sort_by{|e| e[:published_at]}.reverse
      
      @our_blog_tags_search.results.each do |f|
        @our_blog << BlogPost.find(f.blog_post_id)
      end
      @our_blog_search.results.each do |f|
        @our_blog << f unless @our_blog.include?(f)
      end
      @our_blog = @our_blog.sort_by{|e| e[:published_at]}.reverse
      @results = @interesting + @our_blog
      @results = @results.sort_by{|e| e[:published_at]}.reverse
    end
	  
	  def about
    end
    
    def terms
    end
    
    def privacy
    end
    
    def faq
    end

    
    def search_machine
      @theRegions = Hash.new ["AF" => 16, 
      "AX" => 6, 
      "AL" => 9, 
      "DZ" => 1, 
      "AS" => 22, 
      "AD" => 9, 
      "AO" => 3, 
      "AI" => 11, 
      "AQ" => 0, 
      "AG" => 11, 
      "AR" => 13, 
      "AM" => 18, 
      "AW" => 11, 
      "AU" => 19, 
      "AT" => 7, 
      "AZ" => 18, 
      "BS" => 11, 
      "BH" => 18, 
      "BD" => 16, 
      "BB" => 11, 
      "BY" => 8, 
      "BE" => 7, 
      "BZ" => 12, 
      "BJ" => 2, 
      "BM" => 10, 
      "BT" => 16, 
      "BO" => 13, 
      "BQ" => 0, 
      "BA" => 9, 
      "BW" => 5, 
      "BV" => 0, 
      "BR" => 13, 
      "IO" => 0, 
      "BN" => 17, 
      "BG" => 8, 
      "BF" => 2, 
      "BI" => 4, 
      "KH" => 17, 
      "CM" => 3, 
      "CA" => 10, 
      "CV" => 2, 
      "KY" => 11, 
      "CF" => 3, 
      "TD" => 3, 
      "CL" => 13, 
      "CN" => 15, 
      "CX" => 0, 
      "CC" => 0, 
      "CO" => 13, 
      "KM" => 4, 
      "CG" => 3, 
      "CD" => 3, 
      "CK" => 22, 
      "CR" => 12, 
      "CI" => 2, 
      "HR" => 9, 
      "CU" => 11, 
      "CW" => 0, 
      "CY" => 18, 
      "CZ" => 8, 
      "DK" => 6, 
      "DJ" => 4, 
      "DM" => 11, 
      "DO" => 11, 
      "EC" => 13, 
      "EG" => 1, 
      "SV" => 12, 
      "GQ" => 3, 
      "ER" => 4, 
      "EE" => 6, 
      "ET" => 4, 
      "FK" => 13, 
      "FO" => 6, 
      "FJ" => 20, 
      "FI" => 6, 
      "FR" => 7, 
      "GF" => 13, 
      "PF" => 22, 
      "TF" => 0, 
      "GA" => 3, 
      "GM" => 2, 
      "GE" => 18, 
      "DE" => 7, 
      "GH" => 2, 
      "GI" => 9, 
      "GR" => 9, 
      "GL" => 10, 
      "GD" => 11, 
      "GP" => 11, 
      "GU" => 21, 
      "GT" => 12, 
      "GG" => 6, 
      "GN" => 2, 
      "GW" => 2, 
      "GY" => 13, 
      "HT" => 11, 
      "HM" => 0, 
      "VA" => 9, 
      "HN" => 12, 
      "HK" => 15, 
      "HU" => 8, 
      "IS" => 6, 
      "IN" => 16, 
      "ID" => 17, 
      "IR" => 16, 
      "IQ" => 18, 
      "IE" => 6, 
      "IM" => 6, 
      "IL" => 18, 
      "IT" => 9, 
      "JM" => 11, 
      "JP" => 15, 
      "JE" => 6, 
      "JO" => 18, 
      "KZ" => 14, 
      "KE" => 4, 
      "KI" => 21, 
      "KP" => 15, 
      "KR" => 15, 
      "KW" => 18, 
      "KG" => 14, 
      "LA" => 17, 
      "LV" => 6, 
      "LB" => 18, 
      "LS" => 5, 
      "LR" => 2, 
      "LY" => 1, 
      "LI" => 7, 
      "LT" => 6, 
      "LU" => 7, 
      "MO" => 15, 
      "MK" => 9, 
      "MG" => 4, 
      "MW" => 4, 
      "MY" => 17, 
      "MV" => 16, 
      "ML" => 2, 
      "MT" => 9, 
      "MH" => 21, 
      "MQ" => 11, 
      "MR" => 2, 
      "MU" => 4, 
      "YT" => 4, 
      "MX" => 12, 
      "FM" => 21, 
      "MD" => 8, 
      "MC" => 7, 
      "MN" => 15, 
      "ME" => 9, 
      "MS" => 11, 
      "MA" => 1, 
      "MZ" => 4, 
      "MM" => 17, 
      "NA" => 5, 
      "NR" => 21, 
      "NP" => 16, 
      "NL" => 7, 
      "NC" => 20, 
      "NZ" => 19, 
      "NI" => 12, 
      "NE" => 2, 
      "NG" => 2, 
      "NU" => 22, 
      "NF" => 19, 
      "MP" => 21, 
      "NO" => 6, 
      "OM" => 18, 
      "PK" => 16, 
      "PW" => 21, 
      "PS" => 18, 
      "PA" => 12, 
      "PG" => 20, 
      "PY" => 13, 
      "PE" => 13, 
      "PH" => 17, 
      "PN" => 22, 
      "PL" => 8, 
      "PT" => 9, 
      "PR" => 11, 
      "QA" => 18, 
      "RE" => 4, 
      "RO" => 8, 
      "RU" => 8, 
      "RW" => 4, 
      "BL" => 11, 
      "SH" => 2, 
      "KN" => 11, 
      "LC" => 11, 
      "MF" => 11, 
      "PM" => 10, 
      "VC" => 11, 
      "WS" => 22, 
      "SM" => 9, 
      "ST" => 3, 
      "SA" => 18, 
      "SN" => 2, 
      "RS" => 9, 
      "SC" => 4, 
      "SL" => 2, 
      "SG" => 17, 
      "SX" => 0, 
      "SK" => 8, 
      "SI" => 9, 
      "SB" => 20, 
      "SO" => 4, 
      "ZA" => 5, 
      "GS" => 0, 
      "SS" => 0, 
      "ES" => 9, 
      "LK" => 16, 
      "SD" => 1, 
      "SR" => 13, 
      "SJ" => 6, 
      "SZ" => 5, 
      "SE" => 6, 
      "CH" => 7, 
      "SY" => 18, 
      "TW" => 15, 
      "TJ" => 14, 
      "TZ" => 4, 
      "TH" => 17, 
      "TL" => 17, 
      "TG" => 2, 
      "TK" => 22, 
      "TO" => 22, 
      "TT" => 11, 
      "TN" => 1, 
      "TR" => 18, 
      "TM" => 14, 
      "TC" => 11, 
      "TV" => 22, 
      "UG" => 4, 
      "UA" => 8, 
      "AE" => 18, 
      "GB" => 6, 
      "US" => 10, 
      "UM" => 0, 
      "UY" => 13, 
      "UZ" => 14, 
      "VU" => 20, 
      "VE" => 13, 
      "VN" => 17, 
      "VG" => 11, 
      "VI" => 11, 
      "WF" => 22, 
      "EH" => 1, 
      "YE" => 18, 
      "ZM" => 4, 
      "ZW" => 4]
      
    end

    
    def program_browse
      @organic_farming = Program.where(:subject => "Organic Farming")
      @sustainable_development = Program.where(:subject => "Sustainable Development")
      @animal_rights = Program.where(:subject => "Animal Rights")
      @wildlife_conservation = Program.where(:subject => "Wildlife Conservation")
      @elder_care = Program.where(:subject => "Elder Care")
      @child_orphan_care = Program.where(:subject => "Child/Orphan Care")
      @disabled_care = Program.where(:subject => "Disabled Care")
      @feed_the_homeless = Program.where(:subject => "Feed the Homeless")
      @youth_development_and_outreach = Program.where(:subject => "Youth Development and Outreach")
      @performing_arts = Program.where(:subject => "Performing Arts")
      @fashion = Program.where(:subject => "Fashion")
      @music = Program.where(:subject => "Music")
      @sports_and_recreation = Program.where(:subject => "Sports & Recreation")
      @journalism = Program.where(:subject => "Journalism")
      @economics = Program.where(:subject => "Economics")
      @microfinance = Program.where(:subject => "Microfinance")
      @teaching_english = Program.where(:subject => "Teaching English")
      @teaching_buddhist_monks = Program.where(:subject => "Teaching Buddhist Monks")
      @teaching_children = Program.where(:subject => "Teaching Children")
      @teaching_computer_literacy = Program.where(:subject => "Teaching Computer Literacy")
      @ecological_conservation = Program.where(:subject => "Ecological Conservation")
      @habitat_restoration = Program.where(:subject => "Habitat Resotration")
      @hiv_aids = Program.where(:subject => "HIV/AIDS")
      @nutrition = Program.where(:subject => "Nutrition")
      @family_planning = Program.where(:subject => "Family Planning")
      @veterinary_medicine = Program.where(:subject => "Veterinary Medicine")
      @clinical_work = Program.where(:subject => "Clinical Work")
      @dental_work = Program.where(:subject => "Dental Work")
      @medical_research = Program.where(:subject => "Medical Research")
      @health_education = Program.where(:subject => "Health Education")
      @public_health = Program.where(:subject => "Public Health")
      @hospital_care_giving = Program.where(:subject => "Hospital Care-giving")
      @womens_initiatives = Program.where(:subject => "Women's Initiatives")
      @adventure_travel = Program.where(:subject => "Adventure Travel")
      @archaeology = Program.where(:subject => "Archaeology")
      @environmental_biology = Program.where(:subject => "Environmental Biology")
      @media_marketing_and_graphic_design = Program.where(:subject => "Media, Marketing, and Graphic Design")
      
      @agriculture = Program.where(:subject => "Agriculture") + @organic_farming + @sustainable_development
      @animal_care = Program.where(:subject => "Animal Care") + @animal_rights + @wildlife_conservation
      @caregiving = Program.where(:subject => "Caregiving") + @elder_care + @child_orphan_care + @disabled_care + @feed_the_homeless
      @community_development = Program.where(:subject => "Community Development") + @youth_development_and_outreach
      @construction = Program.where(:subject => "Construction")
      @culture_and_community = Program.where(:subject => "Culture & Community") + @performing_arts + @fashion + @music + @sports_and_recreation + @journalism
      @disaster_relief = Program.where(:subject => "Disaster Relief") + @economics + @microfinance
      @education = Program.where(:subject => "Education") + @teaching_english + @teaching_buddhist_monks + @teaching_children + @teaching_computer_literacy
      @engineering_and_infrastructure = Program.where(:subject => "Engineering and Infrastructure")
      @environmental = Program.where(:subject => "Environmental") + @ecological_conservation + @sustainable_development + @wildlife_conservation + @habitat_restoration
      @health_and_medicine = Program.where(:subject => "Health and Medicine") + @hiv_aids + @nutrition + @family_planning + @veterinary_medicine + @clinical_work + @dental_work + @medical_research + @health_education + @public_health + @hospital_care_giving
      @human_rights = Program.where(:subject => "Human Rights") + @womens_initiatives
      @international_work_camp = Program.where(:subject => "International Work Camp")
      @recreation = Program.where(:subject => "Recreation") + @adventure_travel
      @scientific_research = Program.where(:subject => "Scientific Research") + @archaeology + @environmental_biology
      @technology = Program.where(:subject => "Technology") + @teaching_computer_literacy + @media_marketing_and_graphic_design
      
    end

    
    def thank_you
    end
    
  
end

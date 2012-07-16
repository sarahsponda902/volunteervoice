class OrganizationsController < ApplicationController
  # GET /organizations
  # GET /organizations.json
  
	require 'aws/s3'
  include ActionView::Helpers::TextHelper
  
  
  def index
    if user_signed_in? && current_user.admin?
      @organizations = Organization.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @organizations }
      end
    else
        redirect_to root_path
    end
  end



  
  def crop
    if user_signed_in? && current_user.admin?
      @organization = Organization.find(params[:id])
    else
      redirect_to "/pages/blogs"
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json
  
   
  def show
    @flag = Flag.new
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
    
    @organization = Organization.find(params[:id])
    
    @types_of_programs = []
    @price_ranges = []
    @group_sizes = []
    @program_lengths = []
    
     @organization.programs.each do |f|
       @types_of_programs << f.subject unless @types_of_programs.include?(f.subject)
       @price_ranges  << f.weekly_cost unless @price_ranges.include?(f.weekly_cost)
       @group_sizes << f.group_size unless @group_sizes.include?(f.group_size)
       @program_lengths << f.length unless @program_lengths.include?(f.length)
     end
     @results = []
     Review.where(:organization_id => @organization.id).each do |f|
   	     if !(f.overall.nil?)
           @results << f
       end
     end
     @results = @results.sort_by(&:created_at).reverse
     
     @overall = 0
     @results.each do |f|
       @overall = @overall + f.overall
     end
     if @results.count != 0
       @overall = @overall / @results.count
     else
       @overall = 0
     end
     
     
     @countries = []
     @organization.programs.each do |f|
       if !(@countries.include?(f.location))
         @countries << f.location
       end
     end
   
   @nameCountries = @countries
   
   @progs = Hash.new
   
   @countries.each do |f|
     @progs[f] = Program.where(:location => f)
   end

  end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
    if user_signed_in? && (current_user.admin? || (current_user.org && @organization.id == current_user.organization_id))
    @organization = Organization.find(params[:id])
    @organization.description = @organization.description.gsub(%r{</?[^>]+?>}, '')
    @organization.headquarters_location = @organization.headquarters_location.gsub(%r{</?[^>]+?>}, '')
    @organization.good_to_know = @organization.good_to_know.gsub(%r{</?[^>]+?>}, '')
    @organization.training_resources = @organization.training_resources.gsub(%r{</?[^>]+?>}, '')
    @organization.run_by = @organization.run_by.gsub(%r{</?[^>]+?>}, '')
    @organization.misson = @organization.misson.gsub(%r{</?[^>]+?>}, '')
    @organization.program_costs_includes = @organization.program_costs_includes.gsub(%r{</?[^>]+?>}, '')
    @organization.program_subjects = @organization.program_subjects.gsub(%r{</?[^>]+?>}, '')
    @organization.program_costs_doesnt_include = @organization.program_costs_doesnt_include.gsub(%r{</?[^>]+?>}, '')
    
  else
    redirect_to root_path
  end
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])
    @organization.truncated75 = RedCloth.new( ActionController::Base.helpers.sanitize( truncate @organization.description, :length => 50), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.description = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.description ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.headquarters_location = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.headquarters_location ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html   
    @organization.good_to_know = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.good_to_know ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.training_resources = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.training_resources ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.run_by = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.run_by ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.misson = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.misson ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.program_costs_includes = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.program_costs_includes ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.program_costs_doesnt_include = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.program_costs_doesnt_include ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
       
    if @organization.url[0..3] != "http"
      @organization.url = "http://"+@organization.url
    end

    
    
    @organization.reviews_count = 0
    @organization.overall = 0
    @organization.index!
    
    if user_signed_in? && current_user.admin?
      if @organization.save
            if @organization.will_invite && @organization.invite_email.present?
              OrganizationAccount.invite!(:email => @organization.invite_email, :organization_id => @organization.id, :admin_pass => admin_pass)
            end
            redirect_to "/organizations/#{@organization.id}/crop"
      else
        @organization.description = @organization.description.gsub(%r{</?[^>]+?>}, '')
        @organization.headquarters_location = @organization.headquarters_location.gsub(%r{</?[^>]+?>}, '')
        @organization.good_to_know = @organization.good_to_know.gsub(%r{</?[^>]+?>}, '')
        @organization.training_resources = @organization.training_resources.gsub(%r{</?[^>]+?>}, '')
        @organization.run_by = @organization.run_by.gsub(%r{</?[^>]+?>}, '')
        @organization.misson = @organization.misson.gsub(%r{</?[^>]+?>}, '')
        @organization.program_costs_includes = @organization.program_costs_includes.gsub(%r{</?[^>]+?>}, '')
        @organization.program_costs_doesnt_include = @organization.program_costs_doesnt_include.gsub(%r{</?[^>]+?>}, '')
         render :action => "new" 
      end
   end
end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization = Organization.find(params[:id])
    
       if user_signed_in? && (current_user.admin? || (current_user.org && @organization.id == current_user.organization_id))
       if @organization.update_attributes(params[:organization])
             redirect_to "/organizations/#{@organization.id}"
       else
          render :action => "edit" 
       end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end
  
  def programs
    @organization = Organization.find(params[:id])
    
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
    
     @theCountries2 = Hash["AF"=>"Afghanistan", 
          "AX"=>"AlandIslands", 
          "AL"=>"Albania", 
          "DZ"=>"Algeria", 
          "AS"=>"AmericanSamoa", 
          "AD"=>"Andorra", 
          "AO"=>"Angola", 
          "AI"=>"Anguilla", 
          "AQ"=>"Antarctica", 
          "AG"=>"AntiguaandBarbuda", 
          "AR"=>"Argentina", 
          "AM"=>"Armenia", 
          "AW"=>"Aruba", 
          "AU"=>"Australia", 
          "AT"=>"Austria", 
          "AZ"=>"Azerbaijan", 
          "BS"=>"Bahamas", 
          "BH"=>"Bahrain", 
          "BD"=>"Bangladesh", 
          "BB"=>"Barbados", 
          "BY"=>"Belarus", 
          "BE"=>"Belgium", 
          "BZ"=>"Belize", 
          "BJ"=>"Benin", 
          "BM"=>"Bermuda", 
          "BT"=>"Bhutan", 
          "BO"=>"BoliviaPlurinationalStateof", 
          "BQ"=>"BonaireSintEustatiusandSaba", 
          "BA"=>"BosniaandHerzegovina", 
          "BW"=>"Botswana", 
          "BV"=>"BouvetIsland", 
          "BR"=>"Brazil", 
          "IO"=>"BritishIndianOceanTerritory", 
          "BN"=>"BruneiDarussalam", 
          "BG"=>"Bulgaria", 
          "BF"=>"BurkinaFaso", 
          "BI"=>"Burundi", 
          "KH"=>"Cambodia", 
          "CM"=>"Cameroon", 
          "CA"=>"Canada", 
          "CV"=>"CapeVerde", 
          "KY"=>"CaymanIslands", 
          "CF"=>"CentralAfricanRepublic", 
          "TD"=>"Chad", 
          "CL"=>"Chile", 
          "CN"=>"China", 
          "CX"=>"ChristmasIsland", 
          "CC"=>"Cocos(Keeling)Islands", 
          "CO"=>"Colombia", 
          "KM"=>"Comoros", 
          "CG"=>"Congo", 
          "CD"=>"CongotheDemocraticRepublicofthe", 
          "CK"=>"CookIslands", 
          "CR"=>"CostaRica", 
          "CI"=>"Coted'Ivoire", 
          "HR"=>"Croatia", 
          "CU"=>"Cuba", 
          "CW"=>"Curacao", 
          "CY"=>"Cyprus", 
          "CZ"=>"CzechRepublic", 
          "DK"=>"Denmark", 
          "DJ"=>"Djibouti", 
          "DM"=>"Dominica", 
          "DO"=>"DominicanRepublic", 
          "EC"=>"Ecuador", 
          "EG"=>"Egypt", 
          "SV"=>"ElSalvador", 
          "GQ"=>"EquatorialGuinea", 
          "ER"=>"Eritrea", 
          "EE"=>"Estonia", 
          "ET"=>"Ethiopia", 
          "FK"=>"FalklandIslands(Malvinas)", 
          "FO"=>"FaroeIslands", 
          "FJ"=>"Fiji", 
          "FI"=>"Finland", 
          "FR"=>"France", 
          "GF"=>"FrenchGuiana", 
          "PF"=>"FrenchPolynesia", 
          "TF"=>"FrenchSouthernTerritories", 
          "GA"=>"Gabon", 
          "GM"=>"Gambia", 
          "GE"=>"Georgia", 
          "DE"=>"Germany", 
          "GH"=>"Ghana", 
          "GI"=>"Gibraltar", 
          "GR"=>"Greece", 
          "GL"=>"Greenland", 
          "GD"=>"Grenada", 
          "GP"=>"Guadeloupe", 
          "GU"=>"Guam", 
          "GT"=>"Guatemala", 
          "GG"=>"Guernsey", 
          "GN"=>"Guinea", 
          "GW"=>"Guinea-Bissau", 
          "GY"=>"Guyana", 
          "HT"=>"Haiti", 
          "HM"=>"HeardIslandandMcDonaldIslands", 
          "VA"=>"HolySee(VaticanCityState)", 
          "HN"=>"Honduras", 
          "HK"=>"HongKong", 
          "HU"=>"Hungary", 
          "IS"=>"Iceland", 
          "IN"=>"India", 
          "ID"=>"Indonesia", 
          "IR"=>"IranIslamicRepublicof", 
          "IQ"=>"Iraq", 
          "IE"=>"Ireland", 
          "IM"=>"IsleofMan", 
          "IL"=>"Israel", 
          "IT"=>"Italy", 
          "JM"=>"Jamaica", 
          "JP"=>"Japan", 
          "JE"=>"Jersey", 
          "JO"=>"Jordan", 
          "KZ"=>"Kazakhstan", 
          "KE"=>"Kenya", 
          "KI"=>"Kiribati", 
          "KP"=>"KoreaDemocraticPeople'sRepublicof", 
          "KR"=>"KoreaRepublicof", 
          "KW"=>"Kuwait", 
          "KG"=>"Kyrgyzstan", 
          "LA"=>"LaoPeople'sDemocraticRepublic", 
          "LV"=>"Latvia", 
          "LB"=>"Lebanon", 
          "LS"=>"Lesotho", 
          "LR"=>"Liberia", 
          "LY"=>"Libya", 
          "LI"=>"Liechtenstein", 
          "LT"=>"Lithuania", 
          "LU"=>"Luxembourg", 
          "MO"=>"Macao", 
          "MK"=>"MacedoniatheformerYugoslavRepublicof", 
          "MG"=>"Madagascar", 
          "MW"=>"Malawi", 
          "MY"=>"Malaysia", 
          "MV"=>"Maldives", 
          "ML"=>"Mali", 
          "MT"=>"Malta", 
          "MH"=>"MarshallIslands", 
          "MQ"=>"Martinique", 
          "MR"=>"Mauritania", 
          "MU"=>"Mauritius", 
          "YT"=>"Mayotte", 
          "MX"=>"Mexico", 
          "FM"=>"MicronesiaFederatedStatesof", 
          "MD"=>"MoldovaRepublicof", 
          "MC"=>"Monaco", 
          "MN"=>"Mongolia", 
          "ME"=>"Montenegro", 
          "MS"=>"Montserrat", 
          "MA"=>"Morocco", 
          "MZ"=>"Mozambique", 
          "MM"=>"Myanmar", 
          "NA"=>"Namibia", 
          "NR"=>"Nauru", 
          "NP"=>"Nepal", 
          "NL"=>"Netherlands", 
          "NC"=>"NewCaledonia", 
          "NZ"=>"NewZealand", 
          "NI"=>"Nicaragua", 
          "NE"=>"Niger", 
          "NG"=>"Nigeria", 
          "NU"=>"Niue", 
          "NF"=>"NorfolkIsland", 
          "MP"=>"NorthernMarianaIslands", 
          "NO"=>"Norway", 
          "OM"=>"Oman", 
          "PK"=>"Pakistan", 
          "PW"=>"Palau", 
          "PS"=>"PalestinianTerritoryOccupied", 
          "PA"=>"Panama", 
          "PG"=>"PapuaNewGuinea", 
          "PY"=>"Paraguay", 
          "PE"=>"Peru", 
          "PH"=>"Philippines", 
          "PN"=>"Pitcairn", 
          "PL"=>"Poland", 
          "PT"=>"Portugal", 
          "PR"=>"PuertoRico", 
          "QA"=>"Qatar", 
          "RE"=>"Reunion", 
          "RO"=>"Romania", 
          "RU"=>"RussianFederation", 
          "RW"=>"Rwanda", 
          "BL"=>"SaintBarthelemy", 
          "SH"=>"SaintHelenaAscensionandTristandaCunha", 
          "KN"=>"SaintKittsandNevis", 
          "LC"=>"SaintLucia", 
          "MF"=>"SaintMartin(Frenchpart)", 
          "PM"=>"SaintPierreandMiquelon", 
          "VC"=>"SaintVincentandtheGrenadines", 
          "WS"=>"Samoa", 
          "SM"=>"SanMarino", 
          "ST"=>"SaoTomeandPrincipe", 
          "SA"=>"SaudiArabia", 
          "SN"=>"Senegal", 
          "RS"=>"Serbia", 
          "SC"=>"Seychelles", 
          "SL"=>"SierraLeone", 
          "SG"=>"Singapore", 
          "SX"=>"SintMaarten(Dutchpart)", 
          "SK"=>"Slovakia", 
          "SI"=>"Slovenia", 
          "SB"=>"SolomonIslands", 
          "SO"=>"Somalia", 
          "ZA"=>"SouthAfrica", 
          "GS"=>"SouthGeorgiaandtheSouthSandwichIslands", 
          "SS"=>"SouthSudan", 
          "ES"=>"Spain", 
          "LK"=>"SriLanka", 
          "SD"=>"Sudan", 
          "SR"=>"Suriname", 
          "SJ"=>"SvalbardandJanMayen", 
          "SZ"=>"Swaziland", 
          "SE"=>"Sweden", 
          "CH"=>"Switzerland", 
          "SY"=>"SyrianArabRepublic", 
          "TW"=>"TaiwanProvinceofChina", 
          "TJ"=>"Tajikistan", 
          "TZ"=>"TanzaniaUnitedRepublicof", 
          "TH"=>"Thailand", 
          "TL"=>"Timor-Leste", 
          "TG"=>"Togo", 
          "TK"=>"Tokelau", 
          "TO"=>"Tonga", 
          "TT"=>"TrinidadandTobago", 
          "TN"=>"Tunisia", 
          "TR"=>"Turkey", 
          "TM"=>"Turkmenistan", 
          "TC"=>"TurksandCaicosIslands", 
          "TV"=>"Tuvalu", 
          "UG"=>"Uganda", 
          "UA"=>"Ukraine", 
          "AE"=>"UnitedArabEmirates", 
          "GB"=>"UnitedKingdom", 
          "US"=>"UnitedStates", 
          "UM"=>"UnitedStatesMinorOutlyingIslands", 
          "UY"=>"Uruguay", 
          "UZ"=>"Uzbekistan", 
          "VU"=>"Vanuatu", 
          "VE"=>"VenezuelaBolivarianRepublicof", 
          "VN"=>"VietNam", 
          "VG"=>"VirginIslandsBritish", 
          "VI"=>"VirginIslandsUS", 
          "WF"=>"WallisandFutuna", 
          "EH"=>"WesternSahara", 
          "YE"=>"Yemen", 
          "ZM"=>"Zambia", 
          "ZW"=>"Zimbabwe"]
  end
  
private
def admin_pass 
  "4e5d0ed9183ebf2fed541412497e15a30e72f9cb"
end
end

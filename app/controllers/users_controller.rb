class UsersController < ApplicationController
  
  include ActionView::Helpers::TextHelper
	require 'aws/s3'
  
  helper :all
  helper_method :age
  
  def crop
    if user_signed_in?
      @user = current_user
    else
      redirect_to "/pages/blogs"
    end
  end
  
  # GET /users
  # GET /users.json
  def index
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
    
    if user_signed_in? && current_user.admin?
    @users = User.all
    @unapproved_users = User.where(:approved => false)
    @approved_users = User.where(:approved => true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  else
    redirect_to root_path
  end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    
    @user = User.find(params[:id])
    if user_signed_in? && (@user.id == current_user.id)
    redirect_to "/pages/profile"
    else
    @message = Message.new
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
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
      
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
        @user = User.find(params[:id])
        
        if @user.update_attributes(params[:user])
          if @user.crops
             redirect_to "/users/#{@user.id}/crop"
          else
             flash[:notice] = 'Your profile was successfully updated.'
             redirect_to("/pages/profile")
          end
        else
          render :action => "edit"
        end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if user_signed_in? && current_user.admin?
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  else
    redirect_to root_path
  end
  end
  
  def destroy_image
    @user.save
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'Image was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit"}
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def check_email
  @user = User.find_by_email(params[:user][:email])

  respond_to do |format|
  format.json { render :json => !@user }
  end
  end
  
  def check_username
    @user = User.find_by_email(params[:user][:username])

    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  def change_subscription
    @user = User.find(params[:id])
    @user.notify = !@user.notify unless @user.notify.nil?
    @user.save
    respond_to do |format|
      format.html {render :action => "successful_unsubscribe", :user_id => @user.id}
      format.json {head :no_content}
    end
  end
  
  
  def successful_unsubscribe
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html
      format.json {head :no_content}
    end
  end

  def make_admin
    if !(user_signed_in? && current_user.admin?)
      redirect_to root_path
    else
      @user = User.find(params[:user_id])
      if !@user.admin?
        @user.admin = true
      else
        @user.admin = false
      end
      @user.save
      redirect_to "/users"
    end
  end

end

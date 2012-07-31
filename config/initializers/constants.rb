#############################################################################################
# Note: if updating countries or subjects, still need to:
#       * update form fields in:
#                - pages/search_machine 
#                - searches/show
#                - searches/error
#       * update javascript check-box code at bottom of page in:
#                - pages/search_machine 
#                - searches/show
#                - searches/error
#       * 
#############################################################################################

THECOUNTRIES = Hash["AF" => "Afghanistan", 
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
  
THECOUNTRIES2 = Hash["AF"=>"Afghanistan", 
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
        
ALLCOUNTRIES = ['AF', 
        'AX', 
        'AL', 
        'DZ', 
        'AS', 
        'AD', 
        'AO', 
        'AI', 
        'AQ', 
        'AG', 
        'AR', 
        'AM', 
        'AW', 
        'AU', 
        'AT', 
        'AZ', 
        'BS', 
        'BH', 
        'BD', 
        'BB', 
        'BY', 
        'BE', 
        'BZ', 
        'BJ', 
        'BM', 
        'BT', 
        'BO', 
        'BQ', 
        'BA', 
        'BW', 
        'BV', 
        'BR', 
        'IO', 
        'BN', 
        'BG', 
        'BF', 
        'BI', 
        'KH', 
        'CM', 
        'CA', 
        'CV', 
        'KY', 
        'CF', 
        'TD', 
        'CL', 
        'CN', 
        'CX', 
        'CC', 
        'CO', 
        'KM', 
        'CG', 
        'CD', 
        'CK', 
        'CR', 
        'CI', 
        'HR', 
        'CU', 
        'CW', 
        'CY', 
        'CZ', 
        'DK', 
        'DJ', 
        'DM', 
        'DO', 
        'EC', 
        'EG', 
        'SV', 
        'GQ', 
        'ER', 
        'EE', 
        'ET', 
        'FK', 
        'FO', 
        'FJ', 
        'FI', 
        'FR', 
        'GF', 
        'PF', 
        'TF', 
        'GA', 
        'GM', 
        'GE', 
        'DE', 
        'GH', 
        'GI', 
        'GR', 
        'GL', 
        'GD', 
        'GP', 
        'GU', 
        'GT', 
        'GG', 
        'GN', 
        'GW', 
        'GY', 
        'HT', 
        'HM', 
        'VA', 
        'HN', 
        'HK', 
        'HU', 
        'IS', 
        'IN', 
        'ID', 
        'IR', 
        'IQ', 
        'IE', 
        'IM', 
        'IL', 
        'IT', 
        'JM', 
        'JP', 
        'JE', 
        'JO', 
        'KZ', 
        'KE', 
        'KI', 
        'KP', 
        'KR', 
        'KW', 
        'KG', 
        'LA', 
        'LV', 
        'LB', 
        'LS', 
        'LR', 
        'LY', 
        'LI', 
        'LT', 
        'LU', 
        'MO', 
        'MK', 
        'MG', 
        'MW', 
        'MY', 
        'MV', 
        'ML', 
        'MT', 
        'MH', 
        'MQ', 
        'MR', 
        'MU', 
        'YT', 
        'MX', 
        'FM', 
        'MD', 
        'MC', 
        'MN', 
        'ME', 
        'MS', 
        'MA', 
        'MZ', 
        'MM', 
        'NA', 
        'NR', 
        'NP', 
        'NL', 
        'NC', 
        'NZ', 
        'NI', 
        'NE', 
        'NG', 
        'NU', 
        'NF', 
        'MP', 
        'NO', 
        'OM', 
        'PK', 
        'PW', 
        'PS', 
        'PA', 
        'PG', 
        'PY', 
        'PE', 
        'PH', 
        'PN', 
        'PL', 
        'PT', 
        'PR', 
        'QA', 
        'RE', 
        'RO', 
        'RU', 
        'RW', 
        'BL', 
        'SH', 
        'KN', 
        'LC', 
        'MF', 
        'PM', 
        'VC', 
        'WS', 
        'SM', 
        'ST', 
        'SA', 
        'SN', 
        'RS', 
        'SC', 
        'SL', 
        'SG', 
        'SX', 
        'SK', 
        'SI', 
        'SB', 
        'SO', 
        'ZA', 
        'GS', 
        'SS', 
        'ES', 
        'LK', 
        'SD', 
        'SR', 
        'SJ', 
        'SZ', 
        'SE', 
        'CH', 
        'SY', 
        'TW', 
        'TJ', 
        'TZ', 
        'TH', 
        'TL', 
        'TG', 
        'TK', 
        'TO', 
        'TT', 
        'TN', 
        'TR', 
        'TM', 
        'TC', 
        'TV', 
        'UG', 
        'UA', 
        'AE', 
        'GB', 
        'US', 
        'UM', 
        'UY', 
        'UZ', 
        'VU', 
        'VE', 
        'VN', 
        'VG', 
        'VI', 
        'WF', 
        'EH', 
        'YE', 
        'ZM', 
        'ZW']
      	
ALLCOUNTRYNAMES = ['Afghanistan', 
        'Aland Islands', 
        'Albania', 
        'Algeria', 
        'American Samoa', 
        'Andorra', 
        'Angola', 
        'Anguilla', 
        'Antarctica', 
        'Antigua and Barbuda', 
        'Argentina', 
        'Armenia', 
        'Aruba', 
        'Australia', 
        'Austria', 
        'Azerbaijan', 
        'Bahamas', 
        'Bahrain', 
        'Bangladesh', 
        'Barbados', 
        'Belarus', 
        'Belgium', 
        'Belize', 
        'Benin', 
        'Bermuda', 
        'Bhutan', 
        'Bolivia, Plurinational State of', 
        'Bonaire, Sint Eustatius and Saba', 
        'Bosnia and Herzegovina', 
        'Botswana', 
        'Bouvet Island', 
        'Brazil', 
        'British Indian Ocean Territory', 
        'Brunei Darussalam', 
        'Bulgaria', 
        'Burkina Faso', 
        'Burundi', 
        'Cambodia', 
        'Cameroon', 
        'Canada', 
        'Cape Verde', 
        'Cayman Islands', 
        'Central African Republic', 
        'Chad', 
        'Chile', 
        'China', 
        'Christmas Island', 
        'Cocos (Keeling) Islands', 
        'Colombia', 
        'Comoros', 
        'Congo', 
        'Congo, the Democratic Republic of the', 
        'Cook Islands', 
        'Costa Rica', 
        'Cote dIvoire', 
        'Croatia', 
        'Cuba', 
        'Curacao', 
        'Cyprus', 
        'Czech Republic', 
        'Denmark', 
        'Djibouti', 
        'Dominica', 
        'Dominican Republic', 
        'Ecuador', 
        'Egypt', 
        'El Salvador', 
        'Equatorial Guinea', 
        'Eritrea', 
        'Estonia', 
        'Ethiopia', 
        'Falkland Islands (Malvinas)', 
        'Faroe Islands', 
        'Fiji', 
        'Finland', 
        'France', 
        'French Guiana', 
        'French Polynesia', 
        'French Southern Territories', 
        'Gabon', 
        'Gambia', 
        'Georgia', 
        'Germany', 
        'Ghana', 
        'Gibraltar', 
        'Greece', 
        'Greenland', 
        'Grenada', 
        'Guadeloupe', 
        'Guam', 
        'Guatemala', 
        'Guernsey', 
        'Guinea', 
        'Guinea-Bissau', 
        'Guyana', 
        'Haiti', 
        'Heard Island and McDonald Islands', 
        'Holy See (Vatican City State)', 
        'Honduras', 
        'Hong Kong', 
        'Hungary', 
        'Iceland', 
        'India', 
        'Indonesia', 
        'Iran, Islamic Republic of', 
        'Iraq', 
        'Ireland', 
        'Isle of Man', 
        'Israel', 
        'Italy', 
        'Jamaica', 
        'Japan', 
        'Jersey', 
        'Jordan', 
        'Kazakhstan', 
        'Kenya', 
        'Kiribati', 
        'Korea, Democratic Peoples Republic of', 
        'Korea, Republic of', 
        'Kuwait', 
        'Kyrgyzstan', 
        'Lao Peoples Democratic Republic', 
        'Latvia', 
        'Lebanon', 
        'Lesotho', 
        'Liberia', 
        'Libya', 
        'Liechtenstein', 
        'Lithuania', 
        'Luxembourg', 
        'Macao', 
        'Macedonia, the former Yugoslav Republic of', 
        'Madagascar', 
        'Malawi', 
        'Malaysia', 
        'Maldives', 
        'Mali', 
        'Malta', 
        'Marshall Islands', 
        'Martinique', 
        'Mauritania', 
        'Mauritius', 
        'Mayotte', 
        'Mexico', 
        'Micronesia, Federated States of', 
        'Moldova, Republic of', 
        'Monaco', 
        'Mongolia', 
        'Montenegro', 
        'Montserrat', 
        'Morocco', 
        'Mozambique', 
        'Myanmar', 
        'Namibia', 
        'Nauru', 
        'Nepal', 
        'Netherlands', 
        'New Caledonia', 
        'New Zealand', 
        'Nicaragua', 
        'Niger', 
        'Nigeria', 
        'Niue', 
        'Norfolk Island', 
        'Northern Mariana Islands', 
        'Norway', 
        'Oman', 
        'Pakistan', 
        'Palau', 
        'Palestinian Territory, Occupied', 
        'Panama', 
        'Papua New Guinea', 
        'Paraguay', 
        'Peru', 
        'Philippines', 
        'Pitcairn', 
        'Poland', 
        'Portugal', 
        'Puerto Rico', 
        'Qatar', 
        'Reunion', 
        'Romania', 
        'Russian Federation', 
        'Rwanda', 
        'Saint Barthelemy', 
        'Saint Helena, Ascension and Tristan da Cunha', 
        'Saint Kitts and Nevis', 
        'Saint Lucia', 
        'Saint Martin (French part)', 
        'Saint Pierre and Miquelon', 
        'Saint Vincent and the Grenadines', 
        'Samoa', 
        'San Marino', 
        'Sao Tome and Principe', 
        'Saudi Arabia', 
        'Senegal', 
        'Serbia', 
        'Seychelles', 
        'Sierra Leone', 
        'Singapore', 
        'Sint Maarten (Dutch part)', 
        'Slovakia', 
        'Slovenia', 
        'Solomon Islands', 
        'Somalia', 
        'South Africa', 
        'South Georgia and the South Sandwich Islands', 
        'South Sudan', 
        'Spain', 
        'Sri Lanka', 
        'Sudan', 
        'Suriname', 
        'Svalbard and Jan Mayen', 
        'Swaziland', 
        'Sweden', 
        'Switzerland', 
        'Syrian Arab Republic', 
        'Taiwan, Province of China', 
        'Tajikistan', 
        'TanzaniaUnited Republic of', 
        'Thailand', 
        'Timor-Leste', 
        'Togo', 
        'Tokelau', 
        'Tonga', 
        'Trinidad and Tobago', 
        'Tunisia', 
        'Turkey', 
        'Turkmenistan', 
        'Turks and Caicos Islands', 
        'Tuvalu', 
        'Uganda', 
        'Ukraine', 
        'United Arab Emirates', 
        'United Kingdom', 
        'United States', 
        'United States Minor Outlying Islands', 
        'Uruguay', 
        'Uzbekistan', 
        'Vanuatu', 
        'Venezuela, Bolivarian Republic of', 
        'Viet Nam', 
        'Virgin Islands, British', 
        'Virgin Islands, U.S.', 
        'Wallis and Futuna', 
        'Western Sahara', 
        'Yemen', 
        'Zambia', 
        'Zimbabwe']
      	
THEREGIONS = [['AQ', 
        'BQ', 
        'BV', 
        'IO', 
        'CX', 
        'CC', 
        'CW', 
        'TF', 
        'HM', 
        'SX', 
        'GS', 
        'SS', 
        'UM'], 
        ['DZ', 
        'EG', 
        'LY', 
        'MA', 
        'SD', 
        'TN', 
        'EH'],
        ['BJ', 
        'BF', 
        'CV', 
        'CI', 
        'GM', 
        'GH', 
        'GN', 
        'GW', 
        'LR', 
        'ML', 
        'MR', 
        'NE', 
        'NG', 
        'SH', 
        'SN', 
        'SL', 
        'TG'],
        ['AO', 
        'CM', 
        'CF', 
        'TD', 
        'CG', 
        'CD', 
        'GQ', 
        'GA', 
        'ST'],
        ['BI', 
        'KM', 
        'DJ', 
        'ER', 
        'ET', 
        'KE', 
        'MG', 
        'MW', 
        'MU', 
        'YT', 
        'MZ', 
        'RE', 
        'RW', 
        'SC', 
        'SO', 
        'TZ', 
        'UG', 
        'ZM', 
        'ZW'],
        ['BW', 
        'LS', 
        'NA', 
        'ZA', 
        'SZ'],
        ['AX', 
        'DK', 
        'EE', 
        'FO', 
        'FI', 
        'GG', 
        'IS', 
        'IE', 
        'IM', 
        'JE', 
        'LV', 
        'LT', 
        'NO', 
        'SJ', 
        'SE', 
        'GB'],
        ['AT', 
        'BE', 
        'FR', 
        'DE', 
        'LI', 
        'LU', 
        'MC', 
        'NL', 
        'CH'],
        ['BY', 
        'BG', 
        'CZ', 
        'HU', 
        'MD', 
        'PL', 
        'RO', 
        'RU', 
        'SK', 
        'UA'],
        ['AL', 
        'AD', 
        'BA', 
        'HR', 
        'GI', 
        'GR', 
        'VA', 
        'IT', 
        'MK', 
        'MT', 
        'ME', 
        'PT', 
        'SM', 
        'RS', 
        'SI', 
        'ES'],
        ['BM', 
        'CA', 
        'GL', 
        'PM', 
        'US'],
        ['AI', 
        'AG', 
        'AW', 
        'BS', 
        'BB', 
        'KY', 
        'CU', 
        'DM', 
        'DO', 
        'GD', 
        'GP', 
        'HT', 
        'JM', 
        'MQ', 
        'MS', 
        'PR', 
        'BL', 
        'KN', 
        'LC', 
        'MF', 
        'VC', 
        'TT', 
        'TC', 
        'VG', 
        'VI'],
        ['BZ', 
        'CR', 
        'SV', 
        'GT', 
        'HN', 
        'MX', 
        'NI', 
        'PA'],
        ['AR', 
        'BO', 
        'BR', 
        'CL', 
        'CO', 
        'EC', 
        'FK', 
        'GF', 
        'GY', 
        'PY', 
        'PE', 
        'SR', 
        'UY', 
        'VE'],
        ['KZ', 
        'KG', 
        'TJ', 
        'TM', 
        'UZ'],
        ['CN', 
        'HK', 
        'JP', 
        'KP', 
        'KR', 
        'MO', 
        'MN', 
        'TW'],
        ['AF', 
        'BD', 
        'BT', 
        'IN', 
        'IR', 
        'MV', 
        'NP', 
        'PK', 
        'LK'],
        ['BN', 
        'KH', 
        'ID', 
        'LA', 
        'MY', 
        'MM', 
        'PH', 
        'SG', 
        'TH', 
        'TL', 
        'VN'],
        ['AM', 
        'AZ', 
        'BH', 
        'CY', 
        'GE', 
        'IQ', 
        'IL', 
        'JO', 
        'KW', 
        'LB', 
        'OM', 
        'PS', 
        'QA', 
        'SA', 
        'SY', 
        'TR', 
        'AE', 
        'YE'],
        ['AU', 
        'NZ', 
        'NF'],
        ['FJ', 
        'NC', 
        'PG', 
        'SB', 
        'VU'],
        ['GU', 
        'KI', 
        'MH', 
        'FM', 
        'NR', 
        'MP', 
        'PW'],
        ['AS', 
        'CK', 
        'PF', 
        'NU', 
        'PN', 
        'WS', 
        'TK', 
        'TO', 
        'TV', 
        'WF']]
        
ALLSUBJECTTAGS = ['Agriculture', 
          'OrganicFarming', 
          'SustainableDevelopment', 
          'AnimalCare', 
          'AnimalRights', 
          'WildlifeConservation', 
          'Caregiving', 
          'ElderCare', 
          'ChildOrphanCare', 
          'DisabledCare', 
          'FeedtheHomeless', 
          'CommunityDevelopment', 
          'YouthDevelopmentandOutreach', 
          'Construction', 
          'CultureandCommunity', 
          'PerformingArts', 
          'Fashion', 
          'Music', 
          'SportsRecreation', 
          'Journalism', 
          'DisasterRelief', 
          'Economics', 
          'Microfinance', 
          'Education', 
          'TeachingEnglish', 
          'TeachingBuddhistMonks', 
          'TeachingChildren', 
          'TeachingComputerLiteracy', 
          'EngineeringandInfrastructure', 
          'Environmental', 
          'EcologicalConservation', 
          'HabitatRestoration', 
          'HealthandMedicine', 
          'HIVAIDS', 
          'Nutrition', 
          'FamilyPlanning', 
          'VeterinaryMedicine', 
          'ClinicalWork', 
          'DentalWork', 
          'MedicalResearch', 
          'HealthEducation', 
          'PublicHealth', 
          'HospitalCaregiving', 
          'HumanRights', 
          'WomensInitiatives', 
          'InternationalWorkCamp', 
          'Recreation', 
          'AdventureTravel', 
          'ScientificResearch', 
          'Archaeology', 
          'EnvironmentalBiology', 
          'Technology', 
          'MediaMarketingandGraphicDesign', 
          ' ']
          
SUBJECTSHASH = Hash['Agriculture' => 'Agriculture' , 
          'OrganicFarming' => 'Organic Farming' , 
          'SustainableDevelopment' => 'Sustainable Development' , 
          'AnimalCare' => 'Animal Care' , 
          'AnimalRights' => 'Animal Rights' , 
          'WildlifeConservation' => 'Wildlife Conservation' , 
          'Caregiving' => 'Caregiving' , 
          'ElderCare' =>       'Elder Care' , 
          'ChildOrphanCare' =>       'Child/Orphan Care' , 
          'DisabledCare' =>       'Disabled Care' , 
          'FeedtheHomeless' =>       'Feed the Homeless' , 
          'CommunityDevelopment' =>       'Community Development' , 
          'YouthDevelopmentandOutreach' =>       'Youth Development and Outreach' , 
          'Construction' =>       'Construction' , 
          'CultureandCommunity' =>       'Culture and Community' , 
          'PerformingArts' =>       'Performing Arts' , 
          'Fashion' =>       'Fashion' , 
          'Music' =>       'Music' , 
          'SportsRecreation' =>       'Sports & Recreation' , 
          'Journalism' =>       'Journalism' , 
          'DisasterRelief' =>       'Disaster Relief' , 
          'Economics' =>       'Economics' , 
          'Microfinance' =>       'Microfinance' , 
          'Education' =>       'Education' , 
          'TeachingEnglish' =>       'Teaching English' , 
          'TeachingBuddhistMonks' =>       'Teaching Buddhist Monks' , 
          'TeachingChildren' =>       'Teaching Children' , 
          'TeachingComputerLiteracy' =>       'Teaching Computer Literacy' , 
          'EngineeringandInfrastructure' =>       'Engineering and Infrastructure' , 
          'Environmental' =>       'Environmental' , 
          'EcologicalConservation' =>       'Ecological Conservation' , 
          'SustainableDevelopment' =>       'Sustainable Development' , 
          'WildlifeConservation' =>       'Wildlife Conservation' , 
          'HabitatRestoration' =>       'Habitat Restoration' , 
          'HealthandMedicine' =>       'Health and Medicine' , 
          'HIVAIDS' =>       'HIV/AIDS' , 
          'Nutrition' =>       'Nutrition' , 
          'FamilyPlanning' =>       'Family Planning' , 
          'VeterinaryMedicine' =>       'Veterinary Medicine' , 
          'ClinicalWork' =>       'Clinical Work' , 
          'DentalWork' =>       'Dental Work' , 
          'MedicalResearch' =>       'Medical Research' , 
          'HealthEducation' =>       'Health Education' , 
          'PublicHealth' =>       'Public Health' , 
          'HospitalCaregiving' =>       'Hospital Care-giving' , 
          'HumanRights' =>       'Human Rights' , 
          'WomensInitiatives' =>       'Womens Initiatives' , 
          'InternationalWorkCamp' =>       'International Work Camp' , 
          'Recreation' =>       'Recreation' , 
          'AdventureTravel' =>       'Adventure Travel' , 
          'ScientificResearch' =>       'Scientific Research' , 
          'Archaeology' =>       'Archaeology' , 
          'EnvironmentalBiology' =>       'Environmental Biology' , 
          'Technology' =>       'Technology' , 
          'TeachingComputerLiteracy' =>       'Teaching Computer Literacy' , 
          'MediaMarketingandGraphicDesign' =>       'Media Marketing and Graphic Design']
class SearchesController < ApplicationController
  
   @theRegions = Hash.new ['AF' => 16, 
    'AX' => 6, 
    'AL' => 9, 
    'DZ' => 1, 
    'AS' => 22, 
    'AD' => 9, 
    'AO' => 3, 
    'AI' => 11, 
    'AQ' => 0, 
    'AG' => 11, 
    'AR' => 13, 
    'AM' => 18, 
    'AW' => 11, 
    'AU' => 19, 
    'AT' => 7, 
    'AZ' => 18, 
    'BS' => 11, 
    'BH' => 18, 
    'BD' => 16, 
    'BB' => 11, 
    'BY' => 8, 
    'BE' => 7, 
    'BZ' => 12, 
    'BJ' => 2, 
    'BM' => 10, 
    'BT' => 16, 
    'BO' => 13, 
    'BQ' => 0, 
    'BA' => 9, 
    'BW' => 5, 
    'BV' => 0, 
    'BR' => 13, 
    'IO' => 0, 
    'BN' => 17, 
    'BG' => 8, 
    'BF' => 2, 
    'BI' => 4, 
    'KH' => 17, 
    'CM' => 3, 
    'CA' => 10, 
    'CV' => 2, 
    'KY' => 11, 
    'CF' => 3, 
    'TD' => 3, 
    'CL' => 13, 
    'CN' => 15, 
    'CX' => 0, 
    'CC' => 0, 
    'CO' => 13, 
    'KM' => 4, 
    'CG' => 3, 
    'CD' => 3, 
    'CK' => 22, 
    'CR' => 12, 
    'CI' => 2, 
    'HR' => 9, 
    'CU' => 11, 
    'CW' => 0, 
    'CY' => 18, 
    'CZ' => 8, 
    'DK' => 6, 
    'DJ' => 4, 
    'DM' => 11, 
    'DO' => 11, 
    'EC' => 13, 
    'EG' => 1, 
    'SV' => 12, 
    'GQ' => 3, 
    'ER' => 4, 
    'EE' => 6, 
    'ET' => 4, 
    'FK' => 13, 
    'FO' => 6, 
    'FJ' => 20, 
    'FI' => 6, 
    'FR' => 7, 
    'GF' => 13, 
    'PF' => 22, 
    'TF' => 0, 
    'GA' => 3, 
    'GM' => 2, 
    'GE' => 18, 
    'DE' => 7, 
    'GH' => 2, 
    'GI' => 9, 
    'GR' => 9, 
    'GL' => 10, 
    'GD' => 11, 
    'GP' => 11, 
    'GU' => 21, 
    'GT' => 12, 
    'GG' => 6, 
    'GN' => 2, 
    'GW' => 2, 
    'GY' => 13, 
    'HT' => 11, 
    'HM' => 0, 
    'VA' => 9, 
    'HN' => 12, 
    'HK' => 15, 
    'HU' => 8, 
    'IS' => 6, 
    'IN' => 16, 
    'ID' => 17, 
    'IR' => 16, 
    'IQ' => 18, 
    'IE' => 6, 
    'IM' => 6, 
    'IL' => 18, 
    'IT' => 9, 
    'JM' => 11, 
    'JP' => 15, 
    'JE' => 6, 
    'JO' => 18, 
    'KZ' => 14, 
    'KE' => 4, 
    'KI' => 21, 
    'KP' => 15, 
    'KR' => 15, 
    'KW' => 18, 
    'KG' => 14, 
    'LA' => 17, 
    'LV' => 6, 
    'LB' => 18, 
    'LS' => 5, 
    'LR' => 2, 
    'LY' => 1, 
    'LI' => 7, 
    'LT' => 6, 
    'LU' => 7, 
    'MO' => 15, 
    'MK' => 9, 
    'MG' => 4, 
    'MW' => 4, 
    'MY' => 17, 
    'MV' => 16, 
    'ML' => 2, 
    'MT' => 9, 
    'MH' => 21, 
    'MQ' => 11, 
    'MR' => 2, 
    'MU' => 4, 
    'YT' => 4, 
    'MX' => 12, 
    'FM' => 21, 
    'MD' => 8, 
    'MC' => 7, 
    'MN' => 15, 
    'ME' => 9, 
    'MS' => 11, 
    'MA' => 1, 
    'MZ' => 4, 
    'MM' => 17, 
    'NA' => 5, 
    'NR' => 21, 
    'NP' => 16, 
    'NL' => 7, 
    'NC' => 20, 
    'NZ' => 19, 
    'NI' => 12, 
    'NE' => 2, 
    'NG' => 2, 
    'NU' => 22, 
    'NF' => 19, 
    'MP' => 21, 
    'NO' => 6, 
    'OM' => 18, 
    'PK' => 16, 
    'PW' => 21, 
    'PS' => 18, 
    'PA' => 12, 
    'PG' => 20, 
    'PY' => 13, 
    'PE' => 13, 
    'PH' => 17, 
    'PN' => 22, 
    'PL' => 8, 
    'PT' => 9, 
    'PR' => 11, 
    'QA' => 18, 
    'RE' => 4, 
    'RO' => 8, 
    'RU' => 8, 
    'RW' => 4, 
    'BL' => 11, 
    'SH' => 2, 
    'KN' => 11, 
    'LC' => 11, 
    'MF' => 11, 
    'PM' => 10, 
    'VC' => 11, 
    'WS' => 22, 
    'SM' => 9, 
    'ST' => 3, 
    'SA' => 18, 
    'SN' => 2, 
    'RS' => 9, 
    'SC' => 4, 
    'SL' => 2, 
    'SG' => 17, 
    'SX' => 0, 
    'SK' => 8, 
    'SI' => 9, 
    'SB' => 20, 
    'SO' => 4, 
    'ZA' => 5, 
    'GS' => 0, 
    'SS' => 0, 
    'ES' => 9, 
    'LK' => 16, 
    'SD' => 1, 
    'SR' => 13, 
    'SJ' => 6, 
    'SZ' => 5, 
    'SE' => 6, 
    'CH' => 7, 
    'SY' => 18, 
    'TW' => 15, 
    'TJ' => 14, 
    'TZ' => 4, 
    'TH' => 17, 
    'TL' => 17, 
    'TG' => 2, 
    'TK' => 22, 
    'TO' => 22, 
    'TT' => 11, 
    'TN' => 1, 
    'TR' => 18, 
    'TM' => 14, 
    'TC' => 11, 
    'TV' => 22, 
    'UG' => 4, 
    'UA' => 8, 
    'AE' => 18, 
    'GB' => 6, 
    'US' => 10, 
    'UM' => 0, 
    'UY' => 13, 
    'UZ' => 14, 
    'VU' => 20, 
    'VE' => 13, 
    'VN' => 17, 
    'VG' => 11, 
    'VI' => 11, 
    'WF' => 22, 
    'EH' => 1, 
    'YE' => 18, 
    'ZM' => 4, 
    'ZW' => 4]
    
    @hash = Hash.new('Antarctica'=>'AQ', 
    'Bonaire, Sint Eustatius and Saba'=>'BQ', 
    'Bouvet Island'=>'BV', 
    'British Indian Ocean Territory'=>'IO', 
    'Christmas Island'=>'CX', 
    'Cocos (Keeling) Islands'=>'CC', 
    'Curacao'=>'CW', 
    'French Southern Territories'=>'TF', 
    'Heard Island and McDonald Islands'=>'HM', 
    'Sint Maarten (Dutch part)'=>'SX', 
    'South Georgia and the South Sandwich Islands'=>'GS', 
    'South Sudan'=>'SS', 
    'United States Minor Outlying Islands'=>'UM', 
    'Algeria'=>'DZ', 
    'Egypt'=>'EG', 
    'Libya'=>'LY', 
    'Morocco'=>'MA', 
    'Sudan'=>'SD', 
    'Tunisia'=>'TN', 
    'Western Sahara'=>'EH', 
    'Benin'=>'BJ', 
    'Burkina Faso'=>'BF', 
    'Cape Verde'=>'CV', 
    'Cote dIvoire'=>'CI', 
    'Gambia'=>'GM', 
    'Ghana'=>'GH', 
    'Guinea'=>'GN', 
    'Guinea-Bissau'=>'GW', 
    'Liberia'=>'LR', 
    'Mali'=>'ML', 
    'Mauritania'=>'MR', 
    'Niger'=>'NE', 
    'Nigeria'=>'NG', 
    'Saint Helena, Ascension and Tristan da Cunha'=>'SH', 
    'Senegal'=>'SN', 
    'Sierra Leone'=>'SL', 
    'Togo'=>'TG', 
    'Angola'=>'AO', 
    'Cameroon'=>'CM', 
    'Central African Republic'=>'CF', 
    'Chad'=>'TD', 
    'Congo'=>'CG', 
    'Congo, the Democratic Republic of the'=>'CD', 
    'Equatorial Guinea'=>'GQ', 
    'Gabon'=>'GA', 
    'Sao Tome and Principe'=>'ST', 
    'Burundi'=>'BI', 
    'Comoros'=>'KM', 
    'Djibouti'=>'DJ', 
    'Eritrea'=>'ER', 
    'Ethiopia'=>'ET', 
    'Kenya'=>'KE', 
    'Madagascar'=>'MG', 
    'Malawi'=>'MW', 
    'Mauritius'=>'MU', 
    'Mayotte'=>'YT', 
    'Mozambique'=>'MZ', 
    'Reunion'=>'RE', 
    'Rwanda'=>'RW', 
    'Seychelles'=>'SC', 
    'Somalia'=>'SO', 
    'Tanzania, United Republic of'=>'TZ', 
    'Uganda'=>'UG', 
    'Zambia'=>'ZM', 
    'Zimbabwe'=>'ZW', 
    'Botswana'=>'BW', 
    'Lesotho'=>'LS', 
    'Namibia'=>'NA', 
    'South Africa'=>'ZA', 
    'Swaziland'=>'SZ', 
    'Aland Islands'=>'AX', 
    'Denmark'=>'DK', 
    'Estonia'=>'EE', 
    'Faroe Islands'=>'FO', 
    'Finland'=>'FI', 
    'Guernsey'=>'GG', 
    'Iceland'=>'IS', 
    'Ireland'=>'IE', 
    'Isle of Man'=>'IM', 
    'Jersey'=>'JE', 
    'Latvia'=>'LV', 
    'Lithuania'=>'LT', 
    'Norway'=>'NO', 
    'Svalbard and Jan Mayen'=>'SJ', 
    'Sweden'=>'SE', 
    'United Kingdom'=>'GB', 
    'Austria'=>'AT', 
    'Belgium'=>'BE', 
    'France'=>'FR', 
    'Germany'=>'DE', 
    'Liechtenstein'=>'LI', 
    'Luxembourg'=>'LU', 
    'Monaco'=>'MC', 
    'Netherlands'=>'NL', 
    'Switzerland'=>'CH', 
    'Belarus'=>'BY', 
    'Bulgaria'=>'BG', 
    'Czech Republic'=>'CZ', 
    'Hungary'=>'HU', 
    'Moldova, Republic of'=>'MD', 
    'Poland'=>'PL', 
    'Romania'=>'RO', 
    'Russian Federation'=>'RU', 
    'Slovakia'=>'SK', 
    'Ukraine'=>'UA', 
    'Albania'=>'AL', 
    'Andorra'=>'AD', 
    'Bosnia and Herzegovina'=>'BA', 
    'Croatia'=>'HR', 
    'Gibraltar'=>'GI', 
    'Greece'=>'GR', 
    'Holy See (Vatican City State)'=>'VA', 
    'Italy'=>'IT', 
    'Macedonia, the former Yugoslav Republic of'=>'MK', 
    'Malta'=>'MT', 
    'Montenegro'=>'ME', 
    'Portugal'=>'PT', 
    'San Marino'=>'SM', 
    'Serbia'=>'RS', 
    'Slovenia'=>'SI', 
    'Spain'=>'ES', 
    'Bermuda'=>'BM', 
    'Canada'=>'CA', 
    'Greenland'=>'GL', 
    'Saint Pierre and Miquelon'=>'PM', 
    'United States'=>'US', 
    'Anguilla'=>'AI', 
    'Antigua and Barbuda'=>'AG', 
    'Aruba'=>'AW', 
    'Bahamas'=>'BS', 
    'Barbados'=>'BB', 
    'Cayman Islands'=>'KY', 
    'Cuba'=>'CU', 
    'Dominica'=>'DM', 
    'Dominican Republic'=>'DO', 
    'Grenada'=>'GD', 
    'Guadeloupe'=>'GP', 
    'Haiti'=>'HT', 
    'Jamaica'=>'JM', 
    'Martinique'=>'MQ', 
    'Montserrat'=>'MS', 
    'Puerto Rico'=>'PR', 
    'Saint Barthelemy'=>'BL', 
    'Saint Kitts and Nevis'=>'KN', 
    'Saint Lucia'=>'LC', 
    'Saint Martin (French part)'=>'MF', 
    'Saint Vincent and the Grenadines'=>'VC', 
    'Trinidad and Tobago'=>'TT', 
    'Turks and Caicos Islands'=>'TC', 
    'Virgin Islands, British'=>'VG', 
    'Virgin Islands, U.S.'=>'VI', 
    'Belize'=>'BZ', 
    'Costa Rica'=>'CR', 
    'El Salvador'=>'SV', 
    'Guatemala'=>'GT', 
    'Honduras'=>'HN', 
    'Mexico'=>'MX', 
    'Nicaragua'=>'NI', 
    'Panama'=>'PA', 
    'Argentina'=>'AR', 
    'Bolivia, Plurinational State of'=>'BO', 
    'Brazil'=>'BR', 
    'Chile'=>'CL', 
    'Colombia'=>'CO', 
    'Ecuador'=>'EC', 
    'Falkland Islands (Malvinas)'=>'FK', 
    'French Guiana'=>'GF', 
    'Guyana'=>'GY', 
    'Paraguay'=>'PY', 
    'Peru'=>'PE', 
    'Suriname'=>'SR', 
    'Uruguay'=>'UY', 
    'Venezuela, Bolivarian Republic of'=>'VE', 
    'Kazakhstan'=>'KZ', 
    'Kyrgyzstan'=>'KG', 
    'Tajikistan'=>'TJ', 
    'Turkmenistan'=>'TM', 
    'Uzbekistan'=>'UZ', 
    'China'=>'CN', 
    'Hong Kong'=>'HK', 
    'Japan'=>'JP', 
    'Korea, Democratic Peoples Republic of'=>'KP', 
    'Korea, Republic of'=>'KR', 
    'Macao'=>'MO', 
    'Mongolia'=>'MN', 
    'Taiwan, Province of China'=>'TW', 
    'Afghanistan'=>'AF', 
    'Bangladesh'=>'BD', 
    'Bhutan'=>'BT', 
    'India'=>'IN', 
    'Iran, Islamic Republic of'=>'IR', 
    'Maldives'=>'MV', 
    'Nepal'=>'NP', 
    'Pakistan'=>'PK', 
    'Sri Lanka'=>'LK', 
    'Brunei Darussalam'=>'BN', 
    'Cambodia'=>'KH', 
    'Indonesia'=>'ID', 
    'Lao Peoples Democratic Republic'=>'LA', 
    'Malaysia'=>'MY', 
    'Myanmar'=>'MM', 
    'Philippines'=>'PH', 
    'Singapore'=>'SG', 
    'Thailand'=>'TH', 
    'Timor-Leste'=>'TL', 
    'Viet Nam'=>'VN', 
    'Armenia'=>'AM', 
    'Azerbaijan'=>'AZ', 
    'Bahrain'=>'BH', 
    'Cyprus'=>'CY', 
    'Georgia'=>'GE', 
    'Iraq'=>'IQ', 
    'Israel'=>'IL', 
    'Jordan'=>'JO', 
    'Kuwait'=>'KW', 
    'Lebanon'=>'LB', 
    'Oman'=>'OM', 
    'Palestinian Territory, Occupied'=>'PS', 
    'Qatar'=>'QA', 
    'Saudi Arabia'=>'SA', 
    'Syrian Arab Republic'=>'SY', 
    'Turkey'=>'TR', 
    'United Arab Emirates'=>'AE', 
    'Yemen'=>'YE', 
    'Australia'=>'AU', 
    'New Zealand'=>'NZ', 
    'Norfolk Island'=>'NF', 
    'Fiji'=>'FJ', 
    'New Caledonia'=>'NC', 
    'Papua New Guinea'=>'PG', 
    'Solomon Islands'=>'SB', 
    'Vanuatu'=>'VU', 
    'Guam'=>'GU', 
    'Kiribati'=>'KI', 
    'Marshall Islands'=>'MH', 
    'Micronesia, Federated States of'=>'FM', 
    'Nauru'=>'NR', 
    'Northern Mariana Islands'=>'MP', 
    'Palau'=>'PW', 
    'American Samoa'=>'AS', 
    'Cook Islands'=>'CK', 
    'French Polynesia'=>'PF', 
    'Niue'=>'NU', 
    'Pitcairn'=>'PN', 
    'Samoa'=>'WS', 
    'Tokelau'=>'TK', 
    'Tonga'=>'TO', 
    'Tuvalu'=>'TV', 
    'Wallis and Futuna'=>'WF')

####### START OF SEARCH PAGES ###########
## ORGANIZATION SEARCH ##
  def organization_search
if (params[:resulting_ids].nil?)
    if ((params['subject'] == 'false') || params['subject'].nil?)
    params['subject'] = [  'Agriculture', 
      'Organic Farming', 
      'Sustainable Development', 
      'Animal Care', 
      'Animal Rights', 
      'Wildlife Conservation', 
      'Caregiving', 
      'Elder Care', 
      'Child/Orphan Care', 
      'Disabled Care', 
      'Feed the Homeless', 
      'Community Development', 
      'Youth Development and Outreach', 
      'Construction', 
      'Culture and Community', 
      'Performing Arts', 
      'Fashion', 
      'Music', 
      'Sports & Recreation', 
      'Journalism', 
      'Disaster Relief', 
      'Economics', 
      'Microfinance', 
      'Education', 
      'Teaching English', 
      'Teaching Buddhist Monks', 
      'Teaching Children', 
      'Teaching Computer Literacy', 
      'Engineering and Infrastructure', 
      'Environmental', 
      'Ecological Conservation', 
      'Sustainable Development', 
      'Wildlife Conservation', 
      'Habitat Restoration', 
      'Health and Medicine', 
      'HIV/AIDS', 
      'Nutrition', 
      'Family Planning', 
      'Veterinary Medicine', 
      'Clinical Work', 
      'Dental Work', 
      'Medical Research', 
      'Health Education', 
      'Public Health', 
      'Hospital Care-giving', 
      'Human Rights', 
      'Womens Initiatives', 
      'International Work Camp', 
      'Recreation', 
      'Adventure Travel', 
      'Scientific Research', 
      'Archaeology', 
      'Environmental Biology', 
      'Technology', 
      'Teaching Computer Literacy', 
      'Media Marketing and Graphic Design']
  end
  if (params['countries'].include?('NorthernAfrica'))
    params['countries'] = params['countries'] + ['DZ', 
    'EG', 
    'LY', 
    'MA', 
    'SD', 
    'TN', 
    'EH']
  end
  
  if (params['countries'].include?('WesternAfrica'))
     params['countries'] = params['countries'] + ['BJ', 
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
     'TG']
end
   
  if (params['countries'].include?('MiddleAfrica'))
    params['countries'] = params['countries'] + ['AO', 
    'CM', 
    'CF', 
    'TD', 
    'CG', 
    'CD', 
    'GQ', 
    'GA', 
    'ST']
  end
  
   if (params['countries'].include?('EasternAfrica'))
      params['countries'] = params['countries'] + ['BI', 
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
      'ZW']
  end
  
   if (params['countries'].include?('SouthernAfrica'))
      params['countries'] = params['countries'] + ['BW', 
      'LS', 
      'NA', 
      'ZA', 
      'SZ']
  end
  
   if ((params['countries'] == 'false') || params['countries'].nil?)
      params['countries'] = ['AF', 'AX', 'AL', 'DZ', 'AS', 'AD', 'AO', 'AI', 'AQ', 'AG', 'AR', 'AM', 'AW', 'AU', 'AT', 'AZ', 'BS', 'BH', 'BD', 'BB', 'BY', 'BE', 'BZ', 'BJ', 'BM', 'BT', 'BO', 'BQ', 'BA', 'BW', 'BV', 'BR', 'IO', 'BN', 'BG', 'BF', 'BI', 'KH', 'CM', 'CA', 'CV', 'KY', 'CF', 'TD', 'CL', 'CN', 'CX', 'CC', 'CO', 'KM', 'CG', 'CD', 'CK', 'CR', 'CI', 'HR', 'CU', 'CW', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', 'EC', 'EG', 'SV', 'GQ', 'ER', 'EE', 'ET', 'FK', 'FO', 'FJ', 'FI', 'FR', 'GF', 'PF', 'TF', 'GA', 'GM', 'GE', 'DE', 'GH', 'GI', 'GR', 'GL', 'GD', 'GP', 'GU', 'GT', 'GG', 'GN', 'GW', 'GY', 'HT', 'HM', 'VA', 'HN', 'HK', 'HU', 'IS', 'IN', 'ID', 'IR', 'IQ', 'IE', 'IM', 'IL', 'IT', 'JM', 'JP', 'JE', 'JO', 'KZ', 'KE', 'KI', 'KP', 'KR', 'KW', 'KG', 'LA', 'LV', 'LB', 'LS', 'LR', 'LY', 'LI', 'LT', 'LU', 'MO', 'MK', 'MG', 'MW', 'MY', 'MV', 'ML', 'MT', 'MH', 'MQ', 'MR', 'MU', 'YT', 'MX', 'FM', 'MD', 'MC', 'MN', 'ME', 'MS', 'MA', 'MZ', 'MM', 'NA', 'NR', 'NP', 'NL', 'NC', 'NZ', 'NI', 'NE', 'NG', 'NU', 'NF', 'MP', 'NO', 'OM', 'PK', 'PW', 'PS', 'PA', 'PG', 'PY', 'PE', 'PH', 'PN', 'PL', 'PT', 'PR', 'QA', 'RE', 'RO', 'RU', 'RW', 'BL', 'SH', 'KN', 'LC', 'MF', 'PM', 'VC', 'WS', 'SM', 'ST', 'SA', 'SN', 'RS', 'SC', 'SL', 'SG', 'SX', 'SK', 'SI', 'SB', 'SO', 'ZA', 'GS', 'SS', 'ES', 'LK', 'SD', 'SR', 'SJ', 'SZ', 'SE', 'CH', 'SY', 'TW', 'TJ', 'TZ', 'TH', 'TL', 'TG', 'TK', 'TO', 'TT', 'TN', 'TR', 'TM', 'TC', 'TV', 'UG', 'UA', 'AE', 'GB', 'US', 'UM', 'UY', 'UZ', 'VU', 'VE', 'VN', 'VG', 'VI', 'WF', 'EH', 'YE', 'ZM', 'ZW']
  end
  
   if (params['countries'].include?('NorthernEurope'))
      params['countries'] = params['countries'] + ['AX', 
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
      'GB']
  end
  
   if (params['countries'].include?('WesternEurope'))
      params['countries'] = params['countries'] + ['AT', 
      'BE', 
      'FR', 
      'DE', 
      'LI', 
      'LU', 
      'MC', 
      'NL', 
      'CH']
  end
  
   if (params['countries'].include?('EasternEurope'))
      params['countries'] = params['countries'] + ['BY', 
      'BG', 
      'CZ', 
      'HU', 
      'MD', 
      'PL', 
      'RO', 
      'RU', 
      'SK', 
      'UA']
  end
   
   if (params['countries'].include?('SouthernEurope'))
       params['countries'] = params['countries'] + ['AL', 
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
       'ES']
  end
  
   if (params['countries'].include?('NorthernAmerica'))
      params['countries'] = params['countries'] + ['BM', 
      'CA', 
      'GL', 
      'PM', 
      'US']
  end
  
  if (params['countries'].include?('Caribbean'))
      params['countries'] = params['countries'] + ['AI', 
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
      'VI']
end
  
  if (params['countries'].include?('CentralAmerica'))
      params['countries'] = params['countries'] + ['BZ', 
      'CR', 
      'SV', 
      'GT', 
      'HN', 
      'MX', 
      'NI', 
      'PA']
  end
  
  if (params['countries'].include?('SouthAmerica'))
      params['countries'] = params['countries'] + ['AR', 
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
      'VE']
end
  
  if (params['countries'].include?('CentralAsia'))
      params['countries'] = params['countries'] + ['KZ', 
      'KG', 
      'TJ', 
      'TM', 
      'UZ']
end
  
 if (params['countries'].include?('EasternAsia'))
      params['countries'] = params['countries'] + ['CN', 
      'HK', 
      'JP', 
      'KP', 
      'KR', 
      'MO', 
      'MN', 
      'TW']
end
  
  if (params['countries'].include?('SouthernAsia'))
      params['countries'] = params['countries'] + ['AF', 
      'BD', 
      'BT', 
      'IN', 
      'IR', 
      'MV', 
      'NP', 
      'PK', 
      'LK']
end
  
 if (params['countries'].include?('SouthEasternAsia'))
      params['countries'] = params['countries'] + ['BN', 
      'KH', 
      'ID', 
      'LA', 
      'MY', 
      'MM', 
      'PH', 
      'SG', 
      'TH', 
      'TL', 
      'VN']
end
  
 if (params['countries'].include?('WesternAsia'))
      params['countries'] = params['countries'] + ['AM', 
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
      'YE']
end
  
 if (params['countries'].include?('AustraliaandNewZealand'))
      params['countries'] = params['countries'] + ['AU', 
      'NZ', 
      'NF']
end
 
 if (params['countries'].include?('Melanesia'))
     params['countries'] = params['countries'] + ['FJ', 
     'NC', 
     'PG', 
     'SB', 
     'VU']
end

if (params['countries'].include?('Micronesia'))
    params['countries'] = params['countries'] + ['GU', 
    'KI', 
    'MH', 
    'FM', 
    'NR', 
    'MP', 
    'PW']
end

if (params['countries'].include?('Polynesia'))
    params['countries'] = params['countries'] + ['AS', 
    'CK', 
    'PF', 
    'NU', 
    'PN', 
    'WS', 
    'TK', 
    'TO', 
    'TV', 
    'WF']
end
  
  
  
  
  if ((params['group_size'] == 'false') || params['group_size'].nil?)
    params['group_size'] = ['Individual', 'Small Groups (2-3)', 'Medium Groups (4-10)', 'Large Groups (15+)']
  end
  
  if ((params['length'] == 'false') || params['length'].nil?)
    params['length'] = ['1 week or less', '2-4 weeks', '5-8 weeks', '9-12 weeks', '3-6 months', '6-12 months', '1-2 years', '2+ years']
  end
  
  if params['subject'].include?('Agriculture')
    params['subject'] = params['subject'] + ['Organic Farming', 'Sustainable Development']
  end
  if params['subject'].include?('Animal Care')
    params['subject'] = params['subject'] + ['Animal Rights', 'Wildlife Conservation']
  end
  if params['subject'].include?('Caregiving')
    params['subject'] = params['subject'] + ['Elder Care', 'Child/Orphan Care', 'Disabled Care', 'Feed the Homeless']
  end
  if params['subject'].include?('Community Development')
    params['subject'] = params['subject']+['Youth Development and Outreach']
  end
  if params['subject'].include?('Culture and Community')
    params['subject'] = params['subject'] + ['Performing Arts', 'Fashion', 'Music', 'Sports & Recreation', 'Journalism']
  end
  if params['subject'].include?('Disaster Relief')
    params['subject'] = params['subject'] + ['Economics', 'Microfinance']
  end
  if params['subject'].include?('Education')
    params['subject'] = params['subject'] + ['Teaching Buddhist Monks', 'Teaching Children', 'Teaching Computer Literacy']
  end
  if params['subject'].include?('Environmental')
    params['subject'] = params['subject'] + ['Ecological Conservation', 'Sustainable Development', 'Wildlife Conservation', 'Habitat Restoration']
  end
  if params['subject'].include?('Health and Medicine')
    params['subject'] = params['subject'] + ['HIV/AIDS', 'Family Planning', 'Nutrition', 'Veterinary Medicine', 'Clinical Work', 'Dental Work', 'Medical Research', 'Health Education', 'Public Health', 'Hospital Caregiving']
  end
  if params['subject'].include?('Human Rights')
    params['subject'] = params['subject'] + ['Womens Initiatives']
  end
  if params['subject'].include?('Recreation')
    params['subject'] = params['subject'] + ['Adventure Travel']
  end
  if params['subject'].include?('Scientific Research')
    params['subject'] = params['subject'] + ['Archaeology', 'Environmental Biology']
  end
  if params['subject'].include?('Technology')
    params['subject'] = params['subject'] + ['Teaching Computer Literacy', 'Media Marketing and Graphic Design']
  end
  
  
  
  
  if (params['countries'] != 'false' && params['countries'].include?('Americas'))
    params['countries'] = params['countries'] + ['DZ', 
    'EG', 
    'LY', 
    'MA', 
    'SD', 
    'TN', 
    'EH', 
    'BJ', 
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
    'TG', 
    'AO', 
    'CM', 
    'CF', 
    'TD', 
    'CG', 
    'CD', 
    'GQ', 
    'GA', 
    'ST', 
    'BI', 
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
    'ZW', 
    'BW', 
    'LS', 
    'NA', 
    'ZA', 
    'SZ']
  end
  
  if (params['countries'] != 'false' && params['countries'].include?('Europe'))
    params['countries'] = params['countries'] + ['AX', 
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
    'GB', 
    'AT', 
    'BE', 
    'FR', 
    'DE', 
    'LI', 
    'LU', 
    'MC', 
    'NL', 
    'CH', 
    'BY', 
    'BG', 
    'CZ', 
    'HU', 
    'MD', 
    'PL', 
    'RO', 
    'RU', 
    'SK', 
    'UA', 
    'AL', 
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
    'ES']
  end
  
  if (params['countries'] != 'false' && params['countries'].include?('Africa'))
    params['countries'] = params['countries'] + ['BM', 
    'CA', 
    'GL', 
    'PM', 
    'US', 
    'AI', 
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
    'VI', 
    'BZ', 
    'CR', 
    'SV', 
    'GT', 
    'HN', 
    'MX', 
    'NI', 
    'PA', 
    'AR', 
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
    'VE']
  end
  
  if (params['countries'] != 'false' && params['countries'].include?('Asia'))
    params['countries'] = params['countries'] + ['KZ', 
    'KG', 
    'TJ', 
    'TM', 
    'UZ', 
    'CN', 
    'HK', 
    'JP', 
    'KP', 
    'KR', 
    'MO', 
    'MN', 
    'TW', 
    'AF', 
    'BD', 
    'BT', 
    'IN', 
    'IR', 
    'MV', 
    'NP', 
    'PK', 
    'LK', 
    'BN', 
    'KH', 
    'ID', 
    'LA', 
    'MY', 
    'MM', 
    'PH', 
    'SG', 
    'TH', 
    'TL', 
    'VN', 
    'AM', 
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
    'YE']
  end
  
  if (params['countries'] != 'false' && params['countries'].include?('Oceania'))
    params['countries'] = params['countries'] + ['AU', 
    'NZ', 
    'NF', 
    'FJ', 
    'NC', 
    'PG', 
    'SB', 
    'VU', 
    'GU', 
    'KI', 
    'MH', 
    'FM', 
    'NR', 
    'MP', 
    'PW', 
    'AS', 
    'CK', 
    'PF', 
    'NU', 
    'PN', 
    'WS', 
    'TK', 
    'TO', 
    'TV', 
    'WF']
  end
else
     @params = params[:resulting_ids].split(';')
   if @params.last == 'all'
     params['subject'] = @params[0].gsub(/[\[\]]/,'').gsub(/[\\\"]/,'').split(',')
     params['countries'] = @params[1].gsub(/[\[\]]/,'').gsub(/[\\\"]/,'').split(',')
     params['price_max'] = @params[2]
     params['price_min'] = @params[3]
     params['length'] = @params[4].gsub(/[\[\]]/,'').gsub(/[\\\"]/,'').split(',')
     params['group_size'] = @params[5].gsub(/[\[\]]/,'').gsub(/[\\\"]/,'').split(',')
   end
   if @params.last == 'region'
      params[:region] = @params[0]
   end
   if @params.last == 'search'
      params[:search] = @params[0]
   end
end
  
    if !(params[:search].nil?)
      @search = Organization.search do
        keywords params[:search]
      end
      @results = @search.results
      @resulting_ids = "#{params[:search]};search"
    else
      if params[:region].nil?
        @search = Program.search do

           with(:subject).any_of(params['subject'])

           with(:location).any_of(params['countries'])
          
           with(:weekly_cost).less_than(params['price_max'])
  
            with(:weekly_cost).greater_than(params['price_min'])

           with(:length).any_of(params['length'])

           with(:group_size).any_of(params['group_size'])

        
         end
         @resulting_ids = "#{params['subject']};#{params['countries']};#{params['price_max']};#{params['price_min']};#{params['length']};#{params['group_size']};all"
         
       else
         @search = Program.search do
           with(:location).equal_to(params[:region])
         end
         @resulting_ids = "#{params[:region]};region"
       end
    
      @results = @search.results
   
      @resultsO = []
      @results.each do |f|
        @resultsO << Organization.find(f.organization_id) unless @results.include?(Organization.find(f.organization_id))
      end
   
      @results = @resultsO
   
    end
   
   @sort = params[:sort]
   if @sort.nil?
     @sort = 'ratinghigh'
   end
   
   if @sort == 'ratinghigh'
     @results = @results.sort_by(&:overall).reverse
   end
   if @sort == 'ratinglow'
     @results = @results.sort_by(&:overall)
   end
   if @sort == 'alphabetical'
     @results.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    
   end
   if @sort == 'pricelow'
     @results = @results.sort_by(&:weekly_cost)
   end
   if @sort == 'pricehigh'
     @results = @results.sort_by(&:weekly_cost).reverse
   end
   
  end
  
  def program_search
    if (params[:resulting_ids].nil?)
        if ((params['subject'] == 'false') || params['subject'].nil?)
        params['subject'] = [  'Agriculture', 
          'Organic Farming', 
          'Sustainable Development', 
          'Animal Care', 
          'Animal Rights', 
          'Wildlife Conservation', 
          'Caregiving', 
          'Elder Care', 
          'Child/Orphan Care', 
          'Disabled Care', 
          'Feed the Homeless', 
          'Community Development', 
          'Youth Development and Outreach', 
          'Construction', 
          'Culture and Community', 
          'Performing Arts', 
          'Fashion', 
          'Music', 
          'Sports & Recreation', 
          'Journalism', 
          'Disaster Relief', 
          'Economics', 
          'Microfinance', 
          'Education', 
          'Teaching English', 
          'Teaching Buddhist Monks', 
          'Teaching Children', 
          'Teaching Computer Literacy', 
          'Engineering and Infrastructure', 
          'Environmental', 
          'Ecological Conservation', 
          'Sustainable Development', 
          'Wildlife Conservation', 
          'Habitat Restoration', 
          'Health and Medicine', 
          'HIV/AIDS', 
          'Nutrition', 
          'Family Planning', 
          'Veterinary Medicine', 
          'Clinical Work', 
          'Dental Work', 
          'Medical Research', 
          'Health Education', 
          'Public Health', 
          'Hospital Care-giving', 
          'Human Rights', 
          'Womens Initiatives', 
          'International Work Camp', 
          'Recreation', 
          'Adventure Travel', 
          'Scientific Research', 
          'Archaeology', 
          'Environmental Biology', 
          'Technology', 
          'Teaching Computer Literacy', 
          'Media Marketing and Graphic Design']
      end
      if (params['countries'].include?('NorthernAfrica'))
        params['countries'] = params['countries'] + ['DZ', 
        'EG', 
        'LY', 
        'MA', 
        'SD', 
        'TN', 
        'EH']
      end

      if (params['countries'].include?('WesternAfrica'))
         params['countries'] = params['countries'] + ['BJ', 
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
         'TG']
    end

      if (params['countries'].include?('MiddleAfrica'))
        params['countries'] = params['countries'] + ['AO', 
        'CM', 
        'CF', 
        'TD', 
        'CG', 
        'CD', 
        'GQ', 
        'GA', 
        'ST']
      end

       if (params['countries'].include?('EasternAfrica'))
          params['countries'] = params['countries'] + ['BI', 
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
          'ZW']
      end

       if (params['countries'].include?('SouthernAfrica'))
          params['countries'] = params['countries'] + ['BW', 
          'LS', 
          'NA', 
          'ZA', 
          'SZ']
      end

       if ((params['countries'] == 'false') || params['countries'].nil?)
          params['countries'] = ['AF', 'AX', 'AL', 'DZ', 'AS', 'AD', 'AO', 'AI', 'AQ', 'AG', 'AR', 'AM', 'AW', 'AU', 'AT', 'AZ', 'BS', 'BH', 'BD', 'BB', 'BY', 'BE', 'BZ', 'BJ', 'BM', 'BT', 'BO', 'BQ', 'BA', 'BW', 'BV', 'BR', 'IO', 'BN', 'BG', 'BF', 'BI', 'KH', 'CM', 'CA', 'CV', 'KY', 'CF', 'TD', 'CL', 'CN', 'CX', 'CC', 'CO', 'KM', 'CG', 'CD', 'CK', 'CR', 'CI', 'HR', 'CU', 'CW', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', 'EC', 'EG', 'SV', 'GQ', 'ER', 'EE', 'ET', 'FK', 'FO', 'FJ', 'FI', 'FR', 'GF', 'PF', 'TF', 'GA', 'GM', 'GE', 'DE', 'GH', 'GI', 'GR', 'GL', 'GD', 'GP', 'GU', 'GT', 'GG', 'GN', 'GW', 'GY', 'HT', 'HM', 'VA', 'HN', 'HK', 'HU', 'IS', 'IN', 'ID', 'IR', 'IQ', 'IE', 'IM', 'IL', 'IT', 'JM', 'JP', 'JE', 'JO', 'KZ', 'KE', 'KI', 'KP', 'KR', 'KW', 'KG', 'LA', 'LV', 'LB', 'LS', 'LR', 'LY', 'LI', 'LT', 'LU', 'MO', 'MK', 'MG', 'MW', 'MY', 'MV', 'ML', 'MT', 'MH', 'MQ', 'MR', 'MU', 'YT', 'MX', 'FM', 'MD', 'MC', 'MN', 'ME', 'MS', 'MA', 'MZ', 'MM', 'NA', 'NR', 'NP', 'NL', 'NC', 'NZ', 'NI', 'NE', 'NG', 'NU', 'NF', 'MP', 'NO', 'OM', 'PK', 'PW', 'PS', 'PA', 'PG', 'PY', 'PE', 'PH', 'PN', 'PL', 'PT', 'PR', 'QA', 'RE', 'RO', 'RU', 'RW', 'BL', 'SH', 'KN', 'LC', 'MF', 'PM', 'VC', 'WS', 'SM', 'ST', 'SA', 'SN', 'RS', 'SC', 'SL', 'SG', 'SX', 'SK', 'SI', 'SB', 'SO', 'ZA', 'GS', 'SS', 'ES', 'LK', 'SD', 'SR', 'SJ', 'SZ', 'SE', 'CH', 'SY', 'TW', 'TJ', 'TZ', 'TH', 'TL', 'TG', 'TK', 'TO', 'TT', 'TN', 'TR', 'TM', 'TC', 'TV', 'UG', 'UA', 'AE', 'GB', 'US', 'UM', 'UY', 'UZ', 'VU', 'VE', 'VN', 'VG', 'VI', 'WF', 'EH', 'YE', 'ZM', 'ZW']
      end

       if (params['countries'].include?('NorthernEurope'))
          params['countries'] = params['countries'] + ['AX', 
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
          'GB']
      end

       if (params['countries'].include?('WesternEurope'))
          params['countries'] = params['countries'] + ['AT', 
          'BE', 
          'FR', 
          'DE', 
          'LI', 
          'LU', 
          'MC', 
          'NL', 
          'CH']
      end

       if (params['countries'].include?('EasternEurope'))
          params['countries'] = params['countries'] + ['BY', 
          'BG', 
          'CZ', 
          'HU', 
          'MD', 
          'PL', 
          'RO', 
          'RU', 
          'SK', 
          'UA']
      end

       if (params['countries'].include?('SouthernEurope'))
           params['countries'] = params['countries'] + ['AL', 
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
           'ES']
      end

       if (params['countries'].include?('NorthernAmerica'))
          params['countries'] = params['countries'] + ['BM', 
          'CA', 
          'GL', 
          'PM', 
          'US']
      end

      if (params['countries'].include?('Caribbean'))
          params['countries'] = params['countries'] + ['AI', 
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
          'VI']
    end

      if (params['countries'].include?('CentralAmerica'))
          params['countries'] = params['countries'] + ['BZ', 
          'CR', 
          'SV', 
          'GT', 
          'HN', 
          'MX', 
          'NI', 
          'PA']
      end

      if (params['countries'].include?('SouthAmerica'))
          params['countries'] = params['countries'] + ['AR', 
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
          'VE']
    end

      if (params['countries'].include?('CentralAsia'))
          params['countries'] = params['countries'] + ['KZ', 
          'KG', 
          'TJ', 
          'TM', 
          'UZ']
    end

     if (params['countries'].include?('EasternAsia'))
          params['countries'] = params['countries'] + ['CN', 
          'HK', 
          'JP', 
          'KP', 
          'KR', 
          'MO', 
          'MN', 
          'TW']
    end

      if (params['countries'].include?('SouthernAsia'))
          params['countries'] = params['countries'] + ['AF', 
          'BD', 
          'BT', 
          'IN', 
          'IR', 
          'MV', 
          'NP', 
          'PK', 
          'LK']
    end

     if (params['countries'].include?('SouthEasternAsia'))
          params['countries'] = params['countries'] + ['BN', 
          'KH', 
          'ID', 
          'LA', 
          'MY', 
          'MM', 
          'PH', 
          'SG', 
          'TH', 
          'TL', 
          'VN']
    end

     if (params['countries'].include?('WesternAsia'))
          params['countries'] = params['countries'] + ['AM', 
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
          'YE']
    end

     if (params['countries'].include?('AustraliaandNewZealand'))
          params['countries'] = params['countries'] + ['AU', 
          'NZ', 
          'NF']
    end

     if (params['countries'].include?('Melanesia'))
         params['countries'] = params['countries'] + ['FJ', 
         'NC', 
         'PG', 
         'SB', 
         'VU']
    end

    if (params['countries'].include?('Micronesia'))
        params['countries'] = params['countries'] + ['GU', 
        'KI', 
        'MH', 
        'FM', 
        'NR', 
        'MP', 
        'PW']
    end

    if (params['countries'].include?('Polynesia'))
        params['countries'] = params['countries'] + ['AS', 
        'CK', 
        'PF', 
        'NU', 
        'PN', 
        'WS', 
        'TK', 
        'TO', 
        'TV', 
        'WF']
    end




      if ((params['group_size'] == 'false') || params['group_size'].nil?)
        params['group_size'] = ['Individual', 'Small Groups (2-3)', 'Medium Groups (4-10)', 'Large Groups (15+)']
      end

      if ((params['length'] == 'false') || params['length'].nil?)
        params['length'] = ['1 week or less', '2-4 weeks', '5-8 weeks', '9-12 weeks', '3-6 months', '6-12 months', '1-2 years', '2+ years']
      end

      if params['subject'].include?('Agriculture')
        params['subject'] = params['subject'] + ['Organic Farming', 'Sustainable Development']
      end
      if params['subject'].include?('Animal Care')
        params['subject'] = params['subject'] + ['Animal Rights', 'Wildlife Conservation']
      end
      if params['subject'].include?('Caregiving')
        params['subject'] = params['subject'] + ['Elder Care', 'Child/Orphan Care', 'Disabled Care', 'Feed the Homeless']
      end
      if params['subject'].include?('Community Development')
        params['subject'] = params['subject']+['Youth Development and Outreach']
      end
      if params['subject'].include?('Culture and Community')
        params['subject'] = params['subject'] + ['Performing Arts', 'Fashion', 'Music', 'Sports & Recreation', 'Journalism']
      end
      if params['subject'].include?('Disaster Relief')
        params['subject'] = params['subject'] + ['Economics', 'Microfinance']
      end
      if params['subject'].include?('Education')
        params['subject'] = params['subject'] + ['Teaching Buddhist Monks', 'Teaching Children', 'Teaching Computer Literacy']
      end
      if params['subject'].include?('Environmental')
        params['subject'] = params['subject'] + ['Ecological Conservation', 'Sustainable Development', 'Wildlife Conservation', 'Habitat Restoration']
      end
      if params['subject'].include?('Health and Medicine')
        params['subject'] = params['subject'] + ['HIV/AIDS', 'Family Planning', 'Nutrition', 'Veterinary Medicine', 'Clinical Work', 'Dental Work', 'Medical Research', 'Health Education', 'Public Health', 'Hospital Caregiving']
      end
      if params['subject'].include?('Human Rights')
        params['subject'] = params['subject'] + ['Womens Initiatives']
      end
      if params['subject'].include?('Recreation')
        params['subject'] = params['subject'] + ['Adventure Travel']
      end
      if params['subject'].include?('Scientific Research')
        params['subject'] = params['subject'] + ['Archaeology', 'Environmental Biology']
      end
      if params['subject'].include?('Technology')
        params['subject'] = params['subject'] + ['Teaching Computer Literacy', 'Media Marketing and Graphic Design']
      end




      if (params['countries'] != 'false' && params['countries'].include?('Americas'))
        params['countries'] = params['countries'] + ['DZ', 
        'EG', 
        'LY', 
        'MA', 
        'SD', 
        'TN', 
        'EH', 
        'BJ', 
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
        'TG', 
        'AO', 
        'CM', 
        'CF', 
        'TD', 
        'CG', 
        'CD', 
        'GQ', 
        'GA', 
        'ST', 
        'BI', 
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
        'ZW', 
        'BW', 
        'LS', 
        'NA', 
        'ZA', 
        'SZ']
      end

      if (params['countries'] != 'false' && params['countries'].include?('Europe'))
        params['countries'] = params['countries'] + ['AX', 
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
        'GB', 
        'AT', 
        'BE', 
        'FR', 
        'DE', 
        'LI', 
        'LU', 
        'MC', 
        'NL', 
        'CH', 
        'BY', 
        'BG', 
        'CZ', 
        'HU', 
        'MD', 
        'PL', 
        'RO', 
        'RU', 
        'SK', 
        'UA', 
        'AL', 
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
        'ES']
      end

      if (params['countries'] != 'false' && params['countries'].include?('Africa'))
        params['countries'] = params['countries'] + ['BM', 
        'CA', 
        'GL', 
        'PM', 
        'US', 
        'AI', 
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
        'VI', 
        'BZ', 
        'CR', 
        'SV', 
        'GT', 
        'HN', 
        'MX', 
        'NI', 
        'PA', 
        'AR', 
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
        'VE']
      end

      if (params['countries'] != 'false' && params['countries'].include?('Asia'))
        params['countries'] = params['countries'] + ['KZ', 
        'KG', 
        'TJ', 
        'TM', 
        'UZ', 
        'CN', 
        'HK', 
        'JP', 
        'KP', 
        'KR', 
        'MO', 
        'MN', 
        'TW', 
        'AF', 
        'BD', 
        'BT', 
        'IN', 
        'IR', 
        'MV', 
        'NP', 
        'PK', 
        'LK', 
        'BN', 
        'KH', 
        'ID', 
        'LA', 
        'MY', 
        'MM', 
        'PH', 
        'SG', 
        'TH', 
        'TL', 
        'VN', 
        'AM', 
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
        'YE']
      end

      if (params['countries'] != 'false' && params['countries'].include?('Oceania'))
        params['countries'] = params['countries'] + ['AU', 
        'NZ', 
        'NF', 
        'FJ', 
        'NC', 
        'PG', 
        'SB', 
        'VU', 
        'GU', 
        'KI', 
        'MH', 
        'FM', 
        'NR', 
        'MP', 
        'PW', 
        'AS', 
        'CK', 
        'PF', 
        'NU', 
        'PN', 
        'WS', 
        'TK', 
        'TO', 
        'TV', 
        'WF']
      end
  else
     @params = params[:resulting_ids].split(';')
    if @params.last == 'all'
      params['subject'] = @params[0].gsub(/[\[\]]/,'').gsub(/[\\\"]/,'').split(',')
      params['countries'] = @params[1].gsub(/[\[\]]/,'').gsub(/[\\\"]/,'').split(',')
      params['price_max'] = @params[2]
      params['price_min'] = @params[3]
      params['length'] = @params[4].gsub(/[\[\]]/,'').gsub(/[\\\"]/,'').split(',')
      params['group_size'] = @params[5].gsub(/[\[\]]/,'').gsub(/[\\\"]/,'').split(',')
      @searched1 = "last is all"
    end
    if @params.last == 'region'
       params[:region] = @params[0]
       @searched2 = "last is region"
    end
    if @params.last == 'search'
       params[:search] = @params[0]
       @searched3 = "last is search"
    end
  end
  
         if !(params[:search].nil?)
            @search = Program.search do
              keywords params[:search]
            end
            @results = @search.results
            @resulting_ids = "#{params[:search]};search"

          else
            if params[:region].nil?
              @search = Program.search do

                 with(:subject).any_of(params['subject'])

                 with(:location).any_of(params['countries'])

                 with(:weekly_cost).less_than(params['price_max'])

                  with(:weekly_cost).greater_than(params['price_min'])

                 with(:length).any_of(params['length'])

                 with(:group_size).any_of(params['group_size'])


               end
               @resulting_ids = "#{params['subject']};#{params['countries']};#{params['price_max']};#{params['price_min']};#{params['length']};#{params['group_size']};all"

             else
               @search = Program.search do
                 with(:location).equal_to(params[:region])
               end
               @resulting_ids = "#{params[:region]};region"

             end
              
            @results = @search.results

            
          end

         @sort = params[:sort]
         if @sort.nil?
           @sort = 'ratinghigh'
         end

         if @sort == 'ratinghigh'
           @results = @results.sort_by(&:overall).reverse
         end
         if @sort == 'ratinglow'
           @results = @results.sort_by(&:overall)
         end
         if @sort == 'alphabetical'
           @results.sort! { |a,b| a.name.downcase <=> b.name.downcase }

         end
         if @sort == 'pricelow'
           @results = @results.sort_by(&:weekly_cost)
         end
         if @sort == 'pricehigh'
           @results = @results.sort_by(&:weekly_cost).reverse
         end

        end
  
    
end
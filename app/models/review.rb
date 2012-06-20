class Review < ActiveRecord::Base
require 'file_size_validator'
@orgs = []
Organization.all.each do |f|
  @orgs << f.name
end
validate :check_bad_words
validates :terms, :acceptance => {:accept => true}
validates :program_id, :presence => true
validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
characters."
validates_length_of :body, :maximum => 10000, :message => "You have entered more than 10,000 characters"
validates_inclusion_of :organization_name, :in => @orgs
validates :photo, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo2, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo3, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo4, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo5, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo6, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo7, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo8, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo9, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo10, :file_size => {:maximum => 0.5.megabytes.to_i}
belongs_to :program
belongs_to :user
has_many :flags, :dependent => :destroy




attr_accessible :user_id, :program_id, :body, :rating, :photo, :show, :organization_id, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :photo2, :photo3, :photo4, :photo5, :photo6, :photo7, :photo8, :photo9, :photo10, :organization_name

# Paperclip
mount_uploader :photo, ImageUploader
mount_uploader :photo2, ImageUploader
mount_uploader :photo3, ImageUploader
mount_uploader :photo4, ImageUploader
mount_uploader :photo5, ImageUploader
mount_uploader :photo6, ImageUploader
mount_uploader :photo7, ImageUploader
mount_uploader :photo8, ImageUploader
mount_uploader :photo9, ImageUploader
mount_uploader :photo10, ImageUploader

def check_bad_words
  @bad_words = ['ahole', 
  'anus', 
  'ash0le', 
  'ash0les', 
  'asholes', 
  'ass', 
  'Ass Monkey', 
  'Assface', 
  'assh0le', 
  'assh0lez', 
  'asshole', 
  'assholes', 
  'assholz', 
  'asswipe', 
  'azzhole', 
  'bassterds', 
  'bastard', 
  'bastards', 
  'bastardz', 
  'basterds', 
  'basterdz', 
  'Biatch', 
  'bitch', 
  'bitches', 
  'Blow Job', 
  'boffing', 
  'butthole', 
  'buttwipe', 
  'c0ck', 
  'c0cks', 
  'c0k', 
  'Carpet Muncher', 
  'cawk', 
  'cawks', 
  'Clit', 
  'cnts', 
  'cntz', 
  'cock', 
  'cockhead', 
  'cock-head', 
  'cocks', 
  'CockSucker', 
  'cock-sucker', 
  'crap', 
  'cum', 
  'cunt', 
  'cunts', 
  'cuntz', 
  'dick', 
  'dild0', 
  'dild0s', 
  'dildo', 
  'dildos', 
  'dilld0', 
  'dilld0s', 
  'dominatricks', 
  'dominatrics', 
  'dominatrix', 
  'dyke', 
  'enema', 
  'f u c k', 
  'f u c k e r', 
  'fag', 
  'fag1t', 
  'faget', 
  'fagg1t', 
  'faggit', 
  'faggot', 
  'fagit', 
  'fags', 
  'fagz', 
  'faig', 
  'faigs', 
  'fart', 
  'flipping the bird', 
  'fuck', 
  'fucker', 
  'fuckin', 
  'fucking', 
  'fucks', 
  'Fudge Packer', 
  'fuk', 
  'Fukah', 
  'Fuken', 
  'fuker', 
  'Fukin', 
  'Fukk', 
  'Fukkah', 
  'Fukken', 
  'Fukker', 
  'Fukkin', 
  'g00k', 
  'gay', 
  'gayboy', 
  'gaygirl', 
  'gays', 
  'gayz', 
  'God-damned', 
  'h00r', 
  'h0ar', 
  'h0re', 
  'hells', 
  'hoar', 
  'hoor', 
  'hoore', 
  'jackoff', 
  'jap', 
  'japs', 
  'jerk-off', 
  'jisim', 
  'jiss', 
  'jizm', 
  'jizz', 
  'knob', 
  'knobs', 
  'knobz', 
  'kunt', 
  'kunts', 
  'kuntz', 
  'Lesbian', 
  'Lezzian', 
  'Lipshits', 
  'Lipshitz', 
  'masochist', 
  'masokist', 
  'massterbait', 
  'masstrbait', 
  'masstrbate', 
  'masterbaiter', 
  'masterbate', 
  'masterbates', 
  'Motha Fucker', 
  'Motha Fuker', 
  'Motha Fukkah', 
  'Motha Fukker', 
  'Mother Fucker', 
  'Mother Fukah', 
  'Mother Fuker', 
  'Mother Fukkah', 
  'Mother Fukker', 
  'mother-fucker', 
  'Mutha Fucker', 
  'Mutha Fukah', 
  'Mutha Fuker', 
  'Mutha Fukkah', 
  'Mutha Fukker', 
  'n1gr', 
  'nastt', 
  'nigger;', 
  'nigur;', 
  'niiger;', 
  'niigr;', 
  'orafis', 
  'orgasim;', 
  'orgasm', 
  'orgasum', 
  'oriface', 
  'orifice', 
  'orifiss', 
  'packi', 
  'packie', 
  'packy', 
  'paki', 
  'pakie', 
  'paky', 
  'pecker', 
  'peeenus', 
  'peeenusss', 
  'peenus', 
  'peinus', 
  'pen1s', 
  'penas', 
  'penis', 
  'penis-breath', 
  'penus', 
  'penuus', 
  'Phuc', 
  'Phuck', 
  'Phuk', 
  'Phuker', 
  'Phukker', 
  'polac', 
  'polack', 
  'polak', 
  'Poonani', 
  'pr1c', 
  'pr1ck', 
  'pr1k', 
  'pusse', 
  'pussee', 
  'pussy', 
  'puuke', 
  'puuker', 
  'queer', 
  'queers', 
  'queerz', 
  'qweers', 
  'qweerz', 
  'qweir', 
  'recktum', 
  'rectum', 
  'retard', 
  'sadist', 
  'scank', 
  'schlong', 
  'screwing', 
  'semen', 
  'sex', 
  'sexy', 
  'Sh!t', 
  'sh1t', 
  'sh1ter', 
  'sh1ts', 
  'sh1tter', 
  'sh1tz', 
  'shit', 
  'shits', 
  'shitter', 
  'Shitty', 
  'Shity', 
  'shitz', 
  'Shyt', 
  'Shyte', 
  'Shytty', 
  'Shyty', 
  'skanck', 
  'skank', 
  'skankee', 
  'skankey', 
  'skanks', 
  'Skanky', 
  'slut', 
  'sluts', 
  'Slutty', 
  'slutz', 
  'son-of-a-bitch', 
  'tit', 
  'turd', 
  'va1jina', 
  'vag1na', 
  'vagiina', 
  'vagina', 
  'vaj1na', 
  'vajina', 
  'vullva', 
  'vulva', 
  'w0p', 
  'wh00r', 
  'wh0re', 
  'whore', 
  'xrated', 
  'xxx', 
  'b!+ch', 
  'bitch', 
  'blowjob', 
  'clit', 
  'arschloch', 
  'fuck', 
  'shit', 
  'ass', 
  'asshole', 
  'b!tch', 
  'b17ch', 
  'b1tch', 
  'bastard', 
  'bi+ch', 
  'boiolas', 
  'buceta', 
  'c0ck', 
  'cawk', 
  'chink', 
  'cipa', 
  'clits', 
  'cock', 
  'cum', 
  'cunt', 
  'dildo', 
  'dirsa', 
  'ejakulate', 
  'fatass', 
  'fcuk', 
  'fuk', 
  'fux0r', 
  'hoer', 
  'hore', 
  'jism', 
  'kawk', 
  'l3itch', 
  'l3i+ch', 
  'lesbian', 
  'masturbate', 
  'masterbat*', 
  'masterbat3', 
  'motherfucker', 
  's.o.b.', 
  'mofo', 
  'nazi', 
  'nigga', 
  'nigger', 
  'nutsack', 
  'phuck', 
  'pimpis', 
  'pusse', 
  'pussy', 
  'scrotum', 
  'sh!t', 
  'shemale', 
  'shi+', 
  'sh!+', 
  'slut', 
  'smut', 
  'teets', 
  'tits', 
  'boobs', 
  'b00bs', 
  'teez', 
  'testical', 
  'testicle', 
  'titt', 
  'w00se', 
  'jackoff', 
  'wank', 
  'whoar', 
  'whore', 
  '*damn', 
  '*dyke', 
  '*fuck*', 
  '*shit*', 
  '@$$', 
  'amcik', 
  'andskota', 
  'arse*', 
  'assrammer', 
  'ayir', 
  'bi7ch', 
  'bitch*', 
  'bollock*', 
  'breasts', 
  'butt-pirate', 
  'cabron', 
  'cazzo', 
  'chraa', 
  'chuj', 
  'Cock*', 
  'cunt*', 
  'd4mn', 
  'daygo', 
  'dego', 
  'dick*', 
  'dike*', 
  'dupa', 
  'dziwka', 
  'ejackulate', 
  'Ekrem*', 
  'Ekto', 
  'enculer', 
  'faen', 
  'fag*', 
  'fanculo', 
  'fanny', 
  'feces', 
  'feg', 
  'Felcher', 
  'ficken', 
  'fitt*', 
  'Flikker', 
  'foreskin', 
  'Fotze', 
  'Fu(*', 
  'fuk*', 
  'futkretzn', 
  'gay', 
  'gook', 
  'guiena', 
  'h0r', 
  'h4x0r', 
  'hell', 
  'helvete', 
  'hoer*', 
  'honkey', 
  'Huevon', 
  'hui', 
  'injun', 
  'jizz', 
  'kanker*', 
  'kike', 
  'klootzak', 
  'kraut', 
  'knulle', 
  'kuk', 
  'kuksuger', 
  'Kurac', 
  'kurwa', 
  'kusi*', 
  'kyrpa*', 
  'lesbo', 
  'mamhoon', 
  'masturbat*', 
  'merd*', 
  'mibun', 
  'monkleigh', 
  'mouliewop', 
  'muie', 
  'mulkku', 
  'muschi', 
  'nazis', 
  'nepesaurio', 
  'nigger*', 
  'orospu', 
  'paska*', 
  'perse', 
  'picka', 
  'pierdol*', 
  'pillu*', 
  'pimmel', 
  'piss*', 
  'pizda', 
  'poontsee', 
  'poop', 
  'porn', 
  'p0rn', 
  'pr0n', 
  'preteen', 
  'pula', 
  'pule', 
  'puta', 
  'puto', 
  'qahbeh', 
  'queef*', 
  'rautenberg', 
  'schaffer', 
  'scheiss*', 
  'schlampe', 
  'schmuck', 
  'screw', 
  'sh!t*', 
  'sharmuta', 
  'sharmute', 
  'shipal', 
  'shiz', 
  'skribz', 
  'skurwysyn', 
  'sphencter', 
  'spic', 
  'spierdalaj', 
  'splooge', 
  'suka', 
  'b00b*', 
  'testicle*', 
  'titt*', 
  'twat', 
  'vittu', 
  'wank*', 
  'wetback*', 
  'wichser', 
  'wop*', 
  'yed', 
  'zabourah']
  errors.add_to_base("#{path} is a protected word. Please try another.") if @bad_words.include? path
end


end

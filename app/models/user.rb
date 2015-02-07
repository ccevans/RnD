class User < ActiveRecord::Base
  has_merit
  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_uniqueness_of :username
  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/ }


  ROLES = %w[registered admin moderator editor banned]

  def role?(base_role)
        role.present? && ROLES.index(base_role.to_s) <= ROLES.index(role)
    end

  has_many :lyrics, dependent: :destroy
  has_many :adminlyrics     
  has_many :comments, dependent: :destroy  
  has_many :arts, dependent: :destroy
  has_many :commentarts, dependent: :destroy
  has_many :commentlyrics, dependent: :destroy
  has_many :campaigns
  has_many :ratings
  has_many :galleries
  has_many :booths
  has_many :posts, dependent: :destroy
  has_many :commentposts, dependent: :destroy

  
  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "50x50#", :mini => "20x20#"  }, :default_url => "/images/:style/black-logo-gasmask.png" 
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_attached_file :profileimg, :styles => { :large => "1200x400#", :medium => "300x100#"  }, :default_url => "/images/:style/profile-missing.png" 
  validates_attachment_content_type :profileimg, :content_type => /\Aimage\/.*\Z/

  accepts_nested_attributes_for :galleries, reject_if: proc { |attributes| attributes['picture'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :booths, reject_if: proc { |attributes| attributes['song'].blank? }, :allow_destroy => true


 acts_as_follower
 acts_as_followable

 TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation! if user.respond_to?(:skip_confirmation)
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
 
  
end

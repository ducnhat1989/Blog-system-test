class User < ActiveRecord::Base
	has_many :entries, dependent: :destroy

	has_secure_password
	validates :name, presence: true, length: { maximum: 50 }
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }


	def User.new_remember_token
	   SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
	   Digest::SHA1.hexdigest(token.to_s)
	end
end

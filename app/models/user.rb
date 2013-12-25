class User < ActiveRecord::Base

	has_secure_password

	def User.new_remember_token
	   SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
	   Digest::SHA1.hexdigest(token.to_s)
	end
end

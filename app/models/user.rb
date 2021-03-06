class User < ApplicationRecord
    has_secure_password #validation presence of password
    has_many :shoes
    has_many :brands, through:  :shoes
    validates :email, uniqueness: true
    validates :username, :email, presence: true

    def self.create_from_omniauth(auth)
        User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            u.username = auth['info']['first_name']
            u.email = auth['info']['email']
            u.password = SecureRandom.hex(16)
        end
    end
end

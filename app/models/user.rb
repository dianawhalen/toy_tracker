class User < ActiveRecord::Base
  has_secure_password
  has_many :toys
  has_many :designers, through: :toys
end

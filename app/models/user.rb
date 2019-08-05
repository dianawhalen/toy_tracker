class User < ActiveRecord::Base
  has_secure_password
  has_many :toy_users
  has_many :toys, through: :toy_users
  has_many :designers, through: :toys
end

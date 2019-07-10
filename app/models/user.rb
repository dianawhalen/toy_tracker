class User < ActiveRecord::Base
  has_many :toys
  has_many :designers, through: :toys
end

class Designer < ActiveRecord::Base
  has_many :toys
  has_many :users, through: :toys
end

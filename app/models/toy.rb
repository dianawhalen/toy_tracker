class Toy < ActiveRecord::Base
  belongs_to :designer
  has_many :toy_users
  has_many :users, through: :toy_users
end

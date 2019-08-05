class ToyUser < ActiveRecord::Base
  belongs_to :toy
  belongs_to :user
end

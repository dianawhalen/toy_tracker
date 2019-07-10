class Toy < ActiveRecord::Base
  belongs_to :user
  belongs_to :designer
end

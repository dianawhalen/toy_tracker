class Toy < ActiveRecord::Base
  belongs_to :designer
  has_many :toy_users
  has_many :users, through: :toy_users

  def slug
    name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    Toy.all.find { |toy| toy.slug == slug }
  end
end

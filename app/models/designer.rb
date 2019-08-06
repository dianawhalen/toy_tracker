class Designer < ActiveRecord::Base
  has_many :toys
  has_many :users, through: :toys

  def slug
    name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    Designer.all.find { |designer| designer.slug == slug }
  end
end

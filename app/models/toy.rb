class Toy < ActiveRecord::Base
  belongs_to :user

  def slug
    name.gsub(" ", "-").downcase + "#{-id}"
  end

  def self.find_by_slug(slug)
    Toy.all.find { |toy| toy.slug == slug }
  end
end

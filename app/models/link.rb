class Link < ActiveRecord::Base
  attr_accessible :description, :title, :url

  validates :url, presence: true
end

class URIValidator < ActiveModel::Validator
    def validate(record)
        uri = URI::parse(record.url)
        if not (uri.kind_of? URI::HTTP or uri.kind_of? URI::HTTPS)
            record.errors[:url] << "is invalid. Must start with http:// or https://"
        end
    end
end

class Link < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :title, :url
  validates_with URIValidator, :fields => [:url]
end

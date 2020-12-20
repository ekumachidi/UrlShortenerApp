class ShortUrl < ApplicationRecord
  validates_uniqueness_of :slug
  validates :original_url, presence: true, uniqueness: true,
                           format: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                           length: {minimum:11, maximum:255}

  before_create :generate_slug

  def generate_slug
    self.slug = SecureRandom.uuid[0..5]
    true
  end

  #we can sanitize the url for better security
end

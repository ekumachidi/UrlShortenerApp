class FetchPageTitleJob < ApplicationJob
  require 'open-uri'
  require 'nokogiri'

  queue_as :default

  def perform(short_url)
    html = open(short_url.original_url)
    doc = Nokogiri::HTML(html)
    page_title = doc.css('title').text
    short_url.update_attribute(:title, page_title) if page_title.present?
  rescue SocketError => e
    logger = Rails.logger
    logger.error e
  end
end

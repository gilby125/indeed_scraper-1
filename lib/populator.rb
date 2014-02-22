class Populator
  def self.indeed key_word='ruby', pages=10, country_code='ca'
    results=Scrapers::Indeed.new(country_code).scrape(key_word, pages)
    results.each do |result|
      JobPost.find_or_create_by_job_id result['job_id'], result
    end
  end
end

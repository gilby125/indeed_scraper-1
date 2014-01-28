require 'wombat'

Wombat.crawl do
  base_url 'http://www.indeed.ca'
  path '/jobs?q=ruby&l='

  jobs 'css=#resultsCol>.row', :iterator do
    job 'css=h2>a'
    company 'css=.company'
    location 'css=.location'
    summary 'css=.summary'
    days_ago 'css=.date'
    source 'css=.sdn'
  end
end

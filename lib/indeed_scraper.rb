require 'wombat'
require 'httpclient'
require 'uri'

class Indeed
  def scrape pages=10
    jobs = (pages.times.collect do |page_no|
      limit = (page_no-1)*20

      page_results = Wombat.crawl do
        base_url 'http://www.indeed.ca'
        path "/jobs?q=ruby&start=#{limit}"

        jobs 'css=#resultsCol>.row', :iterator do
          job 'css=h2>a'
          link 'xpath=string(//h2/a/@href)'
          company 'css=.company'
          location 'css=.location'
          summary 'css=.summary'
          days_ago 'css=.date'
          source 'css=.sdn'
        end
      end

      page_results['jobs']
    end).flatten

    jobs.each do |job|
      #job['link'] = get_final_uri("http://www.indeed.ca/#{job['link']}")
      job['link'] = "http://www.indeed.ca#{job['link']}"
      job['days_ago'] = job['days_ago'].gsub(/ days ago/, '')
      job['id'] = job['link'].gsub('http://www.indeed.ca/rc/clk?jk=', '')
    end
  end

  def get_final_uri uri
    follow_uri = uri
    httpc = HTTPClient.new

    while(true) do
      resp=httpc.get(follow_uri)
      if resp.redirect?
        if (path=resp.headers['Location']).include?('http')
          follow_uri = path
          next
        else
          follow_uri = "#{(URI.parse(follow_uri).path='').to_s}"
        end
      else
        return resp.headers['Location']
      end
    end
  end
end

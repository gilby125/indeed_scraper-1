json.array!(@job_posts) do |job_post|
  json.extract! job_post, :job_id, :title, :summary
  json.url job_post_url(job_post, format: :json)
end

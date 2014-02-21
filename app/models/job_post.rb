class JobPost
  include NoBrainer::Document

  field :job_id
  field :title
  field :link
  field :company
  field :location
  field :summary
  field :days_ago
  field :source
  field :country_code

  def self.find_or_create_by_job_id job_id, hash
    unless (r=JobPost.where(job_id:job_id)).count > 0
      jp=JobPost.create(hash)
    end

    jp || r.first
  end
end

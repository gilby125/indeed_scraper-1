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
end

json.array!(@questions) do |question|
  json.extract! question, :id, :text, :index, :survey_id, :yes_no, :rating, :free_form
  json.url question_url(question, format: :json)
end

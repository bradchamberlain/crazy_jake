class Report
  attr_accessor :complete_surveys, :responses, :answers, :survey, :title, :id, :subtitle

  def initialize s, inputs
    self.id = 1
    self.survey = s
    self.title = self.survey.name.titleize
    self.complete_surveys = inputs
    self.responses = Hash.new
    self.answers = Hash.new
    process_questions
  end

  private

  def process_questions
    survey.questions.each do |question|
      answers[question.id] = 0
      responses[question.id] = Hash.new
      if question.yes_no?
        process_yes_no question.id
      elsif question.rating?
        process_rating question.id
      elsif question.free_form?
        process_free_form question.id
      end
    end
  end

  def process_yes_no question_id
    setup_responses question_id, [:yes,:no]
    complete_surveys.each do |c|
      responses[question_id][:no] = responses[question_id][:no] + 1 if c.responses[question_id.to_s] == "0"
      responses[question_id][:yes] = responses[question_id][:yes] + 1 if c.responses[question_id.to_s] == "1"
      answers[question_id] = answers[question_id] + 1 if c.responses[question_id.to_s]
    end
  end

  def process_rating question_id
    setup_responses question_id, [:extremely_satisfied, :very_satisfied, :satisfied, :unsatisfied, :very_unsatisfied, :unknown]
    complete_surveys.each do |c|
      responses[question_id][:extremely_satisfied] = @responses[question_id][:extremely_satisfied] + 1 if c.responses[question_id.to_s] == "5"
      responses[question_id][:very_satisfied] = @responses[question_id][:very_satisfied] + 1 if c.responses[question_id.to_s] == "4"
      responses[question_id][:satisfied] = @responses[question_id][:satisfied] + 1 if c.responses[question_id.to_s] == "3"
      responses[question_id][:unsatisfied] = @responses[question_id][:unsatisfied] + 1 if c.responses[question_id.to_s] == "2"
      responses[question_id][:very_unsatisfied] = @responses[question_id][:very_unsatisfied] + 1 if c.responses[question_id.to_s] == "1"
      responses[question_id][:unknown] = @responses[question_id][:unknown] + 1 if c.responses[question_id.to_s] == "0"
      answers[question_id] = answers[question_id] + 1 if c.responses[question_id.to_s]
    end
  end

  def setup_responses id, values
    values.each { |v| responses[id][v] = 0}
  end

  def process_free_form question_id
    complete_surveys.each_with_index do |c,i|
      responses[question_id][i] =  [c.created_at.strftime("%b %e, %Y"), c.responses[question_id.to_s]] if c.responses[question_id.to_s].present?
      answers[question_id] = answers[question_id] + 1 if c.responses[question_id.to_s].present?
    end
  end

end

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

  def response_colors question_id
    colors = "["
    responses[question_id].each do |k,v|
      if k == :yes
        colors = colors +  "'#0000FF',"
      elsif k == :no
        colors = colors + "'#FF00FF',"
      elsif k == :extremely_satisfied
        colors = colors + "'#00AA00',"
      elsif k == :very_satisfied
        colors = colors + "'#4444FF',"
      elsif k == :satisfied
        colors = colors + "'#F8F800',"
      elsif k == :unsatisfied
        colors = colors + "'#FFA500',"
      elsif k == :very_unsatisfied
        colors = colors + "'#FF0000',"
      elsif k == :unknown
        colors = colors + "'#888888',"
      end
    end
    if colors.length == 1
      colors = "['#836fff','#0000ff','#00bfff','#00ffff','#c1ffc1'," +
                "'#00ff7f','#fff68f','#ffff00','#ffb90f','#ff6a6a','#ff7f24'," +
                "'#ff4040','#ff7f00','#ff4500','#cd0000','#ee1289','#ff3e96'," +
                "'#8b4789','#9b30ff','#ffe1ff']"
    else
      colors = colors[0..colors.length - 2] + "]"
    end
    colors
  end

  def question_highest_hits question_id
    responses[question_id].max_by{|k,v| v}[0]
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
      elsif question.customized?
        process_custom question
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
      responses[question_id][:extremely_satisfied] = responses[question_id][:extremely_satisfied] + 1 if c.responses[question_id.to_s] == "5"
      responses[question_id][:very_satisfied] = responses[question_id][:very_satisfied] + 1 if c.responses[question_id.to_s] == "4"
      responses[question_id][:satisfied] = responses[question_id][:satisfied] + 1 if c.responses[question_id.to_s] == "3"
      responses[question_id][:unsatisfied] = responses[question_id][:unsatisfied] + 1 if c.responses[question_id.to_s] == "2"
      responses[question_id][:very_unsatisfied] = responses[question_id][:very_unsatisfied] + 1 if c.responses[question_id.to_s] == "1"
      responses[question_id][:unknown] = responses[question_id][:unknown] + 1 if c.responses[question_id.to_s] == "0"
      answers[question_id] = answers[question_id] + 1 if c.responses[question_id.to_s]
    end
  end

  def process_custom question
    setup_responses question.id, question.custom_values_array
    complete_surveys.each do |complete_survey|
      if complete_survey.responses[question.id.to_s]
        answers[question.id] = answers[question.id] + 1
        match_custom_responses question, complete_survey
      end
    end
  end

  def match_custom_responses question, complete_survey
    question.custom_values_array.each do |custom_question_value|
      if complete_survey.responses[question.id.to_s].match /\[/
        handle_custom_response_array(complete_survey, question, custom_question_value)
      else
        responses[question.id][custom_question_value] = responses[question.id][custom_question_value] + 1 if custom_question_value == complete_survey.responses[question.id.to_s]
      end
    end
  end

  def handle_custom_response_array(complete_survey, question, match_value)
    complete_survey.responses[question.id.to_s][1..-2].split(",").each do |response_value|
      responses[question.id][match_value] = responses[question.id][match_value] + 1 if complete_survey.responses[question.id.to_s][match_value] == response_value.strip[1..-2]
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

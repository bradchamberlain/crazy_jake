class QrCodesController < ApplicationController
  before_filter :find_survey

  def index
    puts "================================================================================================"
    respond_to do |format|
      if @survey
        format.html
        format.svg  { render qrcode: survey_path, level: :l, unit: 10 }
        format.png  { render qrcode: survey_path }
        format.gif  { render qrcode: survey_path }
        format.jpeg { render qrcode: survey_path }
      else
        format.html
        format.svg
        format.png
        format.gif
        format.jpeg
      end
    end
    puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  end

  private

  def survey_path
    complete_surveys_url({survey_id: @survey.id}.merge(params.select{|k,v| k.match /^c_/}))
  end

  def find_survey
    if(params[:survey_id])
      @survey = Survey.find params[:survey_id]
    end
  end
end

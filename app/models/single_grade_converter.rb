require "grade_consts.rb"

class SingleGradeConverter
  include GradeConsts

  def initialize(percentage)
    @percentage = percentage
  end

  def percnt_to_ltr
    GradeConsts::PRCT_TO_LTR.select {|k, v| break v if k.cover? @percentage }
  end

  def ltr_to_grd_pts
    GradeConsts::LTR_TO_GRD_PTS.select {|k, _| k == percnt_to_ltr}.values.join('')
  end
end

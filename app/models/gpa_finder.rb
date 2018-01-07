require "grade_consts.rb"

class GPAFinder
  include GradeConsts

  def initialize(student_id)
    @grades = Enrollment.where(student_id: student_id).map { |g| g.grade }
  end

  def gp_average
    points.sum/points.length unless points.length.zero?
  end

  private

  def letters
    @grades.map do |p|
      GradeConsts::PRCT_TO_LTR.select {|k, v| break v if k.cover? p}
    end
  end

  def points
    letters.map do |l|
      GradeConsts::LTR_TO_GRD_PTS.select {|k, _| k == l }.values
    end.flatten
  end
end

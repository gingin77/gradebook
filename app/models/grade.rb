class Grade < ApplicationRecord
  belongs_to :course
  belongs_to :student

  # validates_uniqueness_of :course_id, scope: :student_id
  #
  # validates_presence_of :percentage
  # before_validation :set_percentage

  def get_course_title
    Course.find_by_id(self.course_id).course_title
  end

  def get_student_name
    Student.find_by_id(self.student_id).name
  end

  def all_grds_for_std
    Grade.where(student_id: self.student_id).map { |g| g.percentage }
  end

  def grds_to_gpa
    ltrs = self.all_grds_for_std.map { |p| GRADE_HASH.select {|k, v| break v if k.cover? p } }
    pts = ltrs.map { |l| GPA_HASH.select { |k, _| k == l}.values }.flatten
    pts.sum/pts.length
  end

  def percnt_to_ltr
    GRADE_HASH.select {|k, v| break v if k.cover? self.percentage }
  end

  def ltr_to_grd_pts(letter)
    GPA_HASH.select { |k, _| k == letter}.values.join('')
  end

  GRADE_HASH = {
    93..(1/0.0) => 'A',
    90..93 => 'A-',
    87..90 => 'B+',
    83..87 => 'B',
    80..83 => 'B-',
    77..80 => 'C+',
    73..77 => 'C',
    70..73 => 'C-',
    60..70 => 'D',
    0..60 => 'F'
  }

  GPA_HASH = {
    'A' => 4.0,
    'A-' => 3.7,
    'B+' => 3.3,
    'B' => 3.0,
    'B-' => 2.7,
    'C+' => 2.3,
    'C' => 2.0,
    'C-' => 1.7,
    'D+' => 1.3,
    'D-' => 0.7,
    'D' => 1.0,
    'F'=> 0
  }

  # private
  #
  #   def set_percentage
  #     unless percentage.present?
  #       self.percentage = "No grade"
  #     end
  #   end

end

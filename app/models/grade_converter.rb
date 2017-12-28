class GradeConverter
  PRCT_TO_LTR = {
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

  LTR_TO_GRD_PTS = {
    'A' => 4.0,
    'A-' => 3.7,
    'B+' => 3.3,
    'B' => 3.0,
    'B-' => 2.7,
    'C+' => 2.3,
    'C' => 2.0,
    'C-' => 1.7,
    'D' => 1.0,
    'F'=> 0
  }

  def self.percnt_to_ltr(percentage)
    PRCT_TO_LTR.select {|k, v| break v if k.cover? percentage }
  end

  def self.ltr_to_grd_pts(letter)
    LTR_TO_GRD_PTS.select {|k, _| k == letter}.values.join('')
  end

  def self.grds_to_gpa(student_id)
    percentages = Grade.where(student_id: student_id).map { |g| g.percentage }
    ltrs = percentages.map { |p| PRCT_TO_LTR.select {|k, v| break v if k.cover? p } }
    pts = ltrs.map { |l| LTR_TO_GRD_PTS.select { |k, _| k == l}.values }.flatten
    pts.sum/pts.length unless pts.length.zero?
  end

  def self.gpas_for_multiple_studs(students)
    students.each_with_index.map do |s, i|
      {
        :index => i,
        :name => s.name,
        :gpa => GradeConverter.grds_to_gpa(s.id)
      }
    end
  end
end

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    # @course_wizardry = create(:course)
    @course = create(:course)
    @grade = create(:grade)
    # @course_physics = courses(:physics)
    # @grade_rec_for_physics = grades(:nine)
  end

  test 'can make course withfactory' do
    puts @grade.course_id
    puts @grade.percentage
    puts Course.find(@grade.course_id)
    assert_not_nil @course.course_title
  end

  # test 'courses can be dropped' do
  #   @course_physics.destroy
  #   @course_wizardry.destroy
  #   assert @course_physics.destroyed?
  #   assert @course_wizardry.destroyed?
  # end
  #
  # test 'when a course is dropped, a grade record is removed' do
  #   grade_to_delete = @course_physics.grades
  #   @course_physics.destroy
  #   assert_empty grade_to_delete
  # end
  #
  # test 'when a course is dropped, multiple grade records are removed' do
  #   grades_to_delete = @course_wizardry.grades
  #   @course_wizardry.destroy
  #   assert_empty grades_to_delete
  # end
end

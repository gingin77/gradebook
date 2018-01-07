require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    @course_wizardry = courses(:wizardry)
    @course_physics = courses(:physics)
    @enrollment_rec_for_physics = enrollments(:nine)
  end

  test 'courses can be dropped' do
    @course_physics.destroy
    @course_wizardry.destroy
    assert @course_physics.destroyed?
    assert @course_wizardry.destroyed?
  end

  test 'when a course is dropped, a enrollment record is removed' do
    enrollment_to_delete = @course_physics.enrollments
    @course_physics.destroy
    assert_empty enrollment_to_delete
  end

  test 'when a course is dropped, multiple enrollment records are removed' do
    enrollments_to_delete = @course_wizardry.enrollments
    @course_wizardry.destroy
    assert_empty enrollments_to_delete
  end

  test 'average enrollment in a course can be accessed from a course instance directly' do
    c_average = Enrollment.where(course_id: @course_wizardry.id).average(:percentage).to_f
    assert_equal c_average, @course_wizardry.course_average
  end
end

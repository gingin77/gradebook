require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    @course_wizardry = courses(:wizardry)
    @course_physics = courses(:physics)
    @grade_rec_for_physics = grades(:nine)
  end

  test 'courses can be dropped' do
    @course_physics.destroy
    @course_wizardry.destroy
    assert @course_physics.destroyed?
    assert @course_wizardry.destroyed?
  end

  test 'when course is dropped, grade record is removed' do
    grade_to_delete = @course_physics.grades
    @course_physics.destroy
    assert_empty grade_to_delete
  end

  test 'when course is dropped, multiple grade records are removed' do
    grades_to_delete = @course_wizardry.grades
    @course_wizardry.destroy
    assert_empty grades_to_delete
  end
end

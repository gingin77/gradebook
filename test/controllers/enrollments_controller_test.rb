require 'test_helper'

class EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @physics_teach_user = users(:physics_t_user)
    @physics = courses(:physics)
    @phs_id = @physics.id

    @org_chem_t_user = users(:org_chem_t_user)
    @org_chem = courses(:organic_chemisty)
    @o_chem_id = @org_chem.id
  end

  test 'a teacher who owns course can access path to add students to that class' do
    log_in_as(@physics_teach_user)
    assert is_logged_in?
    get new_course_enrollment_path(@phs_id)
    assert_response :success
  end

  test 'a teacher who does not own course cannot access path to add students to that class' do
    log_in_as(@org_chem_t_user)
    assert is_logged_in?
    get new_course_enrollment_path (@phs_id)
    assert_response :redirect
  end

  test 'when teacher adds eligible student to course, a new enrollment instance is stored' do
    logged_in_as_the_physics_teacher_on_path_to_add_student
    assert_difference('Enrollment.count') do
      post "/courses/" + @phs_id.to_s + "/enrollments",
        params: { students_name: "Ron Weasley" }
    end
    assert_redirected_to course_path (@phs_id)
    assert_equal "Ron Weasley has been added to " + @physics.course_title, flash[:success]
  end

  test 'query for students name is not case sensitive' do
    logged_in_as_the_physics_teacher_on_path_to_add_student
    assert_difference('Enrollment.count') do
      post "/courses/" + @phs_id.to_s + "/enrollments",
        params: { students_name: "ron weasley" }
    end
    assert_redirected_to course_path (@phs_id)
    assert_equal "Ron Weasley has been added to " + @physics.course_title, flash[:success]
  end

  test 'messsage is returned when user input does not match db' do
    logged_in_as_the_physics_teacher_on_path_to_add_student
    assert_no_difference('Enrollment.count') do
      post "/courses/" + @phs_id.to_s + "/enrollments",
        params: { students_name: "misc" }
    end
    assert_redirected_to course_path (@phs_id)
    assert_equal "The name you entered could not be found in our system.", flash[:danger]
  end

  test 'attempt to add a student with 4 classes' do
    stu_w_4_courses = students(:one)
    logged_in_as_the_physics_teacher_on_path_to_add_student
    assert_no_difference('Enrollment.count') do
      post "/courses/" + @phs_id.to_s + "/enrollments",
        params: { students_name: stu_w_4_courses.name }
    end
    assert_redirected_to course_path (@phs_id)
    assert_equal "Students cannot be enrolled in more than 4 courses", flash[:danger][:student_id].join('')
  end

  test 'attempt to add student to a course at max capacity' do
    stu_w_3_courses = students(:three)
    logged_in_as_the_org_chem_teacher_on_path_to_add_student
    assert_no_difference('Enrollment.count') do
      post "/courses/" + @o_chem_id.to_s + "/enrollments",
        params: { students_name: stu_w_3_courses.name }
    end
    assert_redirected_to course_path (@o_chem_id)
    assert_equal "Course enrollment is limited to 16 students per term", flash[:danger][:course_id].join('')
  end

  private

  def logged_in_as_the_physics_teacher_on_path_to_add_student
    log_in_as(@physics_teach_user)
    get new_course_enrollment_path (@phs_id)
  end

  def logged_in_as_the_org_chem_teacher_on_path_to_add_student
    log_in_as(@org_chem_t_user)
    get new_course_enrollment_path (@o_chem_id)
  end
end

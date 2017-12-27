class UserType
  def initialize(user)
    @user = user
  end

  def type
    @user.identifiable_type
  end

  def id_ut
    @user.identifiable_id
  end

  def get_name
    if type == "Student"
      students_name
    elsif type == "Teacher"
      teachers_name
    end
  end

  def students_name
    Student.find(id_ut).name
  end

  def teachers_name
    Teacher.find(id_ut).name
  end

  # def admins_name
  #   Teacher.find(self.identifiable_id).name
  # end
end

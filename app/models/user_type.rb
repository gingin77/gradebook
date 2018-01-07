class UserType
  def initialize(user)
    @user = user
  end

  def get_name
    if ui_type == "Student"
      Student.find(ui_id).name
    elsif ui_type == "Teacher"
      Teacher.find(ui_id).name
    elsif ui_type == "Admin"
      Admin.find(ui_id).name
    end
  end

  private

  def ui_id
    @user.identifiable_id
  end

  def ui_type
    @user.identifiable_type
  end
end

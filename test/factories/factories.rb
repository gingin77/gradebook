COURSE_NAMES = ["Calculus", "Computer Science", "Mechanical Engineering", "Psychology", "Anatomy and Physiology", "Art History Survey I", "Art History Survey II", "Biology", "Organic Chemisty", "Statistics", "Applied Physics", "Ecology and Evolution", "Biotechnology and Society", "English", "Computer Science", "General Chemisty Lab", "Sociology", "Wizardry", "Invisibility", "Quidditch"]

norm = Rubystats::NormalDistribution.new(80.0, 14.4)
SCORES = 100.times.map { norm.rng.round(3) }

FactoryBot.define do
  factory :student_user, class: "User" do
    association :identifiable, factory: :student
    sequence(:username) { |n| "user#{n}" }
    password "secret1!"
  end

  factory :student do
    name  Faker::Name.name
    # 
    # transient do
    #   courses_count 4
    # end
    #
    # factory :student_with_courses do
    #
    #   before(:create) do |student|
    #     (0...eval.courses_count).each do |i|
    #       student.courses << FactoryBot.build(:course, student: student)
    #     end
    #   end
    # end
  end

  factory :teacher_user, class: "User" do
    association :identifiable, factory: :teacher
    sequence(:username) { |n| "user#{n}"}
    password "secret1!"
  end

  factory :teacher do
    name Faker::Name.name
  end

  factory :course do
    course_title COURSE_NAMES.sample
  end

  factory :grade do
    association :student
    association :course
    percentage SCORES.sample
  end
end




# FactoryBot.define do
#   factory :student_user, class User do
#     association :identifiable, => :user
#     name  Faker::Name.name
#
#     # after(:create) do |student|
#     #   create(:user, identifiable: student)
#     # end
#   end
# end
#
# FactoryBot.define do

# end

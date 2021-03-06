# Gradebook

This application was built to meet specs for an [exercise developed by Viget Labs](https://github.com/vigetlabs/gradebook).

## Specs:
> Build an application that allows for the recording and reporting of courses offered by teachers and taken by students. It should satisfy these stories:
>
> * A Teacher can manage his course roster
> * A Teacher can view the enrolled students and their grades for a given course
> * A Student can see the courses he is registered for (with grades)
> * A Student can see his GPA for a given semester
> * An Administrator can view enrollment counts across all courses for a semester (performance is a concern)
> * An Administrator can view an average grade for a given course (performance is a concern)

## Summary of My App Design - User interface
**The app db needs to be populated with seed date before a user can successfully login.**

* Once app is running locally, to interact with the app as a user:
  * *Optional* Visit the */intro* url path to see a short list of students who are eligible to be added to courses (only teachers have this ability) and to see which teachers have 1 or 0 courses.
  * Visit: */login*
    * **Any username inferred from the seed file can be used to login, but for convenience, here are some example user names to try out**
      * As an admin => adumbledore
      * As a teacher => pkeating
      * As a student => zmorris
    * **Password:** secret!

* Each user type will be routed to the view that meets the app requirements listed above. The teacher role has additional views accessible from the teacher home page related to managing the course roster and assigning grades.

## Summary of My App Design - Developer's perspective
* A seed file contains dummy names and data for students, teachers, and admins. **The seed file needs to be raked before one can successfully login.** A username in all lowercase is generated by combining the first initial of the first name with the last name. For example, "Wes Gibbins" becomes "wgibbins". The code for how this was done is in the */db/seeds.rb* file.

* **Database design and normalization**
  * A User class handles all authentication steps. It is polymorphic and belongs to 'identifiable', which can be used by 3 other user_type models: Student, Teacher, and Admin.

  * An Ability model is used to handle access permissions based on the User property, identifiable_type.

  * The Course and Student models are joined in a *has_many, through* relationship via the Enrollment class. The Enrollments table holds foreign keys for courses and students. In addition to the foreign key columns, the Enrollments table has a single float property, 'grade', which holds the numerical percentage grade value for a student within a course.

  * The teacher class *has_many courses* and *has_many enrollments, through courses*. The course model *belongs_to teacher*.

  * A teacher can add or drop a student from courses they 'own' by creating or destroying an Enrollment record. Adding or adjusting the numerical grade for a student in a course is handled by the Enrollments#edit and #update actions.

  * Some standard ActiveRecord validations were used to maintain integrity of the Enrollments table. In addition, 2 custom validations were designed to block the creation of more than 4 Enrollment records for a given student and no more than 16 Enrollment records can be created for a given course.

* **Tests**
  * The Sessions and Enrollments controllers have the most integration tests. Other controllers have a few tests but since the most complex functionality was associated with adding and updating enrollment records by authenticated teacher-users, it made sense to write more tests for the Enrollments controller.
  * This was my first time building a test-suite for an app and some of the tests I wrote in the beginning for the models might be a bit redundant with the controller integration tests I wrote later in the development process.

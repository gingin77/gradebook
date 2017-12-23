class GradesController < ApplicationController
  def new
    @grade = Grade.new
  end
end

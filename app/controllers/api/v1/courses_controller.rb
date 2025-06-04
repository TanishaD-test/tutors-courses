# app/controllers/api/v1/courses_controller.rb
module Api
  module V1
    class CoursesController < ApplicationController
      # GET /api/v1/courses
      def index
        courses = Course.includes(:tutors).all
        render json: courses.to_json(include: :tutors), status: :ok
      end

      # POST /api/v1/courses
      def create
        course = Course.new(course_params)
        if course.save
          render json: course.to_json(include: :tutors), status: :created
        else
          render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def course_params
        # Permit nested tutors attributes if you want to create tutors along with course
        params.require(:course).permit(:name, tutors_attributes: [:name])
      end
    end
  end
end
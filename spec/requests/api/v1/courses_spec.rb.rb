require 'rails_helper'

RSpec.describe "Api::V1::Courses", type: :request do

  describe "GET /api/v1/courses" do
		before do
			course = create(:course)
			tutor  = create(:tutor, course: course)
		end

    it "returns all courses with tutors" do
      get '/api/v1/courses'
      expect(response).to have_http_status(:ok)
			
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json.first['name']).to eq("Ruby on Rails")
      expect(json.first['tutors'].first["name"]).to eq("Sample Tutor")
    end
  end

  describe "POST /api/v1/courses" do
    let(:valid_params) do
      {
        course: {
          name: "Python",
          tutors_attributes: [
            { name: "Tutor One" },
            { name: "Tutor Two" }
          ]
        }
      }
    end

    let(:invalid_params) do
      {
        course: { name: "" }
      }
    end

    it "creates a new course with tutors" do
      expect {
        post '/api/v1/courses', params: valid_params
      }.to change(Course, :count).by(1)
        .and change(Tutor, :count).by(2)

      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body)
      expect(json['name']).to eq("Python")
      expect(json['tutors'].length).to eq(2)
    end

    it "returns errors with invalid params" do
      post '/api/v1/courses', params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)

      json = JSON.parse(response.body)
      expect(json['errors']).to include("Name can't be blank")
    end
  end
end
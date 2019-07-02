require 'rails_helper'

RSpec.describe "Walkings", type: :request do
  describe "GET /walkings" do
    it "works! (now write some real specs)" do
      get api_v1_walkings_path
      expect(response).to have_http_status(200)
    end
  end
end

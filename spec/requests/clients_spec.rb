require 'swagger_helper'

RSpec.describe 'Clients', type: :request, capture_examples: true do
  path '/clients' do
    get(summary: 'Get clients') do
      consumes 'application/json'
      produces 'application/json'
      tags :clients

      let!(:clients) do
        3.times do
          create(:client)
        end
      end

      response(200, description: 'Return all the available clients') do
        it 'Return 3 clients' do
          body = JSON(response.body)
          expect(body.count).to eq(3)
        end
      end
    end
  end
end

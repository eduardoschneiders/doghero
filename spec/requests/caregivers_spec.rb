require 'swagger_helper'

RSpec.describe 'Caregivers', type: :request, capture_examples: true do
  path '/api/v1/caregivers' do
    get(summary: 'Get caregivers') do
      consumes 'application/json'
      produces 'application/json'
      tags :caregivers

      let!(:caregivers) do
        3.times do
          create(:caregiver)
        end
      end

      response(200, description: 'Return all the available caregivers') do
        it 'Return 3 caregivers' do
          body = JSON(response.body)
          expect(body.count).to eq(3)
        end
      end
    end

    post(summary: 'Create a new caregiver') do
      consumes 'application/json'
      produces 'application/json'
      tags :caregivers

      parameter :caregiver,
        in: :body,
        required: true,
        schema: {
          '$ref' => '#/definitions/caregiver'
        }

      response(201, description: 'Caregiver created') do
        let(:caregiver) do
          {
            caregiver: {
              name: 'Eduardo'
            }
          }
        end
      end
    end
  end

  path '/api/v1/caregivers/{id}' do
    get(summary: 'Get Caregiver') do
      consumes 'application/json'
      produces 'application/json'
      tags :caregivers

      parameter :id, in: :path, type: :integer, required: true, description: 'caregiver ID'

      let(:caregiver_1) do
        create(:caregiver)
      end

      response(200, description: 'Return the selected Caregiver') do
        let(:id) { caregiver_1.id }
      end

      response(404, description: 'Caregiver not found') do
        let(:id) { 999 }
      end
    end


    put(summary: 'Update Caregiver') do
      consumes 'application/json'
      produces 'application/json'
      tags :caregivers

      parameter :id, in: :path, type: :integer, required: true, description: 'caregiver ID'

      parameter :caregiver,
                in: :body,
                required: true,
                schema: {
                  '$ref' => '#/definitions/caregiver'
                }

      let(:caregiver_1) do
        create(:caregiver)
      end

      response(200, description: 'Caregiver updated') do
        let(:id) { caregiver_1.id }

        let(:caregiver) do
          {
            caregiver: {
              name: 'New Name'
            }
          }
        end
      end

      response(404, description: 'Caregiver not found') do
        let(:id) { 999 }

        let(:caregiver) do
          {
            caregiver: {
              name: 'New Name'
            }
          }
        end
      end
    end

    delete(summary: 'Delete Caregiver') do
      consumes 'application/json'
      produces 'application/json'
      tags :caregivers

      parameter :id, in: :path, type: :integer, required: true, description: 'caregiver ID'

      let(:caregiver_1) do
        create(:caregiver)
      end

      response(204, description: 'Caregiver deleted') do
        let(:id) { caregiver_1.id }
      end

      response(404, description: 'Caregiver not found') do
        let(:id) { 999 }
      end
    end
  end
end
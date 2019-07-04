require 'swagger_helper'

RSpec.describe 'Walkings', type: :request, capture_examples: true do
  path '/api/v1/walkings' do
    let(:caregiver) { create(:caregiver) }
    let(:client) { create(:client) }
    let(:dogs) { 2.times.map { create(:dog, client: client) }}

    get(summary: 'Get walkings') do
      consumes 'application/json'
      produces 'application/json'
      tags :walkings

      let!(:walkings) do

        3.times do
          client = create(:client, :with_dogs)
          create(:walking, caregiver: create(:caregiver), dogs: client.dogs)
        end
      end

      response(200, description: 'Return all the available walkings') do
        it 'Return 3 walkings' do
          body = JSON(response.body)
          expect(body.count).to eq(3)
        end
      end
    end

    post(summary: 'Create a new walking') do
      consumes 'application/json'
      produces 'application/json'
      tags :walkings

      parameter :walking,
        in: :body,
        required: true,
        schema: {
          '$ref' => '#/definitions/walking'
        }

      response(201, description: 'Walking created') do
        let(:walking) do
          {
            walking: {
              lat: '1',
              lon: '2',
              status: "started",
              duration: 30,
              schedule_time: Time.now,
              caregiver_id: caregiver.id,
              dog_ids: dogs.map(&:id)
            }
          }
        end
      end
    end
  end

  path '/api/v1/walkings/{id}' do
    get(summary: 'Get Walking') do
      consumes 'application/json'
      produces 'application/json'
      tags :walkings

      parameter :id, in: :path, type: :integer, required: true, description: 'walking ID'

      let(:walking_1) do
        create(:walking, caregiver: create(:caregiver), dogs: create(:client, :with_dogs).dogs)
      end

      response(200, description: 'Return the selected Walking') do
        let(:id) { walking_1.id }
      end     
    end

    put(summary: 'Update Walking') do
      consumes 'application/json'
      produces 'application/json'
      tags :walkings

      parameter :id, in: :path, type: :integer, required: true, description: 'walking ID'
      parameter :walking,
                in: :body,
                required: true,
                schema: {
                  '$ref' => '#/definitions/walking'
                }

      let(:walking_1) do
        create(:walking, caregiver: create(:caregiver), dogs: create(:client, :with_dogs).dogs)
      end

      response(200, description: 'Walking updated') do
        let(:id) { walking_1.id }

        let(:walking) do
          {
            walking: {
              dogs: ["1"]
            }
          }
        end
      end

      response(404, description: 'Walking not found') do
        let(:id) { 999 }

        let(:walking) do
          {
            walking: {
              lat: '1'
            }
          }
        end
      end
    end


    delete(summary: 'Delete Walking') do
      consumes 'application/json'
      produces 'application/json'
      tags :walkings

      parameter :id, in: :path, type: :integer, required: true, description: 'Walking ID'

      let(:walking_1) do
        create(:walking, caregiver: create(:caregiver), dogs: create(:client, :with_dogs).dogs)
      end

      response(204, description: 'Walking deleted') do
        let(:id) { walking_1.id }
      end

      response(404, description: 'Walking not found') do
        let(:id) { 999 }
      end
    end
  end

  path '/api/v1/walkings/{id}/start_walk' do
    put(summary: 'Start Walk') do
      consumes 'application/json'
      produces 'application/json'
      tags :walkings

      parameter :id, in: :path, type: :integer, required: true, description: 'walking ID'

      let(:walking_1) do
        create(:walking, caregiver: create(:caregiver), dogs: create(:client, :with_dogs).dogs)
      end

      response(202, description: 'Return the selected Walking') do
        let(:id) { walking_1.id }
        
        it 'Return walking' do
          body = JSON(response.body)
          expect(body['status']).to eq("started")
        end
      end

      response(404, description: 'Walking not found') do
        let(:id) { 999 }
      end
    end
  end

  path '/api/v1/walkings/{id}/finish_walk' do
    put(summary: 'Finish Walk') do
      consumes 'application/json'
      produces 'application/json'
      tags :walkings

      parameter :id, in: :path, type: :integer, required: true, description: 'walking ID'

      let(:walking_1) do
        create(:walking, caregiver: create(:caregiver), dogs: create(:client, :with_dogs).dogs)
      end

      response(202, description: 'Return the selected Walking') do
        let(:id) { walking_1.id }
        
        it 'Return walking' do
          body = JSON(response.body)
          expect(body['status']).to eq("finished")
        end
      end

      response(404, description: 'Walking not found') do
        let(:id) { 999 }
      end
    end
  end
end
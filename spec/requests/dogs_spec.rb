require 'swagger_helper'

RSpec.describe 'Dogs', type: :request, capture_examples: true do
  

  path '/api/v1/clients/{client_id}/dogs' do
  	let(:client) { create(:client) }
  	let(:client_id) { client.id }

  	parameter :client_id, in: :path, type: :integer, required: true, description: 'client ID'

    get(summary: 'Get dogs') do
      consumes 'application/json'
      produces 'application/json'
      tags :dogs

      let!(:dogs) do
        3.times do
          client.dogs << build(:dog)
        end
      end

      response(200, description: 'Return all the available dogs') do
        it 'Return 3 dogs' do
          body = JSON(response.body)
          expect(body.count).to eq(3)
        end
      end
    end

    post(summary: 'Create a new dog') do
      consumes 'application/json'
      produces 'application/json'
      tags :dogs

      parameter :dog,
        in: :body,
        required: true,
        schema: {
          '$ref' => '#/definitions/dog'
        }

      response(201, description: 'Client created') do
        let(:dog) do
          {
            dog: {
              name: 'Rufus'
            }
          }
        end
      end
    end
  end

  path '/api/v1/clients/{client_id}/dogs/{id}' do
  	let(:client) { create(:client) }
  	let(:client_id) { client.id }

		parameter :client_id, in: :path, type: :integer, required: true, description: 'client ID'
    
    get(summary: 'Get Dog') do
      consumes 'application/json'
      produces 'application/json'
      tags :dogs

      parameter :id, in: :path, type: :integer, required: true, description: 'dog ID'

      let(:dog_1) do
      	create(:dog, client: client)
      end

      response(200, description: 'Return the selected Dog') do
        let(:id) { dog_1.id }
      end     
    end


    put(summary: 'Update Dog') do
      consumes 'application/json'
      produces 'application/json'
      tags :dogs

			parameter :client_id, in: :path, type: :integer, required: true, description: 'client ID'
      parameter :id, in: :path, type: :integer, required: true, description: 'dog ID'
      parameter :dog,
                in: :body,
                required: true,
                schema: {
                  '$ref' => '#/definitions/dog'
                }

      let(:dog_1) do
        create(:dog, client: client)
      end

      response(200, description: 'Client updated') do
        let(:id) { dog_1.id }

        let(:dog) do
          {
            dog: {
              name: 'New Name'
            }
          }
        end
      end

      response(404, description: 'Client not found') do
        let(:id) { 999 }

        let(:dog) do
          {
            dog: {
              name: 'New Name'
            }
          }
        end
      end
    end

    delete(summary: 'Delete Dog') do
      consumes 'application/json'
      produces 'application/json'
      tags :dogs

      parameter :id, in: :path, type: :integer, required: true, description: 'dog ID'

      let(:dog_1) do
      	create(:dog, client: client)
      end

      response(204, description: 'Dog deleted') do
        let(:id) { dog_1.id }
      end

      response(404, description: 'Dog not found') do
        let(:id) { 999 }
      end
    end
  end
end
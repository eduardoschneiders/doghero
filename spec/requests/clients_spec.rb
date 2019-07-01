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

    post(summary: 'Create a new client') do
      consumes 'application/json'
      produces 'application/json'
      tags :clients

      parameter :client,
        in: :body,
        required: true,
        schema: {
          '$ref' => '#/definitions/client'
        }

      response(201, description: 'Client created') do
        let(:client) do
          {
            client: {
              name: 'Eduardo'
            }
          }
        end
      end
    end
  end

  path '/clients/{id}' do
    get(summary: 'Get Client') do
      consumes 'application/json'
      produces 'application/json'
      tags :clients

      parameter :id, in: :path, type: :integer, required: true, description: 'client ID'

      let(:client_1) do
        create(:client)
      end

      response(200, description: 'Return the selected Client') do
        let(:id) { client_1.id }
      end

      response(404, description: 'Client not found') do
        let(:id) { 999 }
      end
    end


    put(summary: 'Update Client') do
      consumes 'application/json'
      produces 'application/json'
      tags :clients

      parameter :id, in: :path, type: :integer, required: true, description: 'client ID'

      parameter :client,
                in: :body,
                required: true,
                schema: {
                  '$ref' => '#/definitions/client'
                }

      let(:client_1) do
        create(:client)
      end

      response(200, description: 'Client updated') do
        let(:id) { client_1.id }

        let(:client) do
          {
            client: {
              name: 'New Name'
            }
          }
        end
      end

      response(404, description: 'Client not found') do
        let(:id) { 999 }

        let(:client) do
          {
            client: {
              name: 'New Name'
            }
          }
        end
      end
    end

    delete(summary: 'Delete Client') do
      consumes 'application/json'
      produces 'application/json'
      tags :clients

      parameter :id, in: :path, type: :integer, required: true, description: 'client ID'

      let(:client_1) do
        create(:client)
      end

      response(204, description: 'Client deleted') do
        let(:id) { client_1.id }
      end

      response(404, description: 'Client not found') do
        let(:id) { 999 }
      end
    end
  end
end
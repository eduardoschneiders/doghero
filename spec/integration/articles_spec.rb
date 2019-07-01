require 'swagger_helper'

describe 'articles API' do

  path '/api/v1/articles' do

    post 'Creates a article' do
      tags 'articles'
      consumes 'application/json'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          article: {
            name: { type: :string },
            photo_url: { type: :string },
            status: { type: :string }
          }
        },
        required: [ 'name', 'status' ]
      }

      response '201', 'article created' do
        let(:article) { { name: 'Dodo', status: 'available' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:article) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/articles/{id}' do

    get 'Retrieves a article' do
      tags 'articles'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            name: { type: :string },
            photo_url: { type: :string },
            status: { type: :string }
          },
          required: [ 'id', 'name', 'status' ]

        let(:id) { article.create(name: 'foo', status: 'bar', photo_url: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'article not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
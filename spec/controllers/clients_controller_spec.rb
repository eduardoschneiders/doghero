require 'rails_helper'

RSpec.describe ClientsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Client. As you add validations to Client, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: 'Eduardo' }
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClientsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      client = Client.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      client = Client.create! valid_attributes
      get :show, params: {id: client.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Client" do
        expect {
          post :create, params: {client: valid_attributes}, session: valid_session
        }.to change(Client, :count).by(1)
      end

      it "renders a JSON response with the new client" do

        post :create, params: {client: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(client_url(Client.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new client" do

        post :create, params: {client: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "new name" }
      }

      it "updates the requested client" do
        client = Client.create! valid_attributes
        put :update, params: {id: client.to_param, client: new_attributes}, session: valid_session
        client.reload
        
      end

      it "renders a JSON response with the client" do
        client = Client.create! valid_attributes

        put :update, params: {id: client.to_param, client: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the client" do
        client = Client.create! valid_attributes

        put :update, params: {id: client.to_param, client: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested client" do
      client = Client.create! valid_attributes
      expect {
        delete :destroy, params: {id: client.to_param}, session: valid_session
      }.to change(Client, :count).by(-1)
    end
  end

end

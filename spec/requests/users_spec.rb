require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /users' do
    let(:valid_attributes) { { user: { username: 'newuser' } } }
    let(:invalid_attributes) { { user: { username: '' } } }

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a new user' do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('username' => 'newuser')
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('username')
      end
    end
  end
end

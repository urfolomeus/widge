require 'rails_helper'

RSpec.describe SessionsController do
  describe 'GET new' do
    before :each do
      get :new
    end

    it 'assigns a new user' do
      expect(assigns[:user]).to be_a(User)
      expect(assigns[:user]).to be_new_record
    end

    it 'renders the login page' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    let(:user) { Fabricate.build(:user) }
    let(:login_params) {{
      email:    user.email,
      password: user.password
    }}

    before :each do
      allow(controller).to receive(:login).and_return(user)
      post :create, login_params
    end

    it 'logs the user in' do
      expect(controller).to have_received(:login).with(user.email, user.password)
    end

    context 'when successful' do
      it 'assigns the logged in user' do
        expect(assigns[:user]).to eql(user)
      end

      it 'redirects to the root page' do
        expect(response).to redirect_to(:root)
      end

      it 'displays a success notice' do
        expect(flash[:notice]).to eql('Successfully signed in')
      end
    end

    context 'when unsuccessful' do
      before :each do
        allow(controller).to receive(:login).and_return(nil)
        post :create, login_params
      end

      it 'renders the login page' do
        expect(response).to render_template(:new)
      end

      it 'displays a failure alert' do
        expect(flash[:alert]).to eql('Could not sign in')
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      allow(controller).to receive(:logout)
      delete :destroy
    end

    it 'logs the user out' do
      expect(controller).to have_received(:logout)
    end

    it 'redirects to the root page' do
      expect(response).to redirect_to(:root)
    end

    it 'displays a success notice' do
      expect(flash[:notice]).to eql('Signed out')
    end
  end
end

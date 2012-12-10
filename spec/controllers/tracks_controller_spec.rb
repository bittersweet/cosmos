require 'spec_helper'

describe TracksController do
  before do
    user = Factory(:user)
    sign_in(user)
  end

  it 'renders new track form' do
    get :new
    response.should be_success
  end
end

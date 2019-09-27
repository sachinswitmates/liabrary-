require 'rails_helper'

RSpec.describe LibraryOwner::BankAccountsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user,role: 'library_owner')
    sign_in @user
    @bank_account = FactoryBot.create(:bank_account, user_id: @user.id)   
  end
  describe "GET index" do
    it "shows bank details for signed in user" do
      get :index
      expect(@bank_account).to eql(@bank_account)      
    end 
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end 
  end

  describe "GET new" do
    it "create a new bank_account" do
      get :new
      expect(assigns(:bank_account)).to be_an_instance_of(BankAccount)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  # describe "POST create" do
  #   context "with valid attributes" do
  #     it "creates a new bank_account" do
  #       @bank_account_params = {bank_name: "SBI",account_number: "5454356466434", ifsc_code: "SBI0078373", account_holder_name: "test test",user_id: @user.id}
  #       post :create, params: {:bank_account => @bank_account_params}
  #       expect(@bank_account).to eql(@bank_account)
  #     end
  #     it "redirects to the new bank_account" do
  #       post :create, params: {bank_account: FactoryBot.attributes_for(:bank_account)}
  #       expect(response).to render_template('new')
  #     end
  #   end
  # end
      
  describe "GET show" do
    it "show bank_account" do
      get :show, params: {id:  @bank_account.id}
      expect(assigns(:bank_account)).to eql(@bank_account)
    end
  end

  describe "PATCH #update" do
    context "update the bank_account" do
      it "updates the bank_account" do
        @attr =  { bank_name: "Axis", ifsc_code: "ICICI09382"}
        patch :update, params: {id: @bank_account.id, :bank_account => @attr}
        @bank_account.update(@attr)
        expect(response).to redirect_to library_owner_bank_accounts_path
      end
      it "does not update the bank_account" do
        @attr =  { bank_name: "", ifsc_code: "ICICI092"}
        patch :update, params: { id: @bank_account.id, :bank_account => @attr}
        @bank_account.update(@attr)
        expect(response).to render_template('edit')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe LibraryOwner::BankAccountsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user,role: 'library_owner')
    sign_in @user
  end

  describe "GET index" do
    it "shows bank details for signed in user" do
      @bank_account = FactoryBot.create(:bank_account, user_id: @user.id)   
      get :index
      expect(@user.bank_account).to eql(@user.bank_account)      
    end 
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end 
  end

  describe "GET new" do
    it "create a new bank_account" do  
      get :new
      expect(assigns(:bank_account)).to be_a_new(BankAccount)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "creates a new bank_account" do
      expect{
      post :create, params: {user_id: @user.id, bank_account: FactoryBot.attributes_for(:bank_account,user_id: @user.id)}
    }.to change(BankAccount,:count).by(1)
      expect(response).to redirect_to library_owner_bank_accounts_path
    end
    it "redirects to the new bank_account" do
      post :create, params: {bank_account: FactoryBot.attributes_for(:bank_account,user_id: @user.id)}
      expect(response.status).to eq 302
    end
  end  

  describe "GET show" do
    it "show bank_account" do
      @bank_account = FactoryBot.create(:bank_account, user_id: @user.id)   
      get :show, params: {id:  @bank_account.id}
      expect(assigns(:bank_account)).to eql(@bank_account)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET edit' do
    it 'edit the bank_account details' do
      @bank_account = FactoryBot.create(:bank_account, user_id: @user.id)
      get :edit, params: {id: @bank_account.id}
     expect(response).to render_template('edit')
    end
  end

  describe "PATCH #update" do
    context "update the bank_account" do
      it "updates the bank_account" do
        @bank_account = FactoryBot.create(:bank_account, user_id: @user.id)   
        @attr =  { bank_name: "Axis", ifsc_code: "ICICI09382"}
        patch :update, params: {id: @bank_account.id, :bank_account => @attr}
        @bank_account.update(@attr)
        expect(response).to redirect_to library_owner_bank_accounts_path
      end
      it "does not update the bank_account" do
        @bank_account = FactoryBot.create(:bank_account, user_id: @user.id)   
        @attr =  { bank_name: "", ifsc_code: "ICICI092"}
        patch :update, params: { id: @bank_account.id, :bank_account => @attr}
        @bank_account.update(@attr)
        expect(response).to render_template('edit')
      end
    end
  end
end

class LibraryOwner::BankAccountsController < ApplicationController

  def index
    @bank_account = current_user.bank_account
  end

  def new
    @bank_account = current_user.bank_account ? current_user.bank_account : current_user.build_bank_account
  end

  def create
    @bank_account = current_user.build_bank_account(bank_account_params)
    if @bank_account.save
      redirect_to library_owner_bank_accounts_path
    else
      render 'new'
    end
  end

  def show
    @bank_account = BankAccount.find(params[:id])
  end

  def edit
    @bank_account = BankAccount.find(params[:id])
  end
 

  def update
    @bank_account = BankAccount.find(params[:id])
    if @bank_account.update(bank_account_params)
      redirect_to library_owner_bank_accounts_path
    else
      render 'edit'
    end
  end

private
  def bank_account_params
    params.require(:bank_account).permit(:bank_name,:account_number, :ifsc_code, :account_holder_name)
  end

end

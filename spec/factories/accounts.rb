FactoryBot.define do
  factory :account do
    account_number { 123 }
    account_name { 'Fausto Silva' }
    initial_balance { 5000 }
    token { 'MyDuMMyToKeN' }
  end
end

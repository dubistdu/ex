require 'rack/test'
require 'json'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do
    include Rack::Test::Methods
    it 'records sumitted expenses' do
      coffee = {
        'payee' => 'Star Bucks',
        'amount' => 5.75,
        'date' => '2017-06-10'
      }
      post '/expenses',
JSON.generte(coffee)
    end
  end
end

# Because  JSON object convert to Ruby hashs, our example also will have string keys
# ex) instead of {payee: 'Star Bucks'}, it's {'payee' => 'Star Bucks'}

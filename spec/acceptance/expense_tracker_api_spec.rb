require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do
    include Rack::Test::Methods
    def app
      ExpenseTracker::API.new
    end
    it 'records sumitted expenses' do
      coffee = {
        'payee' => 'Star Bucks',
        'amount' => 5.75,
        'date' => '2017-06-10'
      }
      post '/expenses', JSON.generate(coffee)
      expect(last_response.status).to eq(200)

      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('expense_id'=> a_kind_of(Integer))

    end
  end
end

# Because  JSON object convert to Ruby hashs, our example also will have string keys
# ex) instead of {payee: 'Star Bucks'}, it's {'payee' => 'Star Bucks'}
# used last_response method which is provided by spec
# expect() to()“check a result in order to signal success or failure. They compare a value—in this case,
# the HTTP status code returned by last_response.status—using a matcher”

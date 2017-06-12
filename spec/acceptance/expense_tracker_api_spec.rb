require 'rack/test'
require 'json'
require_relative '../../app/api'


module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do
    include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end

    def post_expense(expense)
      post '/expenses', JSON.generate(expense)
      expect(last_response.status).to eq(200)

      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('expense_id' => a_kind_of(Integer))
      expense.merge('id' => parsed['expense_id'])
    end

    it 'records submitted expenses' do
      coffee = post_expense(
        'payee'  => 'Starbucks',
        'amount' => 5.75,
        'date'   => '2017-06-10'
      )

      zoo = post_expense(
        'payee'  => 'Zoo',
        'amount' => 15.25,
        'date'   => '2017-06-10'
      )

      groceries = post_expense(
        'payee'  => 'Whole Foods',
        'amount' => 95.20,
        'date'   => '2017-06-11'
      )
      # POST coffee, zoo, and groceries expenses here

      get '/expenses/2017-06-10'
      expect(last_response.status).to eq(200)

      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(coffee, zoo)
    end
  end
end


# Because  JSON object convert to Ruby hashs, our example also will have string keys
# ex) instead of {payee: 'Star Bucks'}, it's {'payee' => 'Star Bucks'}
# used last_response method which is provided by spec
# expect() to()“check a result in order to signal success or failure. They compare a value—in this case,
# the HTTP status code returned by last_response.status—using a matcher”

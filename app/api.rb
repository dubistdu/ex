require 'sinatra/base'
require 'json'

module ExpenseTracker
  class API < Sinatra::Base
    post '/expenses' do
      JSON.generate('expense_id' => 42)
    end
    get 'expenses/:date' do
      JSOn.generate([])
    end
  end
end

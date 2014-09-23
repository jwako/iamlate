require 'rails_helper'

describe Iamlate do

  context 'basic instantiation' do
    it 'should work' do
      lambda do
        @client = Iamlate::API.new({:access_key => 'your_access_key'})
      end.should_not raise_error
    end
  end
end

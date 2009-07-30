require File.dirname(__FILE__) + '/../../spec_helper'

describe 'S3.get_service' do

  before(:all) do
    s3.put_bucket('foggetservice')
  end

  after(:all) do
    s3.delete_bucket('foggetservice')
  end

  it 'should return proper_attributes' do
    actual = s3.get_service
    actual.body['Buckets'].should be_an(Array)
    bucket = actual.body['Buckets'].select {|bucket| bucket['Name'] == 'foggetservice'}.first
    bucket['CreationDate'].should be_a(Time)
    bucket['Name'].should == 'foggetservice'
    owner = actual.body['Owner']
    owner['DisplayName'].should be_a(String)
    owner['ID'].should be_a(String)
  end

  it 'should include foggetservice in get_service' do
    eventually do
      actual = s3.get_service
      actual.body['Buckets'].collect { |bucket| bucket['Name'] }.should include('foggetservice')
    end
  end

end

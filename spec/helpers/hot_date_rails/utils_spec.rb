require 'spec_helper'
describe HotDateRails::Utils do
	describe "deprecate method" do
	  it { should respond_to(:deprecate) }
	  # it "passes the call from the deprecated methods to the new method" do
	  # 	binding.pry
	  # end
	end
end
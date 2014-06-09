require 'spec_helper'

describe List do
	before { @list = List.new(name: "test list")}
	subject { @list }
	
 it { should respond_to(:name)}
 it { should be_valid }






end

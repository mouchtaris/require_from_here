require 'spec_helper'

describe RequireFromHere do
  it 'has a version number' do
    expect(RequireFromHere::VERSION).not_to be nil
  end

  describe '#install_on' do

    it 'requires files that are not found in LOAD_PATH' do
      Module.new do
        RequireFromHere.install_on {}
        require_from_here 'test', 'a', 'b', 'c', 'i_exist'
      end
      expect(Object.const_defined?(:I_EXIST)).to eq(true)
    end

    it 'should raise an argument error when no block is given' do
      expect {
        Module.new do RequireFromHere.install_on end
      }.to raise_error(ArgumentError, "An empty block (such as '{}') should be provided")
    end

    it 'should raise an argument error when not called from a module' do
      expect {
        Object.new.instance_exec do RequireFromHere.install_on{} end
      }
      .to raise_error(ArgumentError, 'should be called for Modules only')
    end

  end

end

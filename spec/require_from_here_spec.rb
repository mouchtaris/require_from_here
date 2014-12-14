require 'spec_helper'

describe RequireFromHere do
  it 'has a version number' do
    expect(RequireFromHere::VERSION).not_to be nil
  end

  describe '.install_on' do

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
      }.to raise_error(ArgumentError, 'should be called for Modules only')
    end

    it 'should raise an argument error when reinstalled on the same target' do
      expect {
        mod = Module.new do RequireFromHere.install_on{} end
        mod.module_exec do RequireFromHere.install_on{} end
      }.to raise_error(ArgumentError, /^already installed on (?<target>\S+) with base-path (?<path>.+)$/)
    end

  end



  describe '.require_from_here' do

    it 'should raise an argument error when "arguments" are not strings' do
      rfh = RequireFromHere.method :require_from_here
      mtc = raise_error(ArgumentError, "path elements must be strings")

      expect { rfh.() {       } }.to mtc
      expect { rfh.() {  :he  } }.to mtc
      expect { rfh.() { [:he] } }.to mtc
      expect { rfh.() { [   ] } }.to mtc

    end

    it 'should require files that are not found in LOAD_PATH' do
      RequireFromHere.require_from_here {%w[ test a b c i_exist ]}
      expect(Object.const_defined?(:I_EXIST)).to eq(true)
    end

  end



  describe '.from_here' do

    it 'should require files that are not found in LOAD_PATH' do
      RequireFromHere.from_here do
        require *%w[ test a b c i_exist ]
      end
      expect(Object.const_defined?(:I_EXIST)).to eq(true)
    end

  end

end

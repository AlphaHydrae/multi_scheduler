require 'helper'

describe MultiScheduler do
  let(:launchd_double){ double start: true, stop: true }
  let(:whenever_double){ double start: true, stop: true }
  subject{ MultiScheduler }

  before :each do
    MultiScheduler::Launchd.stub new: launchd_double
    MultiScheduler::Whenever.stub new: whenever_double
    @host_os = RbConfig::CONFIG['host_os']
  end

  after :each do
    RbConfig::CONFIG['host_os'] = @host_os
  end

  it "should create a launchd schedule on darwin hosts" do
    RbConfig::CONFIG['host_os'] = 'darwin12.5.0'
    expect(MultiScheduler::Whenever).not_to receive(:new)
    expect(MultiScheduler::Launchd).to receive(:new).with('foo', bar: 'baz')
    expect(subject.schedule('foo', bar: 'baz')).to be(launchd_double)
  end

  it "should create a whenever schedule on other hosts" do
    RbConfig::CONFIG['host_os'] = 'linux-gnu'
    expect(MultiScheduler::Launchd).not_to receive(:new)
    expect(MultiScheduler::Whenever).to receive(:new).with('foo', bar: 'baz')
    expect(subject.schedule('foo', bar: 'baz')).to be(whenever_double)
  end

  it "should raise an error for unsupported hosts" do
    RbConfig::CONFIG['host_os'] = 'unsupported'
    expect{ subject.schedule 'foo', bar: 'baz' }.to raise_error
  end
end

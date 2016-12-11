require_relative '../../helper_spec.rb'

describe command('while /usr/local/bin/fly -t kitchen builds | grep started > /dev/null; do echo "jobs still running"; sleep 2; done') do
  it 'No pending jobs' do
    expect(subject.exit_status).to eq(0)
  end
end

describe command('/usr/local/bin/fly -t kitchen builds | grep succeeded | wc -l') do
  it 'some concourse pipelines should be succeeded' do
    expect(subject.stdout).to match('2')
    expect(subject.exit_status).to eq(0)
  end
end

describe command('/usr/local/bin/fly -t kitchen builds | grep failed | wc -l') do
  it 'some concourse pipelines should be failed' do
    expect(subject.stdout).to match('2')
    expect(subject.exit_status).to eq(0)
  end
end

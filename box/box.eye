# vim:syntax=ruby

Eye.config do
  logger '/var/log/sandbox/eye.log'
end

Eye.application 'sandbox' do
  working_dir '/var/run/box'
  trigger :flapping, times: 10, within: 1.minute, retry_in: 10.minutes
  stdall 'trash.log' # stdout,err logs for processes by default

  # eye daemonized process
  process :box do
    pid_file 'box.pid' # pid_path will be expanded with the working_dir
    start_command '/usr/bin/ruby -I /opt/box/vendor/bundle/ruby/1.9.1/gems/ /opt/box/box'

    # when no stop_command or stop_signals, default stop is [:TERM, 0.5, :KILL]
    # default `restart` command is `stop; start`

    daemonize true
  end

end

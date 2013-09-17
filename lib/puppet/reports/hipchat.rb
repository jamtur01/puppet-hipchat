require 'puppet'
require 'yaml'

begin
  require 'hipchat'
rescue LoadError => e
  Puppet.info "You need the `hipchat` gem to use the Hipchat report"
end

Puppet::Reports.register_report(:hipchat) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "hipchat.yaml"])
  raise(Puppet::ParseError, "Hipchat report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  HIPCHAT_API = config[:hipchat_api]
  HIPCHAT_ROOM = config[:hipchat_room]
  HIPCHAT_NOTIFY = config[:hipchat_notify]
  HIPCHAT_STATUSES = Array(config[:hipchat_statuses] || 'failed')
  # set the default color as yellow if not defined
  HIPCHAT_NOTIFY_COLOR = config[:hipchat_notify_color] || 'yellow'
  DISABLED_FILE = File.join([File.dirname(Puppet.settings[:config]), 'hipchat_disabled'])
  HIPCHAT_PROXY = config[:hipchat_proxy]


  desc <<-DESC
  Send notification of failed reports to a Hipchat room.
  DESC

  def process
    # Disabled check here to ensure it is checked for every report
    disabled = File.exists?(DISABLED_FILE)

    if (HIPCHAT_STATUSES.include?(self.status) || HIPCHAT_STATUSES.include?('all')) && !disabled
      Puppet.debug "Sending status for #{self.host} to Hipchat channel #{HIPCHAT_ROOM}"
        msg = "Puppet run for #{self.host} #{self.status} at #{Time.now.asctime}"
        client = HipChat::Client.new(HIPCHAT_API, :http_proxy => HIPCHAT_PROXY)
        client[HIPCHAT_ROOM].send('Puppet', msg, :notify => HIPCHAT_NOTIFY, :color => HIPCHAT_NOTIFY_COLOR)
    end
  end
end

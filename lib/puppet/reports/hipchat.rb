require 'puppet'
require 'yaml'

begin
  require 'hipchat'
rescue LoadError
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

  # set the default colors if not defined in the config
  HIPCHAT_FAILED_COLOR = config[:failed_color] || 'red'
  HIPCHAT_CHANGED_COLOR = config[:successful_color] || 'green'
  HIPCHAT_UNCHANGED_COLOR = config[:unchanged_color] || 'gray'

  DISABLED_FILE = File.join([File.dirname(Puppet.settings[:config]), 'hipchat_disabled'])
  HIPCHAT_PROXY = config[:hipchat_proxy]

  if HIPCHAT_PROXY && (RUBY_VERSION < '1.9.3' || Gem.loaded_specs["hipchat"].version < '1.0.0')
    raise(Puppet::SettingsError, "hipchat_proxy requires ruby >= 1.9.3 and hipchat gem >= 1.0.0")
  end

  desc <<-DESC
  Send notification of puppet runs to a Hipchat room.
  DESC

  def color(status)
    case status
    when 'failed'
      HIPCHAT_FAILED_COLOR
    when 'changed'
      HIPCHAT_CHANGED_COLOR
    when 'unchanged'
      HIPCHAT_UNCHANGED_COLOR
    else
     'yellow'
    end
  end

  def emote(status)
    case status
    when 'failed'
      '(failed)'
    when 'changed'
      '(successful)'
    when 'unchanged'
      '(continue)'
    end
  end

  def process
    # Disabled check here to ensure it is checked for every report
    disabled = File.exists?(DISABLED_FILE)

    if (HIPCHAT_STATUSES.include?(self.status) || HIPCHAT_STATUSES.include?('all')) && !disabled
      Puppet.debug "Sending status for #{self.host} to Hipchat channel #{HIPCHAT_ROOM}"
        msg = "Puppet run for #{self.host} #{emote(self.status)} #{self.status} at #{Time.now.asctime} on #{self.configuration_version} in #{self.environment}"
        if HIPCHAT_PROXY
          client = HipChat::Client.new(HIPCHAT_API, :http_proxy => HIPCHAT_PROXY)
        else
          client = HipChat::Client.new(HIPCHAT_API)
        end
        client[HIPCHAT_ROOM].send('Puppet', msg, :notify => HIPCHAT_NOTIFY, :color => color(self.status), :message_format => 'text')
    end
  end
end

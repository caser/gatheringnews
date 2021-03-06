if Rails.env.production?
  Lobsters::Application.config.middleware.use ExceptionNotification::Rack,
    :ignore_exceptions => [
      "ActionController::UnknownFormat",
      "ActionController::BadRequest",
      "ActionDispatch::RemoteIp::IpSpoofAttackError",
    ] + ExceptionNotifier.ignored_exceptions,
    :email => {
      :email_prefix => "[Gathering News] ",
      :sender_address => %{"Exception Notifier" <exceptions@gatheringlab.com>},
      :exception_recipients => %w{casey@gatheringlab.com},
    }

  Twitter.CONSUMER_KEY = ENV.fetch('TWITTER_CONSUMER_KEY', 'secret')
  Twitter.CONSUMER_SECRET = ENV.fetch('TWITTER_CONSUMER_SECRET', 'secret')
  Twitter.AUTH_TOKEN = ENV.fetch('TWITTER_AUTH_TOKEN', 'secret')
  Twitter.AUTH_SECRET = ENV.fetch('TWITTER_AUTH_SECRET', 'secret')

  BCrypt::Engine.cost = 12
end

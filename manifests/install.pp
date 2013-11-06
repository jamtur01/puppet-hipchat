class puppet_hipchat::install {

  include puppet_hipchat::params

  package { "hipchat":
    ensure   => installed,
    provider => $puppet_hipchat::params::provider,
  }
}

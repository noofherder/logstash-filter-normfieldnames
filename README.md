# Logstash Normfieldnames Plugin

This is a plugin for [Logstash](https://github.com/elastic/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

This filter will rename fields which contain non-alphanumeric characters (and underscores) using the rules:

    1. spaces are replaced by _
    2. other non-alphanumeric chars are replaced by their hex ASCII repr
    3. if the resulting fieldname is already present, _s are appended

FIXME: this filter expects ASCII. Unknown how it would deal with Unicode.

## Installation

- Update your dependencies
```sh
bundle install
```

- Run tests
```sh
bundle exec rspec
```

- Build plugin gem
```sh
gem build logstash-filter-awesome.gemspec
```

- Install the plugin from the Logstash home
```sh
bin/plugin install /your/local/plugin/logstash-filter-awesome.gem
```

- Start Logstash and proceed to test the plugin

## Contributing

All contributions are welcome.

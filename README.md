yp
==

YellowPages: a lightweight telephone directory

Setting Up
---
```bash
gem install bundler
git clone https://github.com/noahsilas/yp.git
cd yp
bundle install
```


Running the YP server
---
From the project root:

```bash
bundle exec ruby yp.rb
```


Running tests
---
```bash
bundle exec rspec
```


Twilio Configuration
---
Voice Request Url: <HostName>/twilio/incoming

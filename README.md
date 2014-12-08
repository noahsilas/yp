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


Configuration
---
YP is configured via environment variables, as a
[Twelve-Factor App](http://12factor.net/). It reads a CSV from the web to
populate the directory. We expect the first row to have headers 'Name' and
'Phone'. Pass the URL for this CSV to the application as `YP_PHONEBOOK_URI`.

```bash
export YP_PHONEBOOK_URI='http://example.com/directory.csv'
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

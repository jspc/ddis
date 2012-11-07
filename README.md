ddis
==

Install
--

Gem is over at https://rubygems.org/gems/ddis so a simply `gem install ddis` will do the trick.

Else build it from source.

Usage
--

Due to needing stupid rights to stupid ping one must run under root. Stupid root.

```bash
# ddis -h
Usage: ddis [options]
    -r, --range [IP RANGE]           IP Range to scan against
    -u, --unass [UNASSIGNED STRING]  Text contained in unassigned IPs
    -c, --count [NUMBER]             Number of times to run through
    -s, --sleep [SECONDS]            Number of seconds to sleep between runs
    -v, --verbose                    See extra debug
```

The defaults are:

```ruby
ip_range = '127.0.0.1/24'
unassign = 'localhost'
count    = 1
secs     = 0
verbose  = nil
```

For the network `10.1.0.0/16` which uses the PTR format `unassigned-0.0.1.10.example.com` we would start as per:

```bash
# ddis -r 10.1.0.0/16 -u unassigned
```

Should we want to run this over a few days to collate the results:

```bash
# ddis -r 10.1.0.0/16 -u unassigned -c 500 -s 10
```

Which would run 500 times with a ten second break between each iteration.


Data
--

The data is stored under redis following the schema:

```redis
ip.#{date.now.to_s}.up      # Hosts which are up and have a PTR as per =~ /#{unass}/
ip.#{date.now.to_s}.down    # Hosts whhich are down but don't have a PTR which has been reset
```

A list of times can be found under `ip.times`; the `date.now.to_s` is set when the object is created and not each time. This gives us
th econfidence that leaving ddis over multiple days wont bork our data by spreading it all over.

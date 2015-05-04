# Knife::Tagbatch

Tagbatch is a plugin for the Chef Knife tool (https://docs.chef.io/knife.html). It adds search functionality to knife tag and allows the execution of multiple tag additions or removals in one statement. There is a flag for logging and dry-run execution.

## Installation

Gem installation:
  `gem install knife-tagbatch`

Manual installation:
  Clone https://github.com/nkaravias/knife-tagbatch.git
  Create ~/.chef/knife/plugins
  Copy lib/chef/knife/tagbatch.rb to plugins


## Usage

knife tag batch <operation> <tag string> <knife search regexp> | -l | -d 

Allowed operations are add | remove for creating and removing Chef tags

e.g Add the 'webserver' tag to all nodes that have the web-server role on environment x.
knife tag add webserver 'role:web-server AND chef_environment=x'

Optional arguments:

-l (Logging): Knife will write the output of the tag operation per node on tagBatch.log in the current working directory
-d (dry run): Knife will execute the operation but will not save the results (tag creation / removal) on the node

## Contributing

1. Fork it ( https://github.com/nkaravias/knife-tagbatch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

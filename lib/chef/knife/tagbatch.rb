require "knife-tagbatch/version"

module CustomChef
  module KnifeTagBatch
  class TagBatch < Chef::Knife
    deps do
      require 'chef/node'
      require 'chef/search/query'
    end
# Don't save the changes to the node object
option :dry_run,
  :short => "-d",
  :long => "--dry-run",
  :description => "Don't save the node changes",
  :boolean => true | false,
  :default => false

# Log tagging log to ./batch-tag.log
option :batch_log,
  :short => "-l",
  :long => "--batch-log",
  :description => "Write batch results to $CWD/tagBatch.log",
  :boolean => true | false,
  :default => false

  banner "knife tag batch add|remove TAG SEARCH_QUERY"
  
  def run
    @command = validate_arg(@name_args[0], 'command', /^add$|^remove$/)
    @tag = validate_arg(@name_args[1],'tag',/[\w-]*/)
    @search_query = validate_arg(@name_args[2], 'search', /[\w]*:[\w*-]*(\sAND\s|\sOR\s|\sNOT\s)*/)
    @query_nodes = Chef::Search::Query.new.search('node', @search_query)
    ui.msg "Search returned #{@query_nodes.last} node(s)"
    if @query_nodes.last > 0
			ui.confirm("Execute command \"#{@command}\" with tag #{@tag} on #{@query_nodes.last} node(s)?", append_instructions=true)
    elsif @query_nodes.last == 0
      ui.warn('No nodes returned from search')
    else
      ui.fatal('Invalid return from search')
    end

    @query_nodes[0].each do |node|    
      self.send("#{@command}_tag",node,@tag)
    end 
    ui.msg('Operation completed')
  end

  def add_tag(node, tag)
    if node.tags.include?(tag)
      log	= "#{Time.now.getutc}:#{node.name} already has tag \"#{@tag}\""
    else
      node.tags << tag
      unless config[:dry_run]
        node.save      			
      end
      log = "#{Time.now.getutc}:Created tag \"#{@tag}\" on #{node.name}"
    end
    if config[:batch_log] 
      log_node(log) 
    end  	
  end

    def remove_tag(node, tag)
      if node.tags.include?(tag)    	
    	  node.tags.delete(tag)
        unless config[:dry_run]
      	  node.save      			
        end
        log = "#{Time.now.getutc}:Removed tag \"#{@tag}\" on #{node.name}"    
      else
        log = "#{Time.now.getutc}:The tag \"#{@tag}\" does not exist on #{node.name}"  
      end	
      	if config[:batch_log] 
      		log_node(log) 
      	end  	      
    end

    def log_node(str)
    	log_filename = 'tagBatch.log'
      File.open(log_filename, 'a') do |file|
      	file.puts str
  		end
    end    

    def validate_arg(arg, type, pattern)
    	unless arg =~ pattern
    		show_usage
    		ui.fatal "Argument #{type}:#{arg} is not valid"
    		exit 1
    	end
    	arg
    end
  end
  end
end

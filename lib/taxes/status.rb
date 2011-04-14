# This class then lets you programitcally set metadata to be used in
# different places (e.g. select boxes, labels, etc.)
#
#  class Order::Status < Universo::Status
#  end
#
#  Order::OPEN       = Order::Status.new('o', 'Open', 'Open - You have not yet checked out')
#  Order::SUBMITTED  = Order::Status.new('s', 'Submitted', 'Submitted - We have received your order')
#  Order::PROCESSING = Order::Status.new('p', 'Processing', 'Processing - We are processing your order')
#  Order::WAREHOUSE  = Order::Status.new('w', 'Warehouse', 'Sending - We are preparing your shipment')
#  Order::SHIPPED    = Order::Status.new('x', 'Shipped', 'Shipped - Your order has shipped')
#  Order::CANCELLED  = Order::Status.new('c', 'Cancelled', 'Cancelled')
#  Order::SHIPPED       = Order::Status.new('d', 'Complete', 'Complete - Your order has shipped and is now complete')
#
# YOU MUST SUBCLASS TO USE 
#
module Taxes
  class Status 

    @@data = {}

    attr_reader :key, :label, :public_label, :sort_index
    def initialize(key, label, public_label = nil, sort_index = nil)
      @key = key
      @label = label
      @public_label = public_label || label
      @sort_index = sort_index
      status_cache[@key] = self
      status_list << self
    end
    
    def self.keys
      self.status_cache(self.name).keys
    end
    
    def Status.all
      status_list(self.name)
    end
    
    def Status.lookup(key)
      status_cache(self.name)[key]
    end

    def Status.lookup_label(key, default=nil)
      if o = status_cache(self.name)[key]
        return o.label
      else
        return default
      end
    end

    def Status.lookup_by_label(label)
      all.each do |i|
        return i if i.label == label
      end
      nil
    end

    # Support for views, e.g.:
    #
    # <%= select_tag :status, Rma::Status.optionlist(:selected => @status, :nil_label => '-- Select --') -%>
    # <%= select_tag :status, Rma::Status.optionlist(:selected => @status, :nil_label => '-- Select --', :additional => [ [@active_status, @active_status] ]) -%>
    #
    def Status.optionlist(opts = {})
      pairs = []
      all.each do |i|
        pairs << [i.label, i.key, i.sort_index] unless opts[:exclude_keys] && opts[:exclude_keys].include?(i.key)
      end
      pairs << ['All', 'all', -1] if opts[:include_all]
      pairs.sort! do |a, b|
        if 0 != (cmp = (a[2] || 0) <=> (b[2] || 0))
          cmp
        else
          a[0] <=> b[0]
        end
      end
      Util.gilt_options_for_select(pairs, opts)
    end

    def Status.option_choices
      pairs = []
      all.each do |i|
        pairs << [i.label, i.key]
      end
      return pairs
    end

    def to_s
      key
    end

    private
    def status_cache
      Status.status_cache(self.class.name)
    end

    def Status.status_cache(class_name)
      cache = class_data(class_name)[:status_cache]
      if cache.nil?
        cache = {}
        class_data(class_name)[:status_cache] = cache
      end
      cache
    end

    def status_list
      Status.status_list(self.class.name)
    end

    def Status.status_list(class_name)
      l = Status.class_data(class_name)[:status_list]
      if l.nil?
        l = []
        class_data(class_name)[:status_list] = l
      end
      l
    end

    def Status.class_data(class_name)
      hash = @@data[class_name]
      if hash.nil?
        hash = {}
        @@data[class_name] = hash
      end
      hash
    end

  end
end
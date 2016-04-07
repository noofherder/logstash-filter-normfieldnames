# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# This filter will rename fields which contain non-alphanumeric characters
# (and underscores) using the rules:
#
#     1. spaces are replaced by _
#     2. other non-alphanumeric chars are replaced by their hex ASCII repr
#     3. if the resulting fieldname is already present, _s are appended
#
# FIXME: expects ASCII. Unknown how it would deal with Unicode.
#
class LogStash::Filters::NormFieldnames < LogStash::Filters::Base

  config_name "normfieldnames"

  public
  def register
  end # def register

  public
  def filter(event)

    # iterate the fieldnames
    event.to_hash.keys.each do |key|

      # generate a (possibly) new fieldname
      newkey = key.gsub(/\W/) { |match|
        match == " " ? "_" : "%02x" % match.ord
      }

      if newkey != key
        # ensure the name is unique
        while event.include? newkey
          newkey << "_"
        end

        # replace the old key with the new one
        event[newkey] = event[key]
        event.remove(key)
      end
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter

end # class LogStash::Filters::Normfieldnames

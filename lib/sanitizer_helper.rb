module SanitizerHelper
    def self.sanitize_states(str)
        str.gsub!(/_/, ' ')
        str.strip!
    end

    def self.sanitize_zones(str)
        # remove strings with ' dan '
        str.gsub!(/[\u00a0\s]dan[\u00a0\s]/, ',')
        # remove all types of whitespaces
        str.gsub!(/[\u00a0\s]/, '')
        # remove brackets
        str.gsub!(/[()]/, '')
        # remove the word 'Zon' and its number
        str.gsub!(/[0-9]|Zon/, '') if str.downcase.include? "zon"
        # add spacing between exclusive names
        str = str.split(',').map! {|s| s.split(/(?=[A-Z])/).join(' ');}
        # join all strings back with comma
        str = str.join(',')
    end

    def self.sanitize_prayer_time(str)
        return str.gsub(/[\.]+/, ':')
    end
end

class Ansispan
  @foreground_colors = {
    '30': 'black',
    '31': 'red',
    '32': 'green',
    '33': 'yellow',
    '34': 'blue',
    '35': 'purple',
    '36': 'cyan',
    '37': 'white'
  }

  def self.convert(str)
    @foreground_colors.keys.each do |ansi|
      span = '<span style="color: ' + @foreground_colors[ansi] + '">'
      #
      # `\033[Xm` == `\033[0;Xm` sets foreground color to `X`.
      #
  
      str = str.gsub(/\033\[#{ansi}m/, span)
        .gsub(/\033\[#{ansi}m/, span)
    end

    #
    # `\033[1m` enables bold font, `\033[22m` disables it
    #
    str = str.gsub(/\033\[1m/, '<b>')
      .gsub(/\033\[22m/, '</b>')
  

    # Bold colors
    @foreground_colors.keys.each do |ansi|
      span = '<span style="font-weight: bold; color: ' + @foreground_colors[ansi] + '">'
      str = str.gsub(/\033\[1;#{ansi}m/, span)
    end

    # Underline colors
    @foreground_colors.keys.each do |ansi|
      span = '<span style="text-decoration: underline; color: ' + @foreground_colors[ansi] + '">'
      str = str.gsub(/\033\[4;#{ansi}m/, span)
    end
    #
    # `\033[3m` enables italics font, `\033[23m` disables it
    #
    str = str.gsub(/\033\[3m/, '<i>')
      .gsub(/\033\[23m/, '</i>')
  
    str = str.gsub(/\033\[m/, '</span>');
    str = str.gsub(/\033\[0m/, '</span>');
    return str.gsub(/\033\[39m/, '</span>');
  end
end

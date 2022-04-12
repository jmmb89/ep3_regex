#!/bin/ruby

### SENAC BCC - LFA - EP03 ###

#https://www.rubyguides.com/2015/06/ruby-regex/

def get_tags(msg)
  regex_tag = '\#\w+'
  return msg.match(regex_tag)
end

def get_who(msg)
  regex_who = '((?<=[cC]om) \w*)((\s?[eE,]\s?(\w*))+)*'
  return msg.match(regex_who)
end

=begin
def convert_time(time)
  #puts("TIME = #{time.to_s}")
  if time.to_s.match('(2[0-3]|1[0-9]|0?[0-9])(?=pat\s?[Hh]oras)?')
    n_time = time.to_s.match('([0-9])?[0-9]')
    return n_time.to_s + ":00" 
  end
end
=end

def get_time(msg)
  #regex_time = '([àaÀA][sS])\s([0-9])([0-9])(:?)\s?([0-9]?)([0-9]?)\s?(horas?)?'
  regex_time = '(?<=[àaÀA][sS]\s)((2[0-3])|(1[0-9]|0?[0-9]))([\s:]?)([0-5]?)([0-9]?)\s?(horas?)?'
  return msg.match(regex_time)
end

def get_date(msg)
  regex_when = '([Aa]manh[ãa]|[Dd]epois de [Aa]manh[aã]|[Hh]oje)'
  regex_data_num = '(3[01]|[12][0-9]|0?[1-9])[-:\/](1[0-2]|0?[1-9])[-:\/](\d{4}|\d{2})'
  regex_data_esc = '(3[01]|[12][0-9]|0?[1-9])\sde\s([Jj]aneiro|[Ff]evereiro|[Mm]ar[çc]o|[Aa]bril|[Mm]aio|[Jj]unho|[Jj]ulho|[Aa]gosto|[Ss]etembro|[Oo]utubro|[Nn]ovembro|[Dd]ezembro)'
  
  time = Time.new()
  data_num = msg.match(regex_data_num)
  data_esc = msg.match(regex_data_esc)
  data_day = msg.match(regex_when).to_s.downcase()

  if data_day.match('[Hh]oje') then
    date = "#{time.day}/#{time.month}/#{time.year}"
    return date
  elsif data_day.match('[Dd]epois de [Aa]manh[aã]')
    dpamanha = time + 172800
    date = "#{dpamanha.day}/#{dpamanha.month}/#{dpamanha.year}"
    return date
  elsif data_day.match('[Aa]manh[aã]')
    amanha = time + 86400
    date = "#{amanha.day}/#{amanha.month}/#{amanha.year}"
    return date
  end
  
  if data_num != nil then
    return data_num
  elsif data_esc != nil then
    return data_esc
  end

  return ""
end

def print_data(msg)
  puts("\nDia: #{get_date(msg)}")
  puts("Horario: #{get_time(msg)}")
  puts("Pessoa: #{get_who(msg)}")
  puts("tag: #{get_tags(msg)}")
end

msg = ""
regex_quit = '^([Qq]|[Qq]uit)$'

puts("\nSENAC BCC - LFA - EP3\n")

while not msg.match(regex_quit) do
  
  puts("\nInsira a mensagem ou digite quit para sair")
  msg = gets
  if not msg.match(regex_quit) then
    print_data(msg)
  end
end

puts("\nBoa semana professor!\n\nAlunos:\nJoao Barradas & Leandro Borges\n\n")

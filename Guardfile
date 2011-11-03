# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'shell' do
  watch(%r{^Classes/.+$}) {
    `rake doc`
    puts "Recompiled docs"
  }
end

class PngCompressor < Compressor
   
  def initialize
    super('png')
    set_command(:pngcrush,'%executable% -q -rem alla -brute -reduce  %input% %output%')

  end
 
end



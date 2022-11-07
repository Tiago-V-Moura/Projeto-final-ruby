class Salvar_Arquivo
	
	def gravar(msg_original, msg_traduzida)

		marcador = '-'*40

		time = Time.now.strftime("%d-%m-%Y_%H;%M")

		# Caso a pasta log nao exista, criar
		folder_log = 'log'
		Dir.mkdir(folder_log) unless Dir.exist?(folder_log)
		
		# puts "sera gravado em #{folder_log}"
		File.open("#{folder_log}/#{time.to_s}.txt", "a") do |line|
			line.puts("#{marcador}\nMensagem Original: #{msg_original}\nMensagem Traduzida: #{msg_traduzida}\n#{marcador}")
		end
		return "#{folder_log}/#{time.to_s}.txt"
	end

	def imprimir(log)
		File.exist?(log)
		puts log
		# folder_log = 'log'
		file = File.open(log)

		file.each do |line|
			puts line
		end
		
	end
end
